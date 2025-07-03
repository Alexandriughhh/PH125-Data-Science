library(dslabs)
data("research_funding_rates")
research_funding_rates

#what is the number of men not awarded?

library(dplyr)
library(dslabs)

data("research_funding_rates")

# Calculate total number of men not awarded
total_men_not_awarded <- research_funding_rates %>%
  summarize(not_awarded = sum(applications_men - awards_men)) %>%
  pull(not_awarded)

total_men_not_awarded

# Calculate total number of women not awarded
total_women_not_awarded <- research_funding_rates %>%
  summarize(not_awarded = sum(applications_women - awards_women)) %>%
  pull(not_awarded)

total_women_not_awarded

#What is the percentage of men awarded?

library(dplyr)
library(dslabs)

data("research_funding_rates")

# Summarize total applications and awards
totals <- research_funding_rates %>%
  summarize(
    men_awarded = sum(awards_men),
    men_applied = sum(applications_men),
    women_awarded = sum(awards_women),
    women_applied = sum(applications_women)
  )

totals

men_awarded_pct <- totals$men_awarded / totals$men_applied * 100
men_awarded_pct

# What is percentage of women awarded?
women_awarded_pct <- totals$women_awarded / totals$women_applied * 100
women_awarded_pct

# Run a chi-squared test External link on the two-by-two table to determine whether the difference in the two funding awarded rates is significant. (You can use tidy() to turn the output of chisq.test() into a data frame as well.)
#What is the p-value of the difference in funding awarded rate?

library(dplyr)
library(dslabs)
library(broom)

data("research_funding_rates")

# Step 1: Create totals for the 2x2 table
totals <- research_funding_rates %>%
  summarize(
    men_awarded   = sum(awards_men),
    men_not_award = sum(applications_men - awards_men),
    women_awarded = sum(awards_women),
    women_not_award = sum(applications_women - awards_women)
  )

# Step 2: Build the 2x2 matrix
two_by_two <- matrix(c(
  totals$men_awarded, totals$men_not_award,
  totals$women_awarded, totals$women_not_award
), nrow = 2, byrow = TRUE)

colnames(two_by_two) <- c("awarded", "not_awarded")
rownames(two_by_two) <- c("men", "women")

# Step 3: Perform chi-squared test
chi_test <- chisq.test(two_by_two)

# Step 4: Extract the p-value using tidy()
tidy(chi_test)

# To settle this dispute, use this dataset with number of applications, awards, and success rate for each gender:

dat <- research_funding_rates %>% 
  mutate(discipline = reorder(discipline, success_rates_total)) %>%
  rename(success_total = success_rates_total,
         success_men = success_rates_men,
         success_women = success_rates_women) %>%
  pivot_longer(-discipline) %>%
  separate(name, c("type", "gender")) %>%
  pivot_wider(names_from = type, values_from = value) %>%
  filter(gender != "total")
dat
  
ggplot(dat, aes(x = discipline, y = success, color = gender, size = applications)) +
  geom_point() +
  coord_flip() +
  labs(title = "Success Rate by Discipline and Gender",
       y = "Success Rate", x = "Discipline") +
  theme_minimal()

dat_wide <- dat %>%
  select(discipline, gender, success) %>%
  pivot_wider(names_from = gender, values_from = success)

dat_wide %>%
  filter(men > women)

# Which two fields have the lowest overall funding rates?
library(dplyr)
library(dslabs)

data("research_funding_rates")

research_funding_rates %>%
  select(discipline, success_rates_total) %>%
  arrange(success_rates_total) %>%
  slice(1:2)

