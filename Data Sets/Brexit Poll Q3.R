library(dplyr)
library(dslabs)

data(brexit_polls)

# Add x_hat if not already done
brexit_polls <- brexit_polls %>%
  mutate(x_hat = (spread + 1) / 2)

# Extract first poll's values
first_poll <- brexit_polls[1, ]
x_hat <- first_poll$x_hat
N <- first_poll$samplesize

# Calculate standard error
SE <- sqrt(x_hat * (1 - x_hat) / N)

# Critical z-value for 95% CI
z <- qnorm(0.975)

# Calculate lower bound
lower_bound <- x_hat - z * SE
lower_bound

# Calculate upper bound
upper_bound <- x_hat + z * SE
upper_bound

# True proportion on referendum day
true_p <- 0.481

# Check if 0.5 is inside the CI
covers_0.5 <- (lower_bound <= 0.5) & (upper_bound >= 0.5)

# Check if true_p is inside the CI
covers_true_p <- (lower_bound <= true_p) & (upper_bound >= true_p)

list(
  covers_0.5 = covers_0.5,
  covers_true_p = covers_true_p
)
