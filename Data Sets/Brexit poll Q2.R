# suggested libraries and options
library(tidyverse)
options(digits = 3)

# load brexit_polls object
library(dslabs)
data(brexit_polls)

brexit_polls <- brexit_polls %>%
  mutate(x_hat = (spread + 1) / 2)

library(dslabs)
library(dplyr)

data(brexit_polls)

# Calculate the average of the observed spreads
average_spread <- mean(brexit_polls$spread)
average_spread

library(dslabs)
library(dplyr)

data(brexit_polls)

# Calculate the standard deviation of the observed spreads
sd_spread <- sd(brexit_polls$spread)
sd_spread

brexit_polls <- brexit_polls %>%
  mutate(x_hat = (spread + 1) / 2)

library(dplyr)

# Assuming x_hat is already added to brexit_polls
brexit_polls %>%
  summarize(avg_x_hat = mean(x_hat))

brexit_polls <- brexit_polls %>%
  mutate(x_hat = (spread + 1) / 2)

library(dplyr)

brexit_polls %>%
  summarize(sd_x_hat = sd(x_hat))
