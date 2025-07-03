# suggested libraries and options
library(tidyverse)
options(digits = 3)

# load brexit_polls object
library(dslabs)
data(brexit_polls)

p <- 0.481    # official proportion voting "Remain"
d <- 2*p-1    # official spread

# Given values
p <- 0.481
N <- 1500

# Expected number of "Remain" voters
expected_remain <- p * N
expected_remain

# Given values
p <- 0.481
N <- 1500

# Standard error of the total number choosing "Remain"
SE <- sqrt(N * p * (1 - p))
SE


# Given value
p <- 0.481

# Expected value of the proportion X
expected_X <- p
expected_X


# Given values
p <- 0.481
N <- 1500

# Standard error of the sample proportion X hat
SE_hatX <- sqrt(p * (1 - p) / N)
SE_hatX

# Given value
p <- 0.481

# Expected value of the spread d
expected_d <- 2 * p - 1
expected_d


# Given values
p <- 0.481
N <- 1500

# Standard error of sample proportion
SE_p <- sqrt(p * (1 - p) / N)

# Standard error of the spread d
SE_d <- 2 * SE_p
SE_d

