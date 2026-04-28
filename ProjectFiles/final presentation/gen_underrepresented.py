"""Generate fig_underrepresented_with_media.png — same style as fig_underrepresented.png but with Media added."""

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

# Data: (label, count, underrepresented, color)
# Underrepresented first (sorted ascending), then rest sorted ascending by count
sectors = [
    ("Media",        43,   True,  "#E07B54"),
    ("Foundation",   58,   True,  "#C0392B"),
    ("Business",    131,   True,  "#1E8449"),
    ("Faith",       148,   True,  "#A04000"),
    ("Government",  136,   False, "#2471A3"),
    ("Intermediary",227,   False, "#C0392B"),
    ("K-12 School", 418,   False, "#1A9E5E"),
    ("College",     559,   False, "#148F77"),
    ("Resource",    612,   False, "#7D3C98"),
    ("Program",    3310,   False, "#2E4BC8"),
]

# Re-sort: underrepresented ascending by count, then non-underrepresented ascending by count
under = sorted([s for s in sectors if s[2]], key=lambda x: x[1])
other = sorted([s for s in sectors if not s[2]], key=lambda x: x[1])
ordered = under + other

labels  = [s[0] for s in ordered]
counts  = [s[1] for s in ordered]
is_under = [s[2] for s in ordered]
colors  = [s[3] for s in ordered]

fig, ax = plt.subplots(figsize=(14, 7))
fig.patch.set_facecolor("white")

bars = ax.bar(labels, counts, color=colors, width=0.6, zorder=2)

# Red border + warning triangle annotation on underrepresented bars
for bar, label, count, under in zip(bars, labels, counts, is_under):
    if under:
        bar.set_edgecolor("#C0392B")
        bar.set_linewidth(2.5)
        x = bar.get_x() + bar.get_width() / 2
        y = bar.get_height()
        ax.annotate(
            f"△ {count}",
            xy=(x, y + 15),
            ha="center", va="bottom",
            fontsize=11, fontweight="bold", color="#C0392B",
        )

# Grid + spine styling
ax.set_axisbelow(True)
ax.yaxis.grid(True, linestyle="--", linewidth=0.7, color="#BBBBBB", alpha=0.8)
ax.set_axisbelow(True)
for spine in ["top", "right", "left"]:
    ax.spines[spine].set_visible(False)
ax.spines["bottom"].set_color("#888888")

ax.set_ylabel("Total Participation Records (1994–2014)", fontsize=12)
ax.set_xlabel("")
ax.tick_params(axis="x", rotation=35, labelsize=11)
ax.tick_params(axis="y", labelsize=10)
ax.set_ylim(0, max(counts) * 1.15)

ax.set_title(
    "Underrepresented Sectors: Media, Funders, Faith & Business vs. Service Providers",
    fontsize=14, fontweight="bold", pad=18,
)
ax.text(
    0.62, 0.93,
    "Red border = chronically underrepresented despite being\n"
    "critical to Bassill's four strategic pillars (funding, faith anchor, workforce dev, visibility)",
    transform=ax.transAxes,
    ha="center", va="top",
    fontsize=9, color="#888888", style="italic",
)

plt.tight_layout()
out = "/Users/bhanley/PycharmProjects/IUSPR26/ENGR-E483/ProjectFiles/final presentation/fig_underrepresented_with_media.png"
plt.savefig(out, dpi=150, bbox_inches="tight")
print(f"Saved: {out}")
