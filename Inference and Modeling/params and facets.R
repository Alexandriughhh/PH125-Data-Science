options(digits = 3)    # report 3 significant digits
library(tidyverse)
library(titanic)

titanic <- titanic_train %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare) %>%
  mutate(Survived = factor(Survived),
         Pclass = factor(Pclass),
         Sex = factor(Sex))

?titanic_train

ggplot(titanic, aes(x = Age, fill = Sex)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Plot of Age Grouped by Sex", x = "Age", y = "Density")
  facet_grid(Age ~.)
  
  
  params <- titanic %>%
    filter(!is.na(Age)) %>%
    summarize(mean = mean(Age), sd = sd(Age))
    p + geom_qq(dparams=params)+
      geom_abline()