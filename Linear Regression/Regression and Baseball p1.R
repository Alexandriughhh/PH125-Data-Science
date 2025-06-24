# Load necessary libraries
library(Lahman)
library(tidyverse)
library(broom)

# Filter for the 1971 season and fit the model
model_1971 <- Teams %>%
  filter(yearID == 1971) %>%
  lm(R ~ BB + HR, data = .)

# Tidy up the model results into a data frame
tidy_results <- tidy(model_1971)

# View the results
tidy_results

library(Lahman)
library(tidyverse)
library(broom)

# Filter data and fit model for each year
bb_trend <- Teams %>%
  filter(yearID >= 1961, yearID <= 2018) %>%
  group_by(yearID) %>%
  do(tidy(lm(R ~ BB + HR, data = .))) %>%
  ungroup() %>%
  filter(term == "BB")  # Only keep BB coefficient

# Make the scatterplot with a trend line
bb_trend %>%
  ggplot(aes(x = yearID, y = estimate)) +
  geom_point() +
  geom_smooth(method = "loess", se = TRUE) +
  labs(
    title = "Effect of BB on Runs (1961–2018)",
    x = "Year",
    y = "Estimated Effect of BB on Runs"
  ) +
  theme_minimal()

res <- Teams %>%
  filter(yearID %in% 1961:2018) %>%
  group_by(yearID) %>%
  summarize(tidy(lm(R ~ BB + HR, data = across()))) %>%
  ungroup() 
res %>%
  filter(term == "BB") %>%
  ggplot(aes(yearID, estimate)) +
  geom_point() +
  geom_smooth(method = "lm")
