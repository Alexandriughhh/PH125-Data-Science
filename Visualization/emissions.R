library(tidyverse)
library(dslabs)

data(temp_carbon)

# View the structure to understand what columns are available
glimpse(temp_carbon)

# Filter for the first and last available years with carbon_emissions data
emissions_change <- temp_carbon %>%
  filter(!is.na(carbon_emissions)) %>%
  arrange(year) %>%
  summarize(
    first_year = first(year),
    first_emission = first(carbon_emissions),
    last_year = last(year),
    last_emission = last(carbon_emissions),
    change = last_emission - first_emission
  )

print(emissions_change)


library(tidyverse)
library(dslabs)

data(temp_carbon)

# Calculate relative change
emissions_ratio <- temp_carbon %>%
  filter(!is.na(carbon_emissions)) %>%
  arrange(year) %>%
  summarize(
    first_year = first(year),
    first_emission = first(carbon_emissions),
    last_year = last(year),
    last_emission = last(carbon_emissions),
    times_larger = last_emission / first_emission
  )

print(emissions_ratio)


library(tidyverse)
library(dslabs)

data(temp_carbon)

# Find the first year with non-NA temp_anomaly
first_temp_year <- temp_carbon %>%
  filter(!is.na(temp_anomaly)) %>%
  arrange(year) %>%
  slice(1)

print(first_temp_year)


library(tidyverse)
library(dslabs)

data(temp_carbon)

# Find the last year with non-NA temp_anomaly
last_temp_year <- temp_carbon %>%
  filter(!is.na(temp_anomaly)) %>%
  arrange(desc(year)) %>%
  slice(1)

print(last_temp_year)


library(tidyverse)
library(dslabs)

data(temp_carbon)

# Get the first and last year with non-NA temp_anomaly data
temp_change <- temp_carbon %>%
  filter(!is.na(temp_anomaly)) %>%
  arrange(year) %>%
  summarize(
    first_year = first(year),
    first_temp = first(temp_anomaly),
    last_year = last(year),
    last_temp = last(temp_anomaly),
    temp_increase = last_temp - first_temp
  )

print(temp_change)


library(tidyverse)
library(dslabs)

data(temp_carbon)

# Create the plot
p <- temp_carbon %>%
  filter(!is.na(temp_anomaly)) %>%
  ggplot(aes(x = year, y = temp_anomaly)) +
  geom_line() +
  ylab("Temperature anomaly (°C)") +
  ggtitle("Global Temperature Anomaly Over Time")
p

p <- p + geom_hline(aes(yintercept = 0), col = "blue")
p

p <- temp_carbon %>%
  filter(!is.na(temp_anomaly)) %>%
  ggplot(aes(x = year, y = temp_anomaly)) +
  geom_line() +
  geom_hline(yintercept = 0, color = "blue") +
  ylab("Temperature anomaly (degrees C)") +
  ggtitle("Temperature anomaly relative to 20th century mean, 1880–2018") +
  annotate("text", x = 2000, y = 0.05, label = "20th century mean", color = "blue")
p

p + ylab("Temperature anomaly (degrees C)") +
  title("Temperature anomaly relative to 20th century mean, 1880-2018") +
  geom_text(aes(x = 2000, y = 0.05, label = "20th century mean"), col = "blue")
p

library(tidyverse)
library(dslabs)

data(temp_carbon)

# Find earliest year where temp_anomaly > 0
earliest_above_mean <- temp_carbon %>%
  filter(!is.na(temp_anomaly), temp_anomaly > 0) %>%
  arrange(year) %>%
  slice(1)

print(earliest_above_mean)




