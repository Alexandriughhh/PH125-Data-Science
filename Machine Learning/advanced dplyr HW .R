library(tidyverse)
library(HistData)
data("GaltonFamilies")
# set.seed(1) # if you are using R 3.5 or earlier
set.seed(1, sample.kind = "Rounding") # if you are using R 3.6 or later
galton <- GaltonFamilies %>%
  group_by(family, gender) %>%
  sample_n(1) %>%
  ungroup() %>% 
  gather(parent, parentHeight, father:mother) %>%
  mutate(child = ifelse(gender == "female", "daughter", "son")) %>%
  unite(pair, c("parent", "child"))

galton

library(tidyverse)
library(HistData)

data("GaltonFamilies")

set.seed(1, sample.kind = "Rounding")  # For R 3.6+

galton <- GaltonFamilies %>%
  group_by(family, gender) %>%
  sample_n(1) %>%
  ungroup() %>% 
  gather(parent, parentHeight, father:mother) %>%
  mutate(child = ifelse(gender == "female", "daughter", "son")) %>%
  unite(pair, c("parent", "child"))

# Group by pair and count
galton %>%
  group_by(pair) %>%
  summarize(count = n())

# Calculate correlation between parentHeight and childHeight for each pair
galton %>%
  group_by(pair) %>%
  summarize(correlation = cor(parentHeight, childHeight))

library(broom)

# Fit linear models and extract tidy output for each pair
results <- galton %>%
  group_by(pair) %>%
  do(tidy(lm(childHeight ~ parentHeight, data = .), conf.int = TRUE)) %>%
  filter(term == "parentHeight")

results
