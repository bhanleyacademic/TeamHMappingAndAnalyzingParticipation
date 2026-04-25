"""
SNA Category normalization.

Canonical vocabulary (from project paper):
  Program, Resource, College, Intermediary, Business,
  T/MC, Government, K-12 School, Faith, Foundation, Other
"""

# Map lower-stripped raw value -> canonical label
_RAW_MAP = {
    # Program
    "program": "Program",
    "program ": "Program",
    "peogram": "Program",
    "pro tutoring": "Program",
    "program - faith": "Program",
    "program - gov": "Program",
    "program / faith": "Program",
    "program / gov": "Program",
    "program-faith": "Program",
    "program/church": "Program",
    "program/faith": "Program",
    "program/sports": "Program",
    "program/volunteer": "Program",
    # T/MC (Tutor/Mentor Connection umbrella)
    "t/mc": "T/MC",
    "t/mc - t/mi": "T/MC",
    "t/mc, t/mi": "T/MC",
    "t/mc. t/mi": "T/MC",
    "tm-network": "T/MC",
    "cc, t/mc": "T/MC",
    "cc, t/mc ": "T/MC",
    "cc-t/mc": "T/MC",
    "cc-t/mc ": "T/MC",
    "cc-tmc": "T/MC",
    "cc. t/mc": "T/MC",
    "cc/tmc": "T/MC",
    "cc, t/mc": "T/MC",
    # College / University
    "college": "College",
    "college ": "College",
    "university": "College",
    "student": "College",
    # K-12 School
    "k-12 school": "K-12 School",
    "k-12 school": "K-12 School",
    "cps": "K-12 School",
    "public school": "K-12 School",
    # Government
    "government": "Government",
    "gov-intermediary": "Government",
    "gov-intermediary": "Government",
    # Faith
    "faith": "Faith",
    # Foundation
    "foundation": "Foundation",
    "foundation - legal": "Foundation",
    "legal/foundation": "Foundation",
    "legal / foundation": "Foundation",
    "legal, foundation": "Foundation",
    "legal-foundation": "Foundation",
    "legal/foundatioin": "Foundation",
    # Intermediary
    "intermediary": "Intermediary",
    "intemediary": "Intermediary",
    "intergenerational": "Intermediary",
    "internediary": "Intermediary",
    "intermediary - gov": "Intermediary",
    "intermediary - gov ": "Intermediary",
    # Business
    "business": "Business",
    "business/foundation": "Business",
    # Resource
    "resource": "Resource",
    # Other (catch-all)
    "other": "Other",
    "arts": "Other",
    "athlete": "Other",
    "community": "Other",
    "consultant": "Other",
    "hospital": "Other",
    "international": "Other",
    "legal": "Other",
    "library": "Other",
    "media": "Other",
    "museum": "Other",
    "public health": "Other",
    "volunteer": "Other",
    "": "Other",
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
