library(tidyverse)
library(dslabs)
data(stars)
options(digits = 3)   # report 3 significant digits

mean_magnitude <- mean(stars$magnitude, na.rm = TRUE)

# Print the result
print(mean_magnitude)


std_dev_magnitude <- sd(stars$magnitude, na.rm = TRUE)

library(tidyverse)
library(dslabs)
data(stars)
options(digits = 3)   # report 3 significant digits

# Create the density plot of magnitude
ggplot(stars, aes(x = magnitude)) +
  geom_density(fill = "blue", alpha = 0.5) +
  labs(title = "Density Plot of Magnitude", x = "Magnitude", y = "Density") +
  theme_minimal()


library(tidyverse)
library(dslabs)
data(stars)
options(digits = 3)   # report 3 significant digits

# Create a scatter plot with temperature on the x-axis and magnitude on the y-axis
ggplot(stars, aes(x = temp, y = magnitude)) +
  geom_point(alpha = 0.5, color = "blue") +
  labs(title = "Scatter Plot of Temperature vs Magnitude", 
       x = "Temp", y = "Magnitude") +
  theme_minimal()

library(tidyverse)
library(dslabs)
data(stars)
options(digits = 3)   # report 3 significant digits

# Create a scatter plot with log-transformed temperature, flipped axes, and reversed y-axis
ggplot(stars, aes(x = temp, y = magnitude)) +
  geom_point(alpha = 0.5, color = "blue") +
  scale_x_log10() +  # Apply log base 10 transformation to temperature
  scale_y_reverse() +  # Reverse the y-axis to place lower magnitudes at the top
  labs(title = "Scatter Plot of Log(Temperature) vs Magnitude", 
       x = "Log(Temp)", y = "Magnitude") +
  theme_minimal()

library(dplyr)

# Filter for white dwarfs (high temperature, high magnitude)
white_dwarfs <- stars %>%
  filter(temp > 10000 & magnitude > 12)  # adjust the thresholds as needed

# Count the number of white dwarfs
n_white_dwarfs <- nrow(white_dwarfs)
n_white_dwarfs

library(dplyr)

# Filter stars with temperature over 5000K and find the one with the highest magnitude
least_luminous_star <- stars %>%
  filter(temp > 5000) %>%
  arrange(desc(magnitude)) %>%  # Sort by descending magnitude to find the least luminous
  slice(1)  # Take the first row (the star with the highest magnitude)

least_luminous_star

library(dplyr)

# Find the two stars with the lowest temperature and highest luminosity
supergiants <- stars %>%
  arrange(temp, magnitude) %>%  # Sort by lowest temperature and highest luminosity (lowest magnitude)
  slice(1:2)  # Take the first two rows

supergiants

library(tidyverse)
library(dslabs)

# Load the stars dataset
data(stars)

# Customize the plot
stars %>%
  ggplot(aes(x = temp, y = magnitude, color = star)) + 
  geom_point() + 
  scale_y_reverse() +  # Flip the y-axis so lower magnitude (brighter stars) is at the top
  scale_x_log10() +    # Take the log base 10 of temperature
  theme_minimal() +
  theme(legend.title = element_blank()) # Remove the legend title

library(dplyr)
library(dslabs)

# Load the stars dataset
data(stars)

# Find the star with the highest temperature
highest_temp_star <- stars %>%
  filter(temp == max(temp)) %>%
  select(star, temp)

highest_temp_star

library(dplyr)

# Assuming you have the stars data loaded
stars %>%
  filter(star == "White Dwarf") %>%
  nrow()

