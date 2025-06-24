library(gtools)
library(tidyverse)

total_ways <- factorial(8) / factorial(8 - 3)
print(total_ways)

jamaica_medal_ways <- factorial(3)
print(jamaica_medal_ways)

# Number of favorable outcomes (all medals to Jamaica)
favorable <- factorial(3)

# Total number of ways to assign medals to 8 runners
total <- factorial(8) / factorial(8 - 3)

# Probability all medals go to Jamaica
probability <- favorable / total
print(probability)

runners <- c("Jamaica", "Jamaica", "Jamaica", "USA", "Ecuador", "Netherlands", "France", "South Africa")
B <- 10000
set.seed(1)
results <- replicate(B, {
  medalists<- sample(runners, size = 3, replace = FALSE)
  all(medalists == "Jamaica")
})
probability <- mean(results)
print(probability)

# Number of ways to choose each component
entrees <- choose(6, 1)
sides <- choose(6, 2)
drinks <- choose(2, 1)

# Total number of unique meals
total_meals <- entrees * sides * drinks
print(total_meals)

# Updated drink options
entrees <- choose(6, 1)
sides <- choose(6, 2)
drinks <- choose(3, 1)

# Total combinations with 3 drink choices
total_meals_updated <- entrees * sides * drinks
print(total_meals_updated)

 Number of ways to choose each component
Entree#s <- choose(6,1)
Sides <- choose(6,3)
Drinks <- choose(3,1)

# Total number of unique meals
total_meals <- entrees * sides * drinks
print(total_meals)
