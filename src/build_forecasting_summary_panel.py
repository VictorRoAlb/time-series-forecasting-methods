from pathlib import Path

import matplotlib.pyplot as plt
import matplotlib.image as mpimg


BASE_DIR = Path(__file__).resolve().parents[1]
FIGURES_DIR = BASE_DIR / "figures"
OUTPUT_PATH = FIGURES_DIR / "forecasting_summary_panel.png"


PANELS = [
    ("Series overview", FIGURES_DIR / "wind_generation_overview.png"),
    ("Seasonal monthly profile", FIGURES_DIR / "monthly_profile.png"),
    ("Train / holdout split", FIGURES_DIR / "train_holdout_split.png"),
    ("Final ARIMA forecast", FIGURES_DIR / "arima_forecast_preview.png"),
]


def add_panel(ax, title: str, image_path: Path) -> None:
    image = mpimg.imread(image_path)
    ax.imshow(image)
    ax.set_title(title, fontsize=13, fontweight="bold", pad=10)
    ax.axis("off")


def main() -> None:
    fig, axes = plt.subplots(2, 2, figsize=(15.5, 11.0), facecolor="white")
    axes = axes.ravel()

    for ax, (title, image_path) in zip(axes, PANELS):
        add_panel(ax, title, image_path)

    fig.suptitle(
        "Time-series forecasting workflow summary",
        fontsize=22,
        fontweight="bold",
        y=0.98,
    )
    fig.text(
        0.5,
        0.95,
        "Exploration, seasonal structure, holdout evaluation and final ARIMA prediction",
        ha="center",
        va="center",
        fontsize=12,
        color="#4f6176",
    )

    plt.tight_layout(rect=[0.03, 0.04, 0.97, 0.92])
    fig.savefig(OUTPUT_PATH, dpi=300, bbox_inches="tight")
    plt.close(fig)
    print(f"Saved {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
