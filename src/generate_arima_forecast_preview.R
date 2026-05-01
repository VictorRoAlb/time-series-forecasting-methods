args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 2) {
  stop("Usage: Rscript generate_arima_forecast_preview.R <csv_path> <output_path>")
}

csv_path <- args[[1]]
output_path <- args[[2]]

suppressPackageStartupMessages({
  library(ggplot2)
})

series_df <- read.csv(csv_path, stringsAsFactors = FALSE)
series_df$date <- as.Date(series_df$date)
series_df <- series_df[order(series_df$date), ]

start_year <- as.integer(format(min(series_df$date), "%Y"))
start_month <- as.integer(format(min(series_df$date), "%m"))

wind_ts <- ts(
  series_df$wind_generation_mw,
  start = c(start_year, start_month),
  frequency = 12
)

# The public preview follows the final seasonal ARIMA structure discussed
# in the coursework report: ARIMA(0,0,4)(1,1,0)[12] on the log-transformed series.
fit_arima <- arima(
  log(wind_ts),
  order = c(0, 0, 4),
  seasonal = list(order = c(1, 1, 0), period = 12)
)

pred <- predict(fit_arima, n.ahead = 12)

forecast_dates <- seq(
  from = seq(max(series_df$date), by = "month", length.out = 2)[2],
  by = "month",
  length.out = 12
)

forecast_df <- data.frame(
  date = forecast_dates,
  mean = exp(pred$pred),
  lower = exp(pred$pred - 1.96 * pred$se),
  upper = exp(pred$pred + 1.96 * pred$se)
)

historical_color <- "#214f72"
forecast_color <- "#a85d2f"
ribbon_color <- "#ecd8c8"

preview_plot <- ggplot() +
  geom_line(
    data = series_df,
    aes(x = date, y = wind_generation_mw),
    linewidth = 1.05,
    color = historical_color
  ) +
  geom_ribbon(
    data = forecast_df,
    aes(x = date, ymin = lower, ymax = upper),
    fill = ribbon_color,
    alpha = 0.55
  ) +
  geom_line(
    data = forecast_df,
    aes(x = date, y = mean),
    linewidth = 1.1,
    color = forecast_color
  ) +
  geom_point(
    data = forecast_df,
    aes(x = date, y = mean),
    size = 2.2,
    color = forecast_color
  ) +
  geom_vline(
    xintercept = max(series_df$date),
    linewidth = 0.45,
    linetype = "dashed",
    color = "#68798f"
  ) +
  annotate(
    "text",
    x = max(series_df$date),
    y = max(series_df$wind_generation_mw) * 1.03,
    label = "Forecast start",
    hjust = 1.02,
    vjust = -0.2,
    size = 3.4,
    color = "#5c6b7d"
  ) +
  labs(
    title = "Final seasonal ARIMA forecast",
    subtitle = "Monthly wind generation series used in the forecasting project",
    x = NULL,
    y = "Wind generation (MW)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 16, color = "#102033"),
    plot.subtitle = element_text(size = 10.5, color = "#5c6b7d"),
    axis.title.y = element_text(face = "bold", color = "#102033"),
    axis.text = element_text(color = "#31465d"),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_line(color = "#dfe6ee"),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  )

ggsave(
  filename = output_path,
  plot = preview_plot,
  width = 11,
  height = 5.8,
  dpi = 300,
  bg = "white"
)
