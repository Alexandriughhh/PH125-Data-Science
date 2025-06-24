library(Lahman)
library(tidyverse)
library(dslabs)
ds_theme_set()

?Teams
library(Lahman)
library(tidyverse)
library(dslabs)
ds_theme_set()

# Prepare data
teams_data <- Teams %>%
  filter(yearID %in% 1961:2001) %>%
  mutate(
    BB_per_game = BB / G,
    R_per_game = R / G,
    HR_per_game = HR / G
  )

# Fit the linear model
model <- lm(R_per_game ~ BB_per_game + HR_per_game, data = teams_data)

# View coefficients
summary(model)$coefficients

B <- 1000
N <- 100
lse <- replicate(B, {
  sample_n(galton_heights, N, replace = TRUE) %>% 
    lm(son ~ father, data = .) %>% .$coef 
})

lse <- data.frame(beta_0 = lse[1,], beta_1 = lse[2,]) 

galton_heights %>% ggplot(aes(father, son)) +
  geom_point() +
  geom_smooth()


galton_heights %>% ggplot(aes(father, son)) +
  geom_point() +
  geom_smooth(method = "lm")

model <- lm(son ~ father, data = galton_heights)
predictions <- predict(model, interval = c("confidence"), level = 0.95)
data <- as_tibble(predictions) %>% bind_cols(father = galton_heights$father)

ggplot(data, aes(x = father, y = fit)) +
  geom_line(color = "blue", size = 1) + 
  geom_ribbon(aes(ymin=lwr, ymax=upr), alpha=0.2) + 
  geom_point(data = galton_heights, aes(x = father, y = son))


galton_heights %>% ggplot(aes(father, son)) +
  geom_point() +
  geom_smooth()

galton_heights %>% ggplot(aes(father, son)) +
  geom_point() +
  geom_smooth(method = "lm")

galton_heights %>% ggplot(aes(father, son)) +
  geom_point() +
  geom_smooth()

model <- lm(son ~ father, data = galton_heights)
predictions <- predict(model, interval = c("confidence"), level = 0.95)
data <- as_tibble(predictions) %>% bind_cols(father = galton_heights$father)

ggplot(data, aes(x = father, y = fit)) +
  geom_line(color = "blue", size = 1) + 
  geom_ribbon(aes(ymin=lwr, ymax=upr), alpha=0.2) + 
  geom_point(data = galton_heights, aes(x = father, y = son))

galton_heights %>% ggplot(aes(father, son)) +
  geom_point() +
  geom_smooth()
