"""
SNA Category normalization.

Canonical vocabulary (from project paper):
  Program, Resource, College, Intermediary, Business,
  T/MC, Government, K-12 School, Faith, Foundation, Other

Verified against all 73 unique raw values present in
All_Conferences_Data_Cleaned-2026.xlsx (6,410 records).

The normalize() function applies strip().lower() before lookup,
so trailing-space and case variants are handled automatically
and do not need separate map entries.
"""

_RAW_MAP = {
    # ------------------------------------------------------------------ Program
    "program":           "Program",
    "peogram":           "Program",   # typo
    "pro tutoring":      "Program",
    "program - faith":   "Program",
    "program - gov":     "Program",
    "program / faith":   "Program",
    "program / gov":     "Program",
    "program-faith":     "Program",
    "program/church":    "Program",
    "program/faith":     "Program",
    "program/sports":    "Program",
    "program/volunteer": "Program",
    # -------------------------------------------------------------------- T/MC
    "t/mc":         "T/MC",
    "t/mc - t/mi":  "T/MC",
    "t/mc, t/mi":   "T/MC",
    "t/mc. t/mi":   "T/MC",
    "tm-network":   "T/MC",
    "cc, t/mc":     "T/MC",
    "cc-t/mc":      "T/MC",
    "cc-tmc":       "T/MC",
    "cc. t/mc":     "T/MC",
    "cc/tmc":       "T/MC",
    # -------------------------------------------------------- College/University
    "college":    "College",
    "university": "College",
    "student":    "College",
    # -------------------------------------------------------------- K-12 School
    "k-12 school": "K-12 School",
    "cps":         "K-12 School",   # Chicago Public Schools
    "public school": "K-12 School",
    # ------------------------------------------------------------- Government
    "government":      "Government",
    "gov-intermediary": "Government",
    # ------------------------------------------------------------------- Faith
    "faith": "Faith",
    # --------------------------------------------------------------- Foundation
    "foundation":         "Foundation",
    "foundation - legal": "Foundation",
    "legal/foundation":   "Foundation",
    "legal / foundation": "Foundation",
    "legal, foundation":  "Foundation",
    "legal-foundation":   "Foundation",
    "legal/foundatioin":  "Foundation",  # typo in source data
    # ------------------------------------------------------------- Intermediary
    "intermediary":     "Intermediary",
    "intemediary":      "Intermediary",  # typo
    "intergenerational": "Intermediary",
    "internediary":     "Intermediary",  # typo
    "intermediary - gov": "Intermediary",
    # --------------------------------------------------------------- Business
    "business":             "Business",
    "business/foundation":  "Business",
    # --------------------------------------------------------------- Resource
    "resource": "Resource",
    # ------------------------------------------------------------------ Other
    "other":        "Other",
    "arts":         "Other",
    "athlete":      "Other",
    "community":    "Other",
    "consultant":   "Other",
    "hospital":     "Other",
    "international": "Other",
    "legal":        "Other",
    "library":      "Other",
    "media":        "Other",
    "museum":       "Other",
    "public health": "Other",
    "volunteer":    "Other",
    "":             "Other",
}

CANONICAL_CATEGORIES = [
    "Program",
    "Resource",
    "College",
    "Intermediary",
    "Business",
    "T/MC",
    "Government",
    "K-12 School",
    "Faith",
    "Foundation",
    "Other",
]


def normalize(raw: str) -> str:
    """Return the canonical SNA category for a raw string."""
    key = raw.strip().lower() if raw else ""
    return _RAW_MAP.get(key, "Other")


def get_normalizer(category_map=None):
    """Return a (raw: str) -> str callable for the given dataset category_map.

    Three modes:
    - pass_through: true  → strip and return the raw value as-is
    - raw_map present     → look up in custom dict, fall back to "Other"
    - None / missing keys → delegate to the global normalize()
    """
    if category_map:
        if category_map.get('pass_through'):
            return lambda raw: raw.strip() if raw else 'Other'
        raw_map = category_map.get('raw_map')
        if raw_map:
            _map = {k.strip().lower(): v for k, v in raw_map.items()}
            return lambda raw: _map.get(raw.strip().lower() if raw else '', 'Other')
    return normalize


def get_categories(category_map=None):
    """Return the canonical category list for a dataset.

    Falls back to the global CANONICAL_CATEGORIES when category_map is absent
    or has no 'categories' key.
    """
    if category_map:
        cats = category_map.get('categories')
        if cats:
            return cats
    return CANONICAL_CATEGORIES
