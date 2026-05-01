# Methodology Overview

The final coursework report in `Tecnicas de prevision` goes beyond a single ARIMA fit. The public repository keeps that broader structure while removing the original workbook and course files.

## Workflow

1. Aggregate the source series at monthly frequency.
2. Build a `ts` object with `frequency = 12`.
3. Inspect the global profile and seasonal structure.
4. Decompose the series with STL.
5. Compare smoothing-based baselines:
   - simple exponential smoothing;
   - Holt trend;
   - Holt-Winters additive.
6. Apply Box-Cox when variance stabilization is helpful.
7. Inspect `ndiffs()` and `nsdiffs()` to reason about stationarity.
8. Use ACF/PACF and tentative specifications to motivate the ARIMA family.
9. Fit `auto.arima` as a practical benchmark against manual reasoning.
10. Compare models through holdout RMSE.
11. Inspect residuals before producing the forecast preview.

## Public material vs original coursework

Published here:

- a safe monthly CSV;
- an executable R Markdown report;
- a compact script version of the workflow;
- preview figures and documentation.

Not published here:

- the original Excel workbook;
- lecture notes and teacher-provided PDFs;
- Word/PDF submission files;
- build artifacts from the coursework folder.
