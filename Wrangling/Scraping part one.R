library(dplyr)
library(Lahman)
library(tidyverse)
library(magrittr)

library(dplyr)
library(Lahman)

# Filter AwardsPlayers to 2016
awards_2016 <- AwardsPlayers %>% filter(yearID == 2016)

# Get top 10 HR hitters in 2016
top <- Batting %>% 
  filter(yearID == 2016) %>%
  arrange(desc(HR)) %>%    
  slice(1:10)    

# Find how many top 10 HR hitters won awards
top_award_winners <- top %>% semi_join(awards_2016, by = "playerID")

# Count them
num_winners <- nrow(top_award_winners)
num_winners

library(dplyr)
library(Lahman)

# Awards in 2016
awards_2016 <- AwardsPlayers %>% filter(yearID == 2016)

# Top 10 HR hitters in 2016
top <- Batting %>% 
  filter(yearID == 2016) %>%
  arrange(desc(HR)) %>%    
  slice(1:10)

# Find award winners NOT in top 10 HR hitters
award_not_top <- awards_2016 %>% anti_join(top, by = "playerID")

# Count them
num_award_not_top <- nrow(distinct(award_not_top, playerID))
num_award_not_top
