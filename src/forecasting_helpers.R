load_wind_series <- function(path) {
  data <- read.csv(path, stringsAsFactors = FALSE)
  data$date <- as.Date(data$date)
  ts(
    data$wind_generation_mw,
    start = c(as.integer(format(min(data$date), "%Y")),
              as.integer(format(min(data$date), "%m"))),
    frequency = 12
  )
}

holdout_rmse <- function(actual, predicted) {
  sqrt(mean((actual - predicted)^2))
}

train_test_split_ts <- function(x, holdout = 5) {
  n <- length(x)
  list(
    train = x[seq_len(n - holdout)],
    test = x[(n - holdout + 1):n]
  )
}

