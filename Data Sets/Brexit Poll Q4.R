library(dslabs)
library(dplyr)

data(brexit_polls)

# Filter for polls ending June 1, 2016 or later
june_polls <- brexit_polls %>%
  filter(enddate >= as.Date("2016-06-01")) %>%
  mutate(
    x_hat = (spread + 1) / 2,                                     # Estimate of Remain proportion
    se_x_hat = sqrt(x_hat * (1 - x_hat) / samplesize),            # SE of x_hat
    se_spread = 2 * se_x_hat,                                     # SE of spread
    z = qnorm(0.975),                                             # z-value for 95% CI
    lower = spread - z * se_spread,                               # Lower bound of CI for spread
    upper = spread + z * se_spread,                               # Upper bound of CI for spread
    hit = (lower <= -0.038) & (upper >= -0.038)                   # Whether CI covers true spread
  )

# Count how many polls are in june_polls
n_polls <- nrow(june_polls)

# Calculate proportion of polls with CI covering 0
prop_cover_zero <- june_polls %>%
  summarize(proportion = mean(lower <= 0 & upper >= 0)) %>%
  pull(proportion)

prop_cover_zero

n_polls


# Proportion of polls with CI entirely above 0 (predicting Remain)
prop_remain <- june_polls %>%
  summarize(proportion = mean(lower > 0)) %>%
  pull(proportion)

prop_remain

# Proportion of polls where CI covers true spread d = -0.038
prop_cover_true_d <- june_polls %>%
  summarize(proportion = mean(hit)) %>%
  pull(proportion)

prop_cover_true_d

library(dplyr)

june_polls %>%
  group_by(pollster) %>%
  summarize(
    hit_rate = mean(hit),
    n_polls = n()
  ) %>%
  arrange(hit_rate)


library(ggplot2)

ggplot(june_polls, aes(x = poll_type, y = spread)) +
  geom_boxplot(fill = "skyblue", color = "darkblue") +
  labs(
    title = "Boxplot of Spread by Poll Type (June 2016+)",
    x = "Poll Type",
    y = "Spread (Remain - Leave)"
  ) +
  theme_minimal()

library(dplyr)

combined_by_type <- june_polls %>%
  group_by(poll_type) %>%
  summarize(
    N = sum(samplesize),
    spread = sum(spread * samplesize) / N,
    p_hat = (spread + 1) / 2
  ) %>%
  mutate(
    se_p_hat = sqrt(p_hat * (1 - p_hat) / N),       # SE of p_hat
    se_spread = 2 * se_p_hat,                       # SE of spread (double)
    z = qnorm(0.975),
    lower = spread - z * se_spread,                 # Lower 95% CI bound
    upper = spread + z * se_spread                  # Upper 95% CI bound
  )

combined_by_type

# Extract lower bound for Online poll type
online_lower_bound <- combined_by_type %>%
  filter(poll_type == "Online") %>%
  pull(lower)

online_lower_bound

# Extract upper bound for Online poll type
online_upper_bound <- combined_by_type %>%
  filter(poll_type == "Online") %>%
  pull(upper)

online_upper_bound

