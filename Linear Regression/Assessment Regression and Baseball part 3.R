# Interpret the p-values for the estimates using a cutoff of 0.05 and considering the year 1971 as a sample to make inference on the population of all baseball games across years.
model_1971 <- Teams %>%
  filter(yearID == 1971) %>%
  lm(R ~ BB + HR, data = .)

tidy(model_1971)

