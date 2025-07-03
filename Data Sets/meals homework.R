# Meal components
entrees <- choose(6, 1)
sides <- choose(6, 3)     # 3 sides from 6
drinks <- choose(3, 1)

# Total number of unique meals
total_meals <- entrees * sides * drinks
print(total_meals)

# Function to calculate total meal combinations for a given number of entrees
meal_combinations <- function(entree_count) {
  sides <- choose(6, 2)    # 2 sides from 6
  drinks <- choose(3, 1)   # 1 drink from 3
  total <- entree_count * sides * drinks
  return(total)
}

# Test entree counts from 1 to 12
entree_range <- 1:12
combinations <- sapply(entree_range, meal_combinations)

# Print combinations for each number of entrees
print(data.frame(Entrees = entree_range, Combinations = combinations))

# Find the minimum number of entrees needed to exceed 365 combinations
min_entrees_needed <- min(entree_range[combinations > 365])
print(min_entrees_needed)


# Function to calculate meal combinations based on number of side options
meal_combinations_by_sides <- function(side_count) {
  entrees <- 6
  drinks <- 3
  sides <- choose(side_count, 2)  # 2 sides from side_count options
  total <- entrees * sides * drinks
  return(total)
}

# Test side counts from 2 to 12
side_range <- 2:12
combinations <- sapply(side_range, meal_combinations_by_sides)

# Print combinations for each number of side options
print(data.frame(SideOptions = side_range, Combinations = combinations))

# Find the minimum number of side options needed to exceed 365 combinations
min_sides_needed <- min(side_range[combinations > 365])
print(min_sides_needed)

