"""
SNA Category normalization.

Canonical vocabulary (12 categories, confirmed by Daniel F. Bassill, April 22 2026):
  Program, Resource, College, Intermediary, Business,
  T/MC, Government, K-12 School, Faith, Foundation, Media, Other

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
    "media":        "Media",
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
    "Media",
    "Other",
]


def normalize(raw: str) -> str:
    """Return the canonical SNA category for a raw string."""
    key = raw.strip().lower() if raw else ""
    return _RAW_MAP.get(key, "Other")
