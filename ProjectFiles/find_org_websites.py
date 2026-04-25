"""
Crawler to find websites for organizations in the conference CSV.
Searches via DuckDuckGo, checks if live, falls back to archive.org.
Output: org_websites.csv
"""

import csv
import json
import os
import time
import random
import re
import requests
from tqdm import tqdm
try:
    from ddgs import DDGS
except ImportError:
    from duckduckgo_search import DDGS

INPUT_CSV = "All_Conferences_Data_Cleaned-2026 - Sheet1.csv"
OUTPUT_CSV = "org_websites.csv"
CHECKPOINT_FILE = "org_websites_checkpoint.json"

HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 "
        "(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    )
}
REQUEST_TIMEOUT = 10


def load_checkpoint(path):
    if os.path.exists(path):
        with open(path) as f:
            return json.load(f)
    return {}


def save_checkpoint(data, path):
    with open(path, "w") as f:
        json.dump(data, f, indent=2)


def get_unique_orgs(csv_path):
    orgs = set()
    with open(csv_path, encoding="utf-8-sig") as f:
        reader = csv.DictReader(f)
        for row in reader:
            org = row.get("Organization - CLEANED", "").strip()
            if org:
                orgs.add(org)
    return sorted(orgs)


def is_url_live(url):
    """Return True if the URL responds with a non-error HTTP status."""
    try:
        resp = requests.get(url, headers=HEADERS, timeout=REQUEST_TIMEOUT,
                            allow_redirects=True)
        return resp.status_code < 400
    except Exception:
        return False


def search_archive_org(org_name):
    """
    Check archive.org CDX API for any snapshot of pages mentioning the org.
    Returns (archived_url, timestamp) or (None, None).
    """
    # First try to find a URL via DuckDuckGo with site:web.archive.org
    try:
        with DDGS() as ddgs:
            query = f'site:web.archive.org "{org_name}"'
            results = list(ddgs.text(query, max_results=3))
        for r in results:
            href = r.get("href", "")
            if "web.archive.org/web/" in href:
                return href, "archived"
    except Exception:
        pass

    # Fallback: CDX API search for org name as URL keyword
    slug = re.sub(r"[^a-z0-9]", "", org_name.lower())
    if len(slug) < 4:
        return None, None
    # Try common TLDs
    for tld in [".org", ".com", ".net"]:
        # Build a guessed domain and check CDX
        # Use first word(s) of slug up to 20 chars
        domain_guess = slug[:20] + tld
        try:
            cdx_url = (
                f"https://web.archive.org/cdx/search/cdx"
                f"?url={domain_guess}&output=json&limit=1&fl=original,timestamp"
            )
            resp = requests.get(cdx_url, timeout=REQUEST_TIMEOUT)
            data = resp.json()
            if len(data) > 1:  # first row is headers
                original, timestamp = data[1]
                archived = f"https://web.archive.org/web/{timestamp}/{original}"
                return archived, "archived"
        except Exception:
            pass
    return None, None


def search_for_website(org_name):
    """
    Search DuckDuckGo for the organization's official website.
    Returns (url, status) where status is 'live', 'archived', or 'not found'.
    """
    try:
        with DDGS() as ddgs:
            query = f'"{org_name}" official website'
            results = list(ddgs.text(query, max_results=5))
    except Exception:
        results = []

    # Filter out obvious non-org pages (news, social media, etc.)
    skip_domains = {
        "facebook.com", "twitter.com", "linkedin.com", "youtube.com",
        "wikipedia.org", "yelp.com", "indeed.com", "glassdoor.com",
        "bbb.org", "guidestar.org", "charity", "news", "reddit.com",
        "instagram.com", "web.archive.org",
    }

    for r in results:
        url = r.get("href", "")
        if not url:
            continue
        if any(skip in url for skip in skip_domains):
            continue
        if is_url_live(url):
            return url, "live"

    # No live site found — try archive.org
    archived_url, status = search_archive_org(org_name)
    if archived_url:
        return archived_url, "archived"

    # Last resort: return the first DDG result even if we couldn't verify it
    for r in results:
        url = r.get("href", "")
        if url and not any(skip in url for skip in skip_domains):
            return url, "unverified"

    return "", "not found"


def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    input_path = os.path.join(script_dir, INPUT_CSV)
    output_path = os.path.join(script_dir, OUTPUT_CSV)
    checkpoint_path = os.path.join(script_dir, CHECKPOINT_FILE)

    orgs = get_unique_orgs(input_path)
    print(f"Found {len(orgs)} unique organizations.")

    checkpoint = load_checkpoint(checkpoint_path)

    # Determine which orgs already processed
    remaining = [o for o in orgs if o not in checkpoint]
    print(f"{len(checkpoint)} already processed, {len(remaining)} remaining.")

    # Write output CSV (append mode for resume support)
    write_header = not os.path.exists(output_path)
    with open(output_path, "a", newline="", encoding="utf-8") as outf:
        writer = csv.writer(outf)
        if write_header:
            writer.writerow(["Organization", "Website", "Status"])

        for org in tqdm(remaining, desc="Searching"):
            url, status = search_for_website(org)
            writer.writerow([org, url, status])
            outf.flush()

            checkpoint[org] = {"url": url, "status": status}
            save_checkpoint(checkpoint, checkpoint_path)

            # Polite delay to avoid rate limiting
            time.sleep(random.uniform(1.5, 3.5))

    print(f"\nDone! Results saved to {output_path}")


if __name__ == "__main__":
    main()
