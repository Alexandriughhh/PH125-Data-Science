library(tidyverse)
library(broom)
library(Lahman)
Teams_small <- Teams %>% 
  filter(yearID %in% 1961:2001) %>% 
  mutate(avg_attendance = attendance/G)

# For every 1 run scored per game, average attendance increases by how much?
# Load required libraries
library(tidyverse)
library(broom)
library(Lahman)

# Prepare the data
Teams_small <- Teams %>% 
  filter(yearID %in% 1961:2001) %>% 
  mutate(
    avg_attendance = attendance / G,    # average attendance per game
    runs_per_game = R / G               # runs per game
  )

# Fit the linear model
model <- lm(avg_attendance ~ runs_per_game, data = Teams_small)

# Summarize the model
tidy(model)

# For every 1 home run hit per game, average attendance increases by how much?

# Prepare the data
Teams_small <- Teams %>% 
  filter(yearID %in% 1961:2001) %>% 
  mutate(
    avg_attendance = attendance / G,    # average attendance per game
    homeruns_per_game = HR / G               # runs per game
  )

# Fit the linear model
model <- lm(avg_attendance ~ homeruns_per_game, data = Teams_small)

# Summarize the model
tidy(model)

# Fit the linear model: average attendance per game ~ total wins
model_wins <- lm(avg_attendance ~ W, data = Teams_small)

# View tidy summary
tidy(model_wins)


model_wins <- lm(avg_attendance ~ W, data = Teams_small)
tidy(model_wins)

# How much does average attendance increase each year?
# Fit the linear model
model_year <- lm(avg_attendance ~ yearID, data = Teams_small)

# View the model summary
tidy(model_year)

# Correlation Coefficient for runs per game and wins?

# Prepare the data (if not already done)
Teams_small <- Teams %>%
  filter(yearID %in% 1961:2001) %>%
  mutate(
    avg_attendance = attendance / G,
    runs_per_game = R / G,
    hr_per_game = HR / G
  )

# Calculate the correlation between runs per game and wins
cor(Teams_small$runs_per_game, Teams_small$W)

# Correlation Coefficient for runs per game and wins?

# Prepare the data (if not already done)
Teams_small <- Teams %>%
  filter(yearID %in% 1961:2001) %>%
  mutate(
    avg_attendance = attendance / G,
    runs_per_game = R / G,
    hr_per_game = HR / G
  )

# Calculate the correlation between home runs per game and wins
cor(Teams_small$hr_per_game, Teams_small$W)

# How many observations are in the 8 win strata?

# Stratify by wins and filter strata
stratified_data <- Teams_small %>%
  mutate(win_strata = round(W / 10)) %>%
  filter(win_strata %in% 5:10)

# Count how many observations are in strata 8
stratified_data %>%
  filter(win_strata == 8) %>%
  count()

#Which win stratum has the largest regression line slope?

library(tidyverse)
library(broom)

# Step 1: Stratify and filter
stratified_data <- Teams_small %>%
  mutate(win_strata = round(W / 10)) %>%
  filter(win_strata %in% 5:10)

# Step 2: Group by stratum and fit linear model
slopes_by_stratum <- stratified_data %>%
  group_by(win_strata) %>%
  do(tidy(lm(avg_attendance ~ runs_per_game, data = .))) %>%
  filter(term == "runs_per_game") %>%
  arrange(desc(estimate))

# View the slope estimates
slopes_by_stratum

# Calculate the slope of the regression line predicting average attendance given HR per game for each of the win strata.

library(tidyverse)
library(broom)

# Step 1: Create the stratified dataset
stratified_data <- Teams %>%
  filter(yearID %in% 1961:2001) %>%
  mutate(
    avg_attendance = attendance / G,
    hr_per_game = HR / G,
    win_strata = round(W / 10)
  ) %>%
  filter(win_strata %in% 5:10)

# Step 2: Fit linear model within each win_strata group and extract slope
slopes_hr_by_stratum <- stratified_data %>%
  group_by(win_strata) %>%
  do(tidy(lm(avg_attendance ~ hr_per_game, data = .))) %>%
  filter(term == "hr_per_game") %>%
  arrange(desc(estimate))

# View the slopes
slopes_hr_by_stratum

# Prepare data (if not already done)
Teams_small <- Teams %>%
  filter(yearID %in% 1961:2001) %>%
  mutate(
    avg_attendance = attendance / G,
    runs_per_game = R / G,
    hr_per_game = HR / G
  )

# Fit multivariate regression model
multi_model <- lm(avg_attendance ~ runs_per_game + hr_per_game + W + yearID, data = Teams_small)

# Summarize the model
library(broom)
tidy(multi_model)

# Step 1: Create the data frame for the new team
new_team <- data.frame(
  runs_per_game = 5,
  hr_per_game = 1.2,
  W = 80,
  yearID = 2002
)

# Step 2: Use predict() with the fitted model
predicted_attendance <- predict(multi_model, newdata = new_team)

# Step 3: View the predicted average attendance
predicted_attendance


#Estimated attendance 1960

# Input values for a team in 1960
team_1960 <- data.frame(
  runs_per_game = 5,
  hr_per_game = 1.2,
  W = 80,
  yearID = 1960
)

# Predict average attendance
predicted_attendance_1960 <- predict(multi_model, newdata = team_1960)

# View the result
predicted_attendance_1960

# What is the correlation between the predicted attendance and the actual attendance?
# Step 1: Prepare 2002 team data
Teams_2002 <- Teams %>%
  filter(yearID == 2002) %>%
  mutate(
    avg_attendance = attendance / G,
    runs_per_game = R / G,
    hr_per_game = HR / G
  )

# Step 2: Predict average attendance using the model
Teams_2002 <- Teams_2002 %>%
  mutate(predicted_attendance = predict(multi_model, newdata = .))

# Step 3: Calculate correlation between actual and predicted attendance
correlation <- cor(Teams_2002$avg_attendance, Teams_2002$predicted_attendance)

# View result
correlation
