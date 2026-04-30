# Methodology Overview

The cleaned public workflow is intentionally compact and reproducible.

## Core steps

1. Load the monthly series and define a time-series object with frequency 12.
2. Visualize level, trend and seasonality.
3. Split the last five months as a small holdout segment.
4. Compare simple smoothing baselines:
   - SES
   - Holt
   - Holt-Winters
5. Fit an ARIMA-style model using classical identification logic.
6. Evaluate holdout RMSE and inspect residual behaviour.

## Why this structure was chosen

The original coursework folder contains several evolving report versions.
For a public portfolio, the goal is not to preserve every draft but to expose the underlying modelling approach in a clean, readable form.

