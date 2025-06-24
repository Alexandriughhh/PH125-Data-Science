library(tidyverse)
library(dslabs)

data(death_prob)
head(death_prob)

# Assuming p is known (e.g., from death_prob dataset)
n <- 1000
p <- probability_of_death # replace with actual value

a <- -150000
b <- 1150

# Expected value
mu <- a * p + b * (1 - p)

# Variance
sigma2 <- p * (a - mu)^2 + (1 - p) * (b - mu)^2
sigma <- sqrt(sigma2)

# Calculate probability losing money (S < 0)
prob_loss <- pnorm(0, mean = n * mu, sd = sqrt(n) * sigma)
prob_loss
