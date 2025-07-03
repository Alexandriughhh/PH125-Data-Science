library(tidyverse)
library(dslabs)

data(death_prob)
head(death_prob)

p <- death_prob$prob[death_prob$age == 50 & death_prob$sex == "Female"]
print(p)

# Assume p is already defined from previous step

# Loss and gain values
loss_death <- -150000
gain_survive <- 1150

# Expected value calculation
expected_value <- (p * loss_death) + ((1 - p) * gain_survive)

print(expected_value)

# Assume p is already defined

# Possible profits
profit_death <- -150000
profit_survive <- 1150

# Expected value (mean), if not calculated yet
expected_value <- (p * profit_death) + ((1 - p) * profit_survive)

# Expected value of squared profits
expected_value_sq <- (p * profit_death^2) + ((1 - p) * profit_survive^2)

# Variance
variance <- expected_value_sq - expected_value^2

# Standard error (standard deviation)
standard_error <- sqrt(variance)

print(standard_error)

# Assuming expected_value is calculated for one policy

n_policies <- 1000

expected_total_profit <- n_policies * expected_value

print(expected_total_profit)

# Assume standard_error is the SE of one policy from previous step
n_policies <- 1000

standard_error_total <- standard_error * sqrt(n_policies)

print(standard_error_total)

# Assume expected_total_profit and standard_error_total are already calculated

# Probability the company loses money (total profit ≤ 0)
prob_loss <- pnorm(0, mean = expected_total_profit, sd = standard_error_total)

print(prob_loss)

# Assuming these variables are already defined:
# expected_total_profit: expected value over 1000 policies
# standard_error_total: standard error over 1000 policies

# Calculate probability of losing money (total profit ≤ 0)
probability_loss <- pnorm(0, mean = expected_total_profit, sd = standard_error_total)

print(probability_loss)

library(dslabs)

# Filter for age 50 and sex Male
p_male <- death_prob$prob[death_prob$age == 50 & death_prob$sex == "Male"]

print(p_male)


# Given values
n <- 1000
u_s <- 700000
a <- 150000

# p_male obtained earlier
p <- p_male

# Solve for premium b
premium <- (u_s / n + a * p) / (1 - p)

print(premium)

# Given values
n <- 1000
a <- 150000
p <- p_male   # death probability for 50-year-old male
b <- premium  # premium calculated previously

# Expected value per policy
mu <- p * (-a) + (1 - p) * b

# Expected value of squared profits
expected_sq <- p * ( -a )^2 + (1 - p) * b^2

# Variance and standard deviation of one policy
variance <- expected_sq - mu^2
sd_one_policy <- sqrt(variance)

# Standard error of the sum over n policies
standard_error_sum <- sd_one_policy * sqrt(n)

print(standard_error_sum)

# Expected value per policy mu (from before)
# Number of policies
n <- 1000

# Total expected profit
expected_total_profit <- n * mu

# Standard error of the total profit (calculated before)
# standard_error_sum

# Probability of losing money or breaking even
probability_loss <- pnorm(0, mean = expected_total_profit, sd = standard_error_sum)

print(probability_loss)

n <- 1000
p <- 0.015
a <- 150000
b <- 1150

expected_profit_per_policy <- p * (-a) + (1 - p) * b
expected_total_profit <- n * expected_profit_per_policy

print(expected_total_profit)

n <- 1000
p <- 0.015
a <- 150000
b <- 1150

mu <- p * (-a) + (1 - p) * b
expected_sq <- p * (-a)^2 + (1 - p) * b^2
variance <- expected_sq - mu^2
sd_one_policy <- sqrt(variance)
standard_error_total <- sd_one_policy * sqrt(n)

print(standard_error_total)

# From previous calculations
expected_total_profit <- n * mu  # mu is expected profit per policy
standard_error_total <- sd_one_policy * sqrt(n)

# Probability company loses money
prob_loss <- pnorm(0, mean = expected_total_profit, sd = standard_error_total)

print(prob_loss)


loss_threshold <- -1000000  # negative $1 million

prob_losing_more_than_1m <- pnorm(loss_threshold, mean = expected_total_profit, sd = standard_error_total)

print(prob_losing_more_than_1m)

n <- 1000
a <- 150000
b <- 1150  # fixed premium
death_probs <- seq(0.01, 0.03, 0.001)

loss_probs <- sapply(death_probs, function(p) {
  mu <- p * (-a) + (1 - p) * b
  expected_sq <- p * (-a)^2 + (1 - p) * b^2
  variance <- expected_sq - mu^2
  sd_one_policy <- sqrt(variance)
  expected_total <- n * mu
  se_total <- sd_one_policy * sqrt(n)
  
  p_loss <- pnorm(0, mean = expected_total, sd = se_total)
  return(p_loss)
})

# Find the smallest death probability where loss probability > 0.9
threshold <- 0.9
p_exceeding_90 <- death_probs[min(which(loss_probs > threshold))]

p_exceeding_90

n <- 1000
a <- 150000
b <- 1150  # fixed premium
loss_threshold <- -1000000  # losing more than $1 million
death_probs <- seq(0.01, 0.03, 0.0025)

prob_losing_over_1m <- sapply(death_probs, function(p) {
  mu <- p * (-a) + (1 - p) * b
  expected_sq <- p * (-a)^2 + (1 - p) * b^2
  variance <- expected_sq - mu^2
  sd_one_policy <- sqrt(variance)
  expected_total <- n * mu
  se_total <- sd_one_policy * sqrt(n)
  
  p_loss_over_1m <- pnorm(loss_threshold, mean = expected_total, sd = se_total)
  return(p_loss_over_1m)
})

threshold <- 0.9
lowest_p <- death_probs[min(which(prob_losing_over_1m > threshold))]

lowest_p

set.seed(25, sample.kind = "Rounding")

n <- 1000
p_loss <- 0.015
loss <- -150000
profit <- 1150

# Simulate claims (1 = claim/death, 0 = no claim)
claims <- rbinom(n, size = 1, prob = p_loss)

# Calculate profit or loss per policy
profits <- ifelse(claims == 1, loss, profit)

# Total profit over 1000 policies
total_profit <- sum(profits)

# Profit in millions
total_profit_millions <- total_profit / 1e6

total_profit_millions

set.seed(27, sample.kind = "Rounding")

n <- 1000
p_loss <- 0.015
loss <- -150000
profit <- 1150
num_simulations <- 10000
loss_threshold <- -1000000

simulated_profits <- replicate(num_simulations, {
  claims <- rbinom(n, size = 1, prob = p_loss)
  profits <- ifelse(claims == 1, loss, profit)
  sum(profits)
})

# Calculate probability of losing $1 million or more
prob_loss_1m <- mean(simulated_profits <= loss_threshold)

prob_loss_1m

p <- 0.015
l <- -150000
n <- 1000
z <- qnorm(0.05)  # -1.644854

# Define function to find the root (i.e., where P(loss) = 0.05)
f <- function(x) {
  mu <- n * (p * l + (1 - p) * x)
  sigma <- sqrt(n) * sqrt(p * (l - (p * l + (1 - p) * x))^2 + (1 - p) * (x - (p * l + (1 - p) * x))^2)
  prob_loss <- pnorm(0, mean = mu, sd = sigma)
  return(prob_loss - 0.05)
}

# Solve for x using uniroot in a reasonable range
x <- uniroot(f, c(1000, 5000))$root

x  # This is the required premium

p <- 0.015
l <- -150000

expected_profit <- p * l + (1 - p) * x
expected_profit

p <- 0.015
l <- -150000
n <- 1000

expected_profit_total <- n * (p * l + (1 - p) * x)
expected_profit_total

set.seed(28, sample.kind = "Rounding")

# Parameters
B <- 10000
n <- 1000
p <- 0.015
l <- -150000
# x is assumed to have been defined already

# Monte Carlo Simulation
profits <- replicate(B, {
  claims <- rbinom(n, size = 1, prob = p)
  sum(ifelse(claims == 1, l, x))
})

# Estimate probability of losing money
prob_loss <- mean(profits < 0)
prob_loss

set.seed(29, sample.kind = "Rounding")

# Parameters
B <- 10000
n <- 1000
base_p <- 0.015
l <- -150000
# Assume x is already defined

# Monte Carlo simulation
profits <- replicate(B, {
  # Randomly perturb p
  p_random <- base_p + sample(seq(-0.01, 0.01, length = 100), 1)
  
  # Ensure p stays within [0, 1]
  p_random <- max(min(p_random, 1), 0)
  
  # Generate claims and calculate profit
  claims <- rbinom(n, size = 1, prob = p_random)
  sum(ifelse(claims == 1, l, x))
})

mean(profits)

mean(profits < 0)

mean(profits < -1e6)

