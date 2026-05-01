# Model Results Summary

The reviewed coursework material follows a classical progression from deterministic smoothing models to ARIMA-style modelling.

## Baseline models

The source report evaluates:

- simple exponential smoothing;
- Holt trend;
- Holt-Winters additive with different initialization choices.

This gives a useful baseline before moving to Box-Jenkins style modelling.

## ARIMA block

The final academic R Markdown file explicitly includes:

- Box-Cox transformation;
- regular and seasonal differencing checks;
- ACF and PACF inspection;
- a collection of tentative seasonal ARIMA models;
- information-criterion comparison;
- residual checks.

The public notebook keeps the same narrative in a shorter form and adds `auto.arima` as the most practical executable benchmark.

## Why the public repo is slightly more compact

The original report was written as coursework and relied on a workbook-driven local setup. The public version keeps the modelling logic and the reproducible code path, but swaps the original workbook for a safe CSV and removes teaching materials that should not be redistributed.
