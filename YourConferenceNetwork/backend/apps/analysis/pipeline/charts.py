"""
Chart and data-quality report builders.

Ported from MappingAndAnalyzingParticipation/conferences/views.py.
Returns JSON-serializable dicts (not HTML) so the Vue SPA renders via ApexCharts.
"""
from collections import defaultdict
from django.db.models import Count, Q

from .normalize import CANONICAL_CATEGORIES, get_categories

# Viridis palette — 20 evenly-spaced hex values (positions 0.05–0.95)
_VIRIDIS = [
    '#440154', '#481567', '#482677', '#453781', '#404788',
    '#39568c', '#33638d', '#2d708e', '#287d8e', '#238a8d',
    '#1f968b', '#20a387', '#29af7f', '#3dbc74', '#55c667',
    '#73d055', '#95d840', '#b8de29', '#dce319', '#fde725',
]


def get_color_map(categories):
    """Return {category: hex_color} sampled evenly from viridis."""
    n = len(categories)
    if n == 0:
        return {}
    if n == 1:
        return {categories[0]: _VIRIDIS[9]}
    indices = [round(i * (len(_VIRIDIS) - 1) / (n - 1)) for i in range(n)]
    return {cat: _VIRIDIS[idx] for cat, idx in zip(categories, indices)}


def _base_qs(dataset_id, params=None):
    from apps.analysis.models import Attendance
    qs = Attendance.objects.filter(dataset_id=dataset_id)
    if params:
        year = params.get('year')
        sector = params.get('sector')
        state = params.get('state')
        if year:
            qs = qs.filter(year=year)
        if sector:
            qs = qs.filter(sna_category=sector)
        if state:
            qs = qs.filter(state__iexact=state)
    return qs


def build_participation_chart_data(dataset_id, params=None) -> dict:
    """
    Returns ApexCharts-compatible stacked bar data for participation per conference event.
    Shape:
      {
        "categories": ["05/2000", "11/2000", ...],   # x-axis (conference labels, sorted)
        "series": [
          {"name": "Program", "data": [12, 8, ...], "color": "#2196F3"},
          ...
        ],
        "available_years": [...],
        "available_states": [...],
        "canonical_categories": [...],
      }
    """
    from apps.analysis.models import Attendance, Dataset as _Dataset
    _cm = _Dataset.objects.values_list('category_map', flat=True).get(pk=dataset_id)
    categories = get_categories(_cm)

    qs = _base_qs(dataset_id, params)

    rows = (
        qs.values('year', 'month', 'conference', 'sna_category')
        .annotate(count=Count('id'))
        .order_by('year', 'month')
    )

    series_data = defaultdict(lambda: defaultdict(int))
    conferences_ordered = []
    seen = set()
    for row in rows:
        label = row['conference']
        if label not in seen:
            seen.add(label)
            conferences_ordered.append(label)
        series_data[row['sna_category']][label] += row['count']

    # Sort chronologically
    def _sort_key(c):
        parts = c.split('/')
        try:
            return (int(parts[1]), int(parts[0]))
        except (IndexError, ValueError):
            return (0, 0)

    conferences_ordered = sorted(conferences_ordered, key=_sort_key)

    color_map = get_color_map(categories)
    series = []
    for sector in categories:
        counts = [series_data[sector].get(c, 0) for c in conferences_ordered]
        if any(counts):
            series.append({
                'name': sector,
                'data': counts,
                'color': color_map.get(sector, '#9E9E9E'),
            })

    # Filter helpers
    all_qs = Attendance.objects.filter(dataset_id=dataset_id)
    available_years = list(
        all_qs.exclude(year__isnull=True)
        .values_list('year', flat=True)
        .distinct()
        .order_by('year')
    )
    available_states = list(
        all_qs.exclude(state='')
        .values_list('state', flat=True)
        .distinct()
        .order_by('state')
    )

    return {
        'categories': conferences_ordered,
        'series': series,
        'available_years': available_years,
        'available_states': available_states,
        'canonical_categories': categories,
    }


def build_data_quality_report(dataset_id) -> dict:
    from apps.analysis.models import Attendance
    qs = Attendance.objects.filter(dataset_id=dataset_id)
    total = qs.count()
    missing_org = qs.filter(Q(organization='') | Q(organization__isnull=True)).count()
    missing_sna = qs.filter(Q(sna_category='') | Q(sna_category__isnull=True)).count()
    unmapped = qs.filter(sna_category='Other').count()

    original_dist = list(
        qs.values('sna_category_original')
        .annotate(count=Count('id'))
        .order_by('-count')[:30]
    )
    normalized_dist = list(
        qs.values('sna_category')
        .annotate(count=Count('id'))
        .order_by('-count')
    )

    return {
        'total': total,
        'missing_org': missing_org,
        'missing_sna': missing_sna,
        'unmapped_to_other': unmapped,
        'original_distribution': original_dist,
        'normalized_distribution': normalized_dist,
    }
