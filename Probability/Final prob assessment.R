library(tidyverse)
library(dslabs)

data(death_prob)

# Filter for 50-year-old females
p <- death_prob %>%
  filter(age == 50, sex == "Female") %>%
  pull(prob)

library(tidyverse)
library(dslabs)

data(death_prob)

# Get probability of death for 50-year-old females
p <- death_prob %>% filter(age == 50, sex == "Female") %>% pull(prob)

# Parameters
a <- -150000
b <- 1150
n <- 1000

# Expected value and standard deviation of profit per policy
mu <- a * p + b * (1 - p)
sigma2 <- p * (a - mu)^2 + (1 - p) * (b - mu)^2
sigma <- sqrt(sigma2)

# Probability company loses money over 1000 policies
prob_loss <- pnorm(0, mean = n * mu, sd = sqrt(n) * sigma)
prob_loss

p_values <- seq(0.25, 0.95, 0.05)
n <- 44
threshold <- 35
prob_over_35 <- numeric(length(p_values))

for (i in seq_along(p_values)) {
  p <- p_values[i]
  mu_p <- 1 * p + (-0.25) * (1 - p)
  var_p <- p * (1 - mu_p)^2 + (1 - p) * (-0.25 - mu_p)^2
  sd_p <- sqrt(var_p)
  
  mu_total <- n * mu_p
  sd_total <- sqrt(n) * sd_p
  
  prob_over_35[i] <- 1 - pnorm(threshold, mean = mu_total, sd = sd_total)
}

# Find lowest p where prob_over_35 > 0.8
lowest_p <- p_values[min(which(prob_over_35 > 0.8))]
print(lowest_p)