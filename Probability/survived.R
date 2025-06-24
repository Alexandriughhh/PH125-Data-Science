library(tidyverse)
library(titanic)

# Prepare the data
titanic <- titanic_train %>%
  select(Survived, Sex, Age, SibSp, Parch, Fare) %>%
  mutate(Survived = factor(Survived),
         Sex = factor(Sex))

# Default bar plot for 'Survived'
ggplot(titanic, aes(x = Survived)) + 
  geom_bar() +
  ggtitle("Bar plot of Survival")

# Bar plot for 'Survived' grouped by 'Sex' using position_dodge
ggplot(titanic, aes(x = Survived, fill = Sex)) + 
  geom_bar(position = position_dodge()) +
  ggtitle("Bar plot of Survival by Sex")
