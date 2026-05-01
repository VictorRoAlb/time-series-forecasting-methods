library(forecast)
library(lmtest)

source("forecasting_helpers.R")

series_path <- file.path("..", "examples", "wind_generation_spain_monthly_2020_2024.csv")
ts_wind <- load_wind_series(series_path)
split_data <- train_test_split_ts(ts_wind, holdout = 5)

train_ts <- split_data$train
test_ts <- split_data$test

decomp <- stl(ts_wind, s.window = "periodic")

fit_ses <- HoltWinters(train_ts, beta = FALSE, gamma = FALSE)
pred_ses <- predict(fit_ses, n.ahead = length(test_ts))
rmse_ses <- holdout_rmse(test_ts, pred_ses)

fit_holt <- HoltWinters(train_ts, gamma = FALSE)
pred_holt <- predict(fit_holt, n.ahead = length(test_ts))
rmse_holt <- holdout_rmse(test_ts, pred_holt)

fit_hw <- hw(train_ts, seasonal = "additive")
pred_hw <- forecast(fit_hw, h = length(test_ts))
rmse_hw <- holdout_rmse(test_ts, pred_hw$mean)

lambda_bc <- BoxCox.lambda(train_ts)
fit_arima <- auto.arima(
  train_ts,
  seasonal = TRUE,
  lambda = lambda_bc,
  stepwise = FALSE,
  approximation = FALSE
)
pred_arima <- forecast(fit_arima, h = length(test_ts))
rmse_arima <- holdout_rmse(test_ts, pred_arima$mean)

results <- data.frame(
  model = c("SES", "Holt", "Holt-Winters", "ARIMA"),
  holdout_rmse = c(rmse_ses, rmse_holt, rmse_hw, rmse_arima)
)

results <- results[order(results$holdout_rmse), ]
print(results)

future_forecast <- forecast(fit_arima, h = 12)
print(future_forecast)

# Run interactively when needed
# plot(decomp)
# checkresiduals(fit_arima)
# plot(future_forecast)
