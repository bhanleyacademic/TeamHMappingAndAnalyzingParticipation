"""
Cached accessor for SiteSettings to avoid a DB hit on every API request.

Cache is invalidated explicitly when the row is updated via the admin endpoint.
TTL fallback of 60 seconds ensures the cache never drifts more than a minute
even if invalidation is somehow missed.
"""
import time
import functools

_cache: dict = {}
_TTL = 60  # seconds


def is_free_tier_override() -> bool:
    """Return the current value of SiteSettings.free_tier_override.

    Cached for up to _TTL seconds; call invalidate_site_settings_cache()
    immediately after saving to flush the cache.
    """
    now = time.monotonic()
    if 'value' in _cache and now - _cache.get('ts', 0) < _TTL:
        return _cache['value']

    from apps.api.models import SiteSettings
    row = SiteSettings.objects.values_list('free_tier_override', flat=True).first()
    value = bool(row) if row is not None else False
    _cache['value'] = value
    _cache['ts'] = now
    return value


def invalidate_site_settings_cache() -> None:
    """Force the next call to is_free_tier_override() to re-query the DB."""
    _cache.clear()
