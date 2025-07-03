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

library(tidyverse)
library(dslabs)

data(temp_carbon)

# Create the plot with global, ocean, and land temperature anomalies
p <- temp_carbon %>%
  filter(!is.na(temp_anomaly) & !is.na(ocean_anomaly) & !is.na(land_anomaly)) %>%
  ggplot(aes(x = year)) +
  geom_line(aes(y = temp_anomaly, color = "Global"), size = 1) +
  geom_line(aes(y = ocean_anomaly, color = "Ocean"), size = 1) +
  geom_line(aes(y = land_anomaly, color = "Land"), size = 1) +
  geom_hline(yintercept = 0, color = "blue") +
  ylab("Temperature anomaly (degrees C)") +
  ggtitle("Temperature anomaly relative to 20th century mean, 1880–2018") +
  scale_color_manual(values = c("Global" = "black", "Ocean" = "blue", "Land" = "red")) +
  annotate("text", x = 2000, y = 0.05, label = "20th century mean", color = "blue")

print(p)

library(tidyverse)
library(dslabs)

data(temp_carbon)

# Calculate the temperature change for each region (global, ocean, land) from 1880 to 2018
temp_change <- temp_carbon %>%
  filter(year == 1880 | year == 2018) %>%
  group_by(year) %>%
  summarize(
    global_anomaly = mean(temp_anomaly, na.rm = TRUE),
    ocean_anomaly = mean(ocean_anomaly, na.rm = TRUE),
    land_anomaly = mean(land_anomaly, na.rm = TRUE)
  ) %>%
  spread(year, global_anomaly:ocean_anomaly) %>%
  mutate(
    global_change = `2018` - `1880`,
    ocean_change = ocean_anomaly_2018 - ocean_anomaly_1880,
    land_change = land_anomaly_2018 - land_anomaly_1880
  )

# Print the temperature change for each region
print(temp_change)
