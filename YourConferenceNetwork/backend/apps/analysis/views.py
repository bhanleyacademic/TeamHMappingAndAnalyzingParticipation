"""
Analysis API views.

Phase 1: dataset CRUD + status polling (stubs for analysis endpoints).
Phase 2: full pipeline — chart, dashboard, exports, Kumu JSON.
"""
import csv
import io
from django.http import StreamingHttpResponse, HttpResponse
from django.shortcuts import get_object_or_404
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response

from apps.api.permissions import IsSubscribed
from .models import Dataset, Attendance
from .serializers import DatasetSerializer


# ---------------------------------------------------------------------------
# Dataset CRUD
# ---------------------------------------------------------------------------

@api_view(['GET', 'POST'])
@permission_classes([IsAuthenticated])
def dataset_list_create(request):
    if request.method == 'GET':
        datasets = Dataset.objects.filter(user=request.user, is_deleted=False)
        return Response(DatasetSerializer(datasets, many=True).data)

    # POST — create a new dataset
    # Check free-tier limit (1 dataset max without subscription),
    # unless the site-wide free_tier_override is enabled.
    from apps.api.site_settings import is_free_tier_override
    if not is_free_tier_override():
        existing_count = Dataset.objects.filter(user=request.user, is_deleted=False).count()
        try:
            is_paid = request.user.subscription.is_paid_active
        except Exception:
            is_paid = False

        if not is_paid and existing_count >= 1:
            return Response(
                {'detail': 'Free tier is limited to 1 dataset. Upgrade to add more.'},
                status=status.HTTP_402_PAYMENT_REQUIRED,
            )

    serializer = DatasetSerializer(data=request.data)
    serializer.is_valid(raise_exception=True)
    dataset = serializer.save(user=request.user, status='pending')

    # Trigger async Celery processing
    from .tasks import process_upload
    process_upload.delay(dataset.id)

    return Response(DatasetSerializer(dataset).data, status=status.HTTP_201_CREATED)


@api_view(['GET', 'PATCH', 'DELETE'])
@permission_classes([IsAuthenticated])
def dataset_detail(request, pk):
    dataset = get_object_or_404(Dataset, pk=pk, user=request.user, is_deleted=False)
    if request.method == 'GET':
        return Response(DatasetSerializer(dataset).data)
    if request.method == 'PATCH':
        serializer = DatasetSerializer(dataset, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(DatasetSerializer(dataset).data)
    dataset.is_deleted = True
    dataset.save()
    return Response(status=status.HTTP_204_NO_CONTENT)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def dataset_status(request, pk):
    dataset = get_object_or_404(Dataset, pk=pk, user=request.user, is_deleted=False)
    return Response({
        'status': dataset.status,
        'error_message': dataset.error_message,
        'row_count': dataset.row_count,
        'unique_orgs': dataset.unique_orgs,
        'unique_events': dataset.unique_events,
    })


# ---------------------------------------------------------------------------
# Analysis endpoints (populated in Phase 2 with full pipeline logic)
# ---------------------------------------------------------------------------

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def dataset_dashboard(request, pk):
    dataset = get_object_or_404(Dataset, pk=pk, user=request.user, is_deleted=False)
    if dataset.status != 'ready':
        return Response({'detail': 'Dataset is not ready yet.'}, status=status.HTTP_202_ACCEPTED)
    qs = Attendance.objects.filter(dataset=dataset)
    return Response({
        'row_count': dataset.row_count,
        'unique_orgs': dataset.unique_orgs,
        'unique_events': dataset.unique_events,
        'year_min': dataset.year_min,
        'year_max': dataset.year_max,
        'sectors': list(
            qs.values_list('sna_category', flat=True)
            .order_by('sna_category')
            .distinct()
        ),
    })


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def dataset_chart(request, pk):
    """Returns participation-by-sector data for stacked bar chart."""
    dataset = get_object_or_404(Dataset, pk=pk, user=request.user, is_deleted=False)
    if dataset.status != 'ready':
        return Response({'detail': 'Dataset is not ready yet.'}, status=status.HTTP_202_ACCEPTED)
    from .pipeline.charts import build_participation_chart_data
    data = build_participation_chart_data(dataset.id, request.GET)
    return Response(data)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def dataset_data_quality(request, pk):
    dataset = get_object_or_404(Dataset, pk=pk, user=request.user, is_deleted=False)
    if dataset.status != 'ready':
        return Response({'detail': 'Dataset is not ready yet.'}, status=status.HTTP_202_ACCEPTED)
    from .pipeline.charts import build_data_quality_report
    return Response(build_data_quality_report(dataset.id))


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def dataset_search(request, pk):
    dataset = get_object_or_404(Dataset, pk=pk, user=request.user, is_deleted=False)
    q = request.GET.get('q', '').strip()
    if not q:
        return Response({'results': []})
    qs = (
        Attendance.objects
        .filter(dataset=dataset, organization__icontains=q)
        .values('organization', 'sna_category')
        .distinct()
        .order_by('organization')[:50]
    )
    results = []
    for row in qs:
        org = row['organization']
        conferences = list(
            Attendance.objects.filter(dataset=dataset, organization=org)
            .values_list('conference', flat=True)
            .distinct()
            .order_by('year', 'month')
        )
        results.append({
            'organization': org,
            'sna_category': row['sna_category'],
            'conferences': conferences,
            'event_count': len(conferences),
        })
    return Response({'results': results})


# ---------------------------------------------------------------------------
# Gated: Kumu JSON blueprints (paid subscription required)
# ---------------------------------------------------------------------------

@api_view(['GET'])
@permission_classes([IsAuthenticated, IsSubscribed])
def network_org_event(request, pk):
    dataset = get_object_or_404(Dataset, pk=pk, user=request.user, is_deleted=False)
    if dataset.status != 'ready':
        return Response({'detail': 'Dataset is not ready yet.'}, status=status.HTTP_202_ACCEPTED)
    from .pipeline.network import build_kumu_org_event
    return Response(build_kumu_org_event(dataset.id, request.GET))


@api_view(['GET'])
@permission_classes([IsAuthenticated, IsSubscribed])
def network_org_org(request, pk):
    dataset = get_object_or_404(Dataset, pk=pk, user=request.user, is_deleted=False)
    if dataset.status != 'ready':
        return Response({'detail': 'Dataset is not ready yet.'}, status=status.HTTP_202_ACCEPTED)
    from .pipeline.network import build_kumu_org_org
    return Response(build_kumu_org_org(dataset.id, request.GET))


@api_view(['GET'])
@permission_classes([IsAuthenticated, IsSubscribed])
def network_three_layer(request, pk):
    dataset = get_object_or_404(Dataset, pk=pk, user=request.user, is_deleted=False)
    if dataset.status != 'ready':
        return Response({'detail': 'Dataset is not ready yet.'}, status=status.HTTP_202_ACCEPTED)
    from .pipeline.network import build_kumu_three_layer
    return Response(build_kumu_three_layer(dataset.id, request.GET))


# ---------------------------------------------------------------------------
# Public Kumu JSON endpoints — authenticated by per-dataset UUID token
# No JWT required; CORS is opened to * so Kumu's servers can fetch directly.
# ---------------------------------------------------------------------------

def _kumu_cors_response(data):
    """Return a JsonResponse with open CORS so Kumu.io can fetch it."""
    import json
    from django.http import HttpResponse
    resp = HttpResponse(json.dumps(data), content_type='application/json')
    resp['Access-Control-Allow-Origin'] = '*'
    return resp


def kumu_public_org_event(request, token):
    dataset = get_object_or_404(Dataset, kumu_token=token, is_deleted=False)
    if dataset.status != 'ready':
        return _kumu_cors_response({'error': 'Dataset is not ready yet.'})
    from .pipeline.network import build_kumu_org_event
    return _kumu_cors_response(build_kumu_org_event(dataset.id, request.GET))


def kumu_public_org_org(request, token):
    dataset = get_object_or_404(Dataset, kumu_token=token, is_deleted=False)
    if dataset.status != 'ready':
        return _kumu_cors_response({'error': 'Dataset is not ready yet.'})
    from .pipeline.network import build_kumu_org_org
    return _kumu_cors_response(build_kumu_org_org(dataset.id, request.GET))


def kumu_public_three_layer(request, token):
    dataset = get_object_or_404(Dataset, kumu_token=token, is_deleted=False)
    if dataset.status != 'ready':
        return _kumu_cors_response({'error': 'Dataset is not ready yet.'})
    from .pipeline.network import build_kumu_three_layer
    return _kumu_cors_response(build_kumu_three_layer(dataset.id, request.GET))


# ---------------------------------------------------------------------------
# Gated: CSV exports (paid subscription required)
# ---------------------------------------------------------------------------

class _Echo:
    def write(self, value):
        return value


def _streaming_csv(rows, filename):
    pseudo_buffer = _Echo()
    writer = csv.writer(pseudo_buffer)
    response = StreamingHttpResponse(
        (writer.writerow(row) for row in rows),
        content_type='text/csv',
    )
    response['Content-Disposition'] = f'attachment; filename="{filename}"'
    return response


@api_view(['GET'])
@permission_classes([IsAuthenticated, IsSubscribed])
def export_nodes(request, pk):
    dataset = get_object_or_404(Dataset, pk=pk, user=request.user, is_deleted=False)
    if dataset.status != 'ready':
        return Response({'detail': 'Dataset is not ready yet.'}, status=status.HTTP_202_ACCEPTED)
    from .pipeline.network import iter_nodes_csv
    return _streaming_csv(iter_nodes_csv(dataset.id), 'nodes.csv')


@api_view(['GET'])
@permission_classes([IsAuthenticated, IsSubscribed])
def export_edges_org_event(request, pk):
    dataset = get_object_or_404(Dataset, pk=pk, user=request.user, is_deleted=False)
    if dataset.status != 'ready':
        return Response({'detail': 'Dataset is not ready yet.'}, status=status.HTTP_202_ACCEPTED)
    from .pipeline.network import iter_edges_org_event_csv
    return _streaming_csv(iter_edges_org_event_csv(dataset.id), 'edges_org_event.csv')


@api_view(['GET'])
@permission_classes([IsAuthenticated, IsSubscribed])
def export_edges_org_org(request, pk):
    dataset = get_object_or_404(Dataset, pk=pk, user=request.user, is_deleted=False)
    if dataset.status != 'ready':
        return Response({'detail': 'Dataset is not ready yet.'}, status=status.HTTP_202_ACCEPTED)
    from .pipeline.network import iter_edges_org_org_csv
    return _streaming_csv(iter_edges_org_org_csv(dataset.id), 'edges_org_org.csv')


@api_view(['GET'])
@permission_classes([IsAuthenticated, IsSubscribed])
def export_edges_event_sector_org(request, pk):
    dataset = get_object_or_404(Dataset, pk=pk, user=request.user, is_deleted=False)
    if dataset.status != 'ready':
        return Response({'detail': 'Dataset is not ready yet.'}, status=status.HTTP_202_ACCEPTED)
    from .pipeline.network import iter_edges_event_sector_org_csv
    return _streaming_csv(iter_edges_event_sector_org_csv(dataset.id), 'edges_event_sector_org.csv')


# ---------------------------------------------------------------------------
# Template download (no auth required)
# ---------------------------------------------------------------------------

@api_view(['GET'])
@permission_classes([AllowAny])
def download_template(request):
    """Return a blank CSV template with the expected column headers."""
    headers = [
        'UniqueID', 'Salutation', 'First', 'Last',
        'SNA Category - ORIGINAL', 'SNA Category - CLEANED',
        'Title', 'Title - CLEANED',
        'Organization - ORIGINAL', 'Organization - CLEANED',
        'Active / Inactive',
        'Address', 'City', 'State', 'Zip',
        'Website',
        'Conference',  # MM/YYYY format
    ]
    output = io.StringIO()
    writer = csv.writer(output)
    writer.writerow(headers)
    # Two example rows to guide users
    writer.writerow([
        '1', 'Ms.', 'Jane', 'Smith',
        'Program', 'Program',
        'Program Director', 'Program Director',
        'Example Nonprofit', 'Example Nonprofit',
        'Active',
        '123 Main St', 'Chicago', 'IL', '60601',
        'https://www.example-nonprofit.org',
        '05/2010',
    ])
    writer.writerow([
        '2', 'Mr.', 'John', 'Doe',
        'Business', 'Business',
        'CEO', 'CEO',
        'Acme Corp', 'Acme Corp',
        'Active',
        '456 Oak Ave', 'Chicago', 'IL', '60602',
        'https://www.acmecorp.com',
        '11/2012',
    ])
    response = HttpResponse(output.getvalue(), content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename="ycn_upload_template.csv"'
    return response
