# suggested libraries
library(tidyverse)

# load brexit_polls object and add x_hat column
library(dslabs)
data(brexit_polls)
brexit_polls <- brexit_polls %>%
  mutate(x_hat = (spread + 1)/2)

# final proportion voting "Remain"
p <- 0.481


brexit_hit <- brexit_polls %>%
  mutate(p_hat = (spread + 1)/2,
         se_spread = 2*sqrt(p_hat*(1-p_hat)/samplesize),
         spread_lower = spread - qnorm(.975)*se_spread,
         spread_upper = spread + qnorm(.975)*se_spread,
         hit = spread_lower < -0.038 & spread_upper > -0.038) %>%
  select(poll_type, hit)

library(dplyr)

# Assuming brexit_hit is already defined as you provided
# Filter only online and telephone polls, then create a contingency table
table_hit <- brexit_hit %>%
  filter(poll_type %in% c("Online", "Telephone")) %>%
  table()

# Perform chi-squared test
chisq_result <- chisq.test(table_hit)

# Extract p-value
chisq_result$p.value

# Filter only online and telephone polls and make the table again
table_hit <- brexit_hit %>%
  filter(poll_type %in% c("Online", "Telephone")) %>%
  table()

# Extract counts
online_hits <- table_hit["Online", TRUE]
online_misses <- table_hit["Online", FALSE]

telephone_hits <- table_hit["Telephone", TRUE]
telephone_misses <- table_hit["Telephone", FALSE]

# Calculate odds for online and telephone
odds_online <- online_hits / online_misses
odds_telephone <- telephone_hits / telephone_misses

hit_rates <- brexit_hit %>%
  filter(poll_type %in% c("Online", "Telephone")) %>%
  group_by(poll_type) %>%
  summarize(hit_rate = mean(hit))

hit_rates

# Create 2x2 table again
table_hit <- brexit_hit %>%
  filter(poll_type %in% c("Online", "Telephone")) %>%
  table()

# Perform chi-squared test
chisq_result <- chisq.test(table_hit)

chisq_result$p.value

library(dplyr)

# Calculate hit rates
hit_rates <- brexit_hit %>%
  filter(poll_type %in% c("Online", "Telephone")) %>%
  group_by(poll_type) %>%
  summarize(hit_rate = mean(hit))

# Create table and test
table_hit <- brexit_hit %>%
  filter(poll_type %in% c("Online", "Telephone")) %>%
  table()

chisq_result <- chisq.test(table_hit)

# Output
list(
  hit_rates = hit_rates,
  p_value = chisq_result$p.value
)



# Calculate odds ratio
odds_ratio <- odds_online / odds_telephone

# Output odds for online and odds ratio
list(
  odds_online = odds_online,
  odds_ratio = odds_ratio
)

