library(tidyverse)
library(dslabs)

data(temp_carbon)

# Find earliest year where temp_anomaly > 0
earliest_above_mean <- temp_carbon %>%
  filter(!is.na(temp_anomaly), temp_anomaly > 0) %>%
  arrange(year) %>%
  slice(1)

print(earliest_above_mean)

library(tidyverse)
library(dslabs)

data(temp_carbon)

# Find the last year where temp_anomaly < 0
last_below_mean <- temp_carbon %>%
  filter(!is.na(temp_anomaly), temp_anomaly < 0) %>%
  arrange(desc(year)) %>%
  slice(1)

print(last_below_mean)

library(tidyverse)
library(dslabs)

data(temp_carbon)

# Find the first year where temp_anomaly > 0.5
first_above_half_degree <- temp_carbon %>%
  filter(!is.na(temp_anomaly), temp_anomaly > 0.5) %>%
  arrange(year) %>%
  slice(1)

print(first_above_half_degree)
