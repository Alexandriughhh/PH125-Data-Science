greenhouse_gases %>%
  ggplot(aes(x = year, y = concentration)) +  # fill the blank here
  geom_line() +
  facet_grid(gas ~ ., scales = "free") +
  geom_vline(xintercept = 1850, linetype = "dashed", color = "red") +  # vertical line at 1850
  ylab("Concentration (ch4/n2o ppb, co2 ppm)") +
  ggtitle("Atmospheric greenhouse gas concentration by year, 0-2000")
