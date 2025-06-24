library(Lahman)
library(tidyverse)
library(dslabs)
ds_theme_set()

# Scatterplot of the relationship between HRs and wins
Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(HR_per_game = HR / G, R_per_game = R / G) %>%
  ggplot(aes(HR_per_game, R_per_game)) + 
  geom_point(alpha = 0.5)

# Scatterplot of the relationship between stolen bases and wins
Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(SB_per_game = SB / G, R_per_game = R / G) %>%
  ggplot(aes(SB_per_game, R_per_game)) + 
  geom_point(alpha = 0.5)

# Scatterplot of the relationship between bases on balls and runs
Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(BB_per_game = BB / G, R_per_game = R / G) %>%
  ggplot(aes(BB_per_game, R_per_game)) + 
  geom_point(alpha = 0.5)

?Teams

Teams %>%
  filter(yearID %in% 1961:2001) %>%
  mutate(AB_per_game = AB / G, R_per_game = R / G) %>%
  ggplot(aes(x = AB_per_game, y = R_per_game)) + 
  geom_point(alpha = 0.5)

Teams %>%
  filter(yearID %in% 1961:2001) %>%
  mutate(W_per_game = W / G, E_per_game = E / G) %>%
  ggplot(aes(x = W_per_game, y = E_per_game)) + 
  geom_point(alpha = 0.5)

Teams %>%
  filter(yearID %in% 1961:2001) %>%
  mutate(X3B_per_game = W / G, X2B_per_game = E / G) %>%
  ggplot(aes(x = X3B_per_game, y = X2B_per_game)) + 
  geom_point(alpha = 0.5)


#Correlation Coefficient Teams
Teams %>%
  filter(yearID %in% 1961:2001) %>%
  summarize(correlation = cor(R / G, AB / G))

Teams %>%
  filter(yearID %in% 1961:2001) %>%
  summarize(correlation = cor(W / G, E / G))

Teams %>%
  filter(yearID %in% 1961:2001) %>%
  summarize(correlation = cor(X2B / G, X3B / G))

git pull origin main --allow-unrelated-histories


