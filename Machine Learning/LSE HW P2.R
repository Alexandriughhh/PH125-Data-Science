set.seed(1989) #if you are using R 3.5 or earlier
library(HistData)
data("GaltonFamilies")
options(digits = 3)    # report 3 significant digits

female_heights <- GaltonFamilies %>%     
  filter(gender == "female") %>%     
  group_by(family) %>%     
  sample_n(1) %>%     
  ungroup() %>%     
  select(mother, childHeight) %>%     
  rename(daughter = childHeight)

# Fit the linear regression model: mother ~ daughter
model <- lm(mother ~ daughter, data = female_heights)

# Extract the slope (coefficient for daughter)
slope <- coef(model)["daughter"]
round(slope, 3)

# Fit the model
model <- lm(mother ~ daughter, data = female_heights)

# Extract the intercept
intercept <- coef(model)["(Intercept)"]
round(intercept, 3)

# Fit the linear regression model: mother ~ daughter
model <- lm(mother ~ daughter, data = female_heights)

# Extract the slope (coefficient for daughter)
slope <- coef(model)["daughter"]

model <- lm(daughter ~ mother, data = female_heights)
slope <- coef(model)["mother"]
intercept <- coef(model)["(Intercept)"]
round(slope, 3)
round(intercept, 3)


library(Lahman)
bat_02 <- Batting %>% filter(yearID == 2002) %>%
  mutate(pa = AB + BB, singles = (H - X2B - X3B - HR)/pa, bb = BB/pa) %>%
  filter(pa >= 100) %>%
  select(playerID, singles, bb)

library(Lahman)
library(tidyverse)

# Step 1–4: Compute per stint stats for 1999–2001 and filter
bat_99_01 <- Batting %>%
  filter(yearID %in% 1999:2001) %>%
  mutate(pa = AB + BB,
         singles = (H - X2B - X3B - HR) / pa,
         bb = BB / pa) %>%
  filter(pa >= 100)

# Step 5: Compute average rates per player over 3 years
avg_rates <- bat_99_01 %>%
  group_by(playerID) %>%
  summarize(
    mean_singles = mean(singles, na.rm = TRUE),
    mean_bb = mean(bb, na.rm = TRUE)
  )

# Step 6: Count players with mean_singles > 0.2
sum(avg_rates$mean_singles > 0.2, na.rm = TRUE)

# Count players with mean_bb > 0.2
sum(avg_rates$mean_bb > 0.2, na.rm = TRUE)

# Combine 2002 data with 1999–2001 averages using inner_join
combined_data <- inner_join(bat_02, avg_rates, by = "playerID")

# Calculate correlation between 2002 singles and 1999–2001 average singles
correlation_singles <- cor(combined_data$singles, combined_data$mean_singles, use = "complete.obs")

# Show result
round(correlation_singles, 3)

# Calculate correlation between 2002 BB rate and 1999–2001 average BB rate
correlation_bb <- cor(combined_data$bb, combined_data$mean_bb, use = "complete.obs")

# Show result rounded to 3 decimals
round(correlation_bb, 3)


library(ggplot2)

# Scatterplot: mean_singles vs. 2002 singles
ggplot(combined_data, aes(x = mean_singles, y = singles)) +
  geom_point(alpha = 0.5) +
  labs(
    title = "Singles Rate: 1999–2001 Avg vs 2002",
    x = "Average Singles Rate (1999–2001)",
    y = "Singles Rate (2002)"
  )

# Scatterplot: mean_bb vs. 2002 bb
ggplot(combined_data, aes(x = mean_bb, y = bb)) +
  geom_point(alpha = 0.5) +
  labs(
    title = "Walk Rate: 1999–2001 Avg vs 2002",
    x = "Average Walk Rate (1999–2001)",
    y = "Walk Rate (2002)"
  )


# Fit linear model: 2002 singles ~ 1999–2001 average singles
model_singles <- lm(singles ~ mean_singles, data = combined_data)

# View the summary to get the slope
summary(model_singles)

coef(model_singles)["mean_singles"]

# Fit linear model: 2002 bb ~ 1999–2001 average bb
model_bb <- lm(bb ~ mean_bb, data = combined_data)

# View the slope (coefficient of mean_bb)
summary(model_bb)

