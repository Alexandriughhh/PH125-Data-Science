library(dplyr)

# Filter for lowest alcohol group
lowest_alc <- esoph %>% filter(alcgp == "0-39g/day")

# Calculate total cases and total subjects
total_cases <- sum(lowest_alc$ncases)
total_subjects <- sum(lowest_alc$ncases + lowest_alc$ncontrols)

# Probability of being a cancer case in lowest alcohol group
prob_case <- total_cases / total_subjects
prob_case

p <- 1/4
expected_score <- 44 * p
expected_score

p_values <- seq(0.25, 0.95, 0.05)
threshold <- 35
required_prob <- 0.8

# Calculate the probability of scoring > 35 for each p
prob_over_35 <- sapply(p_values, function(p) {
  1 - pbinom(threshold, size = 44, prob = p)
})

# Find the lowest p for which probability > 0.8
p_values[which(prob_over_35 > required_prob)[1]]


# Assuming p is known (e.g., from death_prob dataset)
n <- 1000
p <- [probability_of_death] # replace with actual value

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
