"""
Network graph builders and CSV export iterators.

Ported from MappingAndAnalyzingParticipation/conferences/views.py.
All functions accept dataset_id and scope queries to that dataset.
"""
from collections import defaultdict
from django.db.models import Count


def _qs(dataset_id):
    from apps.analysis.models import Attendance
    return Attendance.objects.filter(dataset_id=dataset_id).exclude(organization='')


# ---------------------------------------------------------------------------
# Kumu.io JSON blueprint builders
# ---------------------------------------------------------------------------

def build_kumu_org_event(dataset_id, params=None) -> dict:
    params = params or {}
    try:
        min_events = max(1, int(params.get('min_events', 3)))
    except (ValueError, TypeError):
        min_events = 3
    try:
        min_orgs = max(1, int(params.get('min_orgs', 10)))
    except (ValueError, TypeError):
        min_orgs = 10

    org_data = {}
    event_org_sets = defaultdict(set)
    event_record_counts = defaultdict(int)

    for a in _qs(dataset_id).values('organization', 'sna_category', 'conference', 'website'):
        org, evt = a['organization'], a['conference']
        if org not in org_data:
            org_data[org] = {
                'sna_category': a['sna_category'],
                'events': set(),
                'records': 0,
                'website': a.get('website') or '',
            }
        elif not org_data[org]['website'] and a.get('website'):
            org_data[org]['website'] = a['website']
        org_data[org]['records'] += 1
        org_data[org]['events'].add(evt)
        event_org_sets[evt].add(org)
        event_record_counts[evt] += 1

    active_orgs = {org for org, d in org_data.items() if len(d['events']) >= min_events}
    active_events = {evt for evt, orgs in event_org_sets.items() if len(orgs) >= min_orgs}

    elements = []
    for org in sorted(active_orgs):
        d = org_data[org]
        el = {
            'label': org,
            'type': d['sna_category'],
            'conferences attended': len(d['events']),
            'attendance records': d['records'],
        }
        if d['website']:
            el['website'] = d['website']
        elements.append(el)
    for evt in sorted(active_events):
        elements.append({
            'label': evt,
            'type': 'Conference Event',
            'attendance records': event_record_counts[evt],
            'organizations attended': len(event_org_sets[evt]),
        })

    connections = [
        {'from': org, 'to': evt, 'direction': 'undirected'}
        for org in active_orgs
        for evt in org_data[org]['events']
        if evt in active_events
    ]

    return {'elements': elements, 'connections': connections}


def build_kumu_org_org(dataset_id, params=None) -> dict:
    params = params or {}
    try:
        min_events = max(1, int(params.get('min_events', 2)))
    except (ValueError, TypeError):
        min_events = 2
    try:
        min_weight = max(1, int(params.get('min_weight', 3)))
    except (ValueError, TypeError):
        min_weight = 3

    conf_orgs = defaultdict(set)
    org_event_count = defaultdict(set)
    org_meta = {}

    for a in _qs(dataset_id).values('organization', 'sna_category', 'conference', 'website'):
        org = a['organization']
        conf_orgs[a['conference']].add(org)
        org_event_count[org].add(a['conference'])
        if org not in org_meta:
            org_meta[org] = {'sna_category': a['sna_category'], 'records': 0, 'website': a.get('website') or ''}
        elif not org_meta[org]['website'] and a.get('website'):
            org_meta[org]['website'] = a['website']
        org_meta[org]['records'] += 1

    active_orgs = {org for org, evts in org_event_count.items() if len(evts) >= min_events}

    pair_weight = defaultdict(int)
    for orgs_in_conf in conf_orgs.values():
        shared = sorted(o for o in orgs_in_conf if o in active_orgs)
        for i, a in enumerate(shared):
            for b in shared[i + 1:]:
                pair_weight[(a, b)] += 1

    orgs_with_edges = {
        org for (a, b), w in pair_weight.items() if w >= min_weight for org in (a, b)
    }

    def _org_element(org):
        meta = org_meta[org]
        el = {
            'label': org,
            'type': meta['sna_category'],
            'conferences attended': len(org_event_count[org]),
            'attendance records': meta['records'],
        }
        if meta['website']:
            el['website'] = meta['website']
        return el

    elements = [_org_element(org) for org in sorted(active_orgs & orgs_with_edges)]

    connections = [
        {'from': src, 'to': tgt, 'shared conferences': weight, 'direction': 'undirected'}
        for (src, tgt), weight in sorted(pair_weight.items(), key=lambda x: -x[1])
        if weight >= min_weight
    ]

    return {'elements': elements, 'connections': connections}


def build_kumu_three_layer(dataset_id, params=None) -> dict:
    params = params or {}
    try:
        year_min = int(params.get('year_min', 2004))
    except (ValueError, TypeError):
        year_min = 2004
    try:
        year_max = int(params.get('year_max', 2010))
    except (ValueError, TypeError):
        year_max = 2010
    try:
        min_events = max(1, int(params.get('min_events', 4)))
    except (ValueError, TypeError):
        min_events = 4

    from apps.analysis.models import Attendance
    attendances = list(
        Attendance.objects.filter(dataset_id=dataset_id)
        .exclude(organization='')
        .filter(year__gte=year_min, year__lte=year_max)
        .values('organization', 'sna_category', 'conference', 'year', 'website')
    )

    org_events_in_window = defaultdict(set)
    org_sector = {}
    org_website = {}
    for a in attendances:
        org = a['organization']
        org_events_in_window[org].add(a['conference'])
        org_sector[org] = a['sna_category']
        if not org_website.get(org) and a.get('website'):
            org_website[org] = a['website']

    active_orgs = {org for org, evts in org_events_in_window.items() if len(evts) >= min_events}

    event_sector = set()
    sector_org = set()
    for a in attendances:
        if a['organization'] in active_orgs:
            event_sector.add((a['conference'], a['sna_category']))
            sector_org.add((a['sna_category'], a['organization']))

    def positions(items):
        n = len(items)
        return [round(i * 100 / max(n - 1, 1)) for i in range(n)]

    all_events = sorted(e for e, _ in event_sector)
    all_sectors = sorted(s for _, s in event_sector)
    all_orgs = sorted(active_orgs)

    elements = []
    for evt, y in zip(all_events, positions(all_events)):
        elements.append({'label': evt, 'type': 'Conference Event', 'layer': 0, 'position': y})
    for sec, y in zip(all_sectors, positions(all_sectors)):
        elements.append({'label': sec, 'type': 'Sector', 'layer': 50, 'position': y})
    for org, y in zip(all_orgs, positions(all_orgs)):
        el = {'label': org, 'type': org_sector.get(org, 'Other'), 'layer': 100, 'position': y}
        if org_website.get(org):
            el['website'] = org_website[org]
        elements.append(el)

    connections = []
    for evt, sec in sorted(event_sector):
        connections.append({'from': evt, 'to': sec, 'layer': 'Event-Sector', 'direction': 'directed'})
    for sec, org in sorted(sector_org):
        connections.append({'from': sec, 'to': org, 'layer': 'Sector-Org', 'direction': 'directed'})

    return {'elements': elements, 'connections': connections}


# ---------------------------------------------------------------------------
# CSV export iterators (streaming-friendly)
# ---------------------------------------------------------------------------

def iter_nodes_csv(dataset_id):
    yield ['Id', 'Label', 'SNA_Category', 'Website', 'Event_Count', 'Record_Count']
    website_map = {}
    for a in _qs(dataset_id).values('organization', 'website').order_by('organization', 'id'):
        if a['organization'] not in website_map:
            website_map[a['organization']] = a.get('website') or ''
        elif not website_map[a['organization']] and a.get('website'):
            website_map[a['organization']] = a['website']
    orgs = (
        _qs(dataset_id)
        .values('organization', 'sna_category')
        .annotate(event_count=Count('conference', distinct=True), record_count=Count('id'))
        .order_by('organization')
    )
    for org in orgs:
        yield [
            org['organization'],
            org['organization'],
            org['sna_category'],
            website_map.get(org['organization'], ''),
            org['event_count'],
            org['record_count'],
        ]


def iter_edges_org_event_csv(dataset_id):
    yield ['From', 'To', 'Type', 'Year', 'Month']
    for a in _qs(dataset_id).values('organization', 'conference', 'sna_category', 'year', 'month'):
        yield [a['organization'], a['conference'], a['sna_category'], a['year'], a['month']]


def iter_edges_org_org_csv(dataset_id):
    yield ['Source', 'Target', 'Weight', 'Type']
    conf_orgs = defaultdict(set)
    for a in _qs(dataset_id).values('conference', 'organization'):
        conf_orgs[a['conference']].add(a['organization'])

    pair_weight = defaultdict(int)
    for orgs in conf_orgs.values():
        orgs_list = sorted(orgs)
        for i, a in enumerate(orgs_list):
            for b in orgs_list[i + 1:]:
                pair_weight[(a, b)] += 1

    for (src, tgt), weight in sorted(pair_weight.items(), key=lambda x: -x[1]):
        yield [src, tgt, weight, 'Undirected']


def iter_edges_event_sector_org_csv(dataset_id):
    yield ['From', 'To', 'Layer']
    event_sector = set()
    sector_org = set()
    for a in _qs(dataset_id).values('organization', 'conference', 'sna_category'):
        event_sector.add((a['conference'], a['sna_category']))
        sector_org.add((a['sna_category'], a['organization']))
    for evt, sec in sorted(event_sector):
        yield [evt, sec, 'Event-Sector']
    for sec, org in sorted(sector_org):
        yield [sec, org, 'Sector-Org']
