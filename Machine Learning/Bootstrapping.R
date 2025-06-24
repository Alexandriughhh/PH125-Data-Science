# Bootstrapping

# define the population distribution of income
set.seed(1995)
n <- 10^6
income <- 10^(rnorm(n, log10(45000), log10(3)))
qplot(log10(income), bins = 30, color = I("black"))

# calculate the population median
m <- median(income)
m

# estimate the population median
N <- 100
X <- sample(income, N)
M<- median(X)
M

# use a Monte Carlo simulation to learn the distribution of M
library(gridExtra)
B <- 10^4
M <- replicate(B, {
  X <- sample(income, N)
  median(X)
})
p1 <- qplot(M, bins = 30, color = I("black"))
p2 <- qplot(sample = scale(M), xlab = "theoretical", ylab = "sample") + geom_abline()
grid.arrange(p1, p2, ncol = 2)

# compare the 95% CI based on the CLT to the actual one
median(X) + 1.96 * sd(X) / sqrt(N) * c(-1, 1)
quantile(M, c(0.025, 0.975))

# bootstrap and approximate the distribution
B <- 10^4
M_star <- replicate(B, {
  X_star <- sample(X, N, replace = TRUE)
  median(X_star)
})

# look at the confidence interval from the bootstrap
quantile(M_star, c(0.025, 0.975))



# How many times do 3, 4, and 7 appear in the first resampled index?

library(dslabs)
library(caret)

data(mnist_27)
set.seed(1995)

# Generate bootstrap indexes
indexes <- createResample(mnist_27$train$y, times = 10)

# View how many times indices 3, 4, and 7 appear in the first resample
table(indexes[[1]])[c("3", "4", "7")]

# Repeat the exercise for all the resampled indexes.
# What is the total number of times that 3 appears in all of the resampled indexes?

library(dslabs)
library(caret)

data(mnist_27)
set.seed(1995)

# Generate 10 bootstrap samples
indexes <- createResample(mnist_27$train$y, times = 10)

# Count how many times index 3 appears across all samples
sum(sapply(indexes, function(ind) sum(ind == 3)))

# perform a Monte Carlo simulation with 10,000 repetitions, generating the random dataset and estimating the 75th quantile each time. 
  
set.seed(1)

# Monte Carlo simulation
B <- 10000
n <- 100

q75_estimates <- replicate(B, {
  y <- rnorm(n, 0, 1)
  quantile(y, 0.75)
})

# Expected value and standard error
expected_value <- mean(q75_estimates)
standard_error <- sd(q75_estimates)

c(Expected_Value = expected_value, Standard_Error = standard_error)

# without monte carlo simulation (Bootstrapping)

library(caret)

# Generate original sample
set.seed(1)
y <- rnorm(100, 0, 1)

# Bootstrap resampling
set.seed(1)  # reset seed for reproducibility of bootstrap
B <- 10000
bootstrap_indexes <- createResample(y, times = B)

# Calculate the 75th quantile for each bootstrap sample
q75_estimates <- sapply(bootstrap_indexes, function(index) {
  quantile(y[index], 0.75)
})

# Calculate expected value and standard error
expected_value <- mean(q75_estimates)
standard_error <- sd(q75_estimates)

c(Expected_Value = expected_value, Standard_Error = standard_error)

