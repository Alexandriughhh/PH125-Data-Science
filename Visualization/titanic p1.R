# Titanic Part One

library(titanic)    # loads titanic_train data frame
library(caret)
library(tidyverse)
library(rpart)

# 3 significant digits
options(digits = 3)

# clean the data - `titanic_train` is loaded with the titanic package
titanic_clean <- titanic_train %>%
  mutate(Survived = factor(Survived),
         Embarked = factor(Embarked),
         Age = ifelse(is.na(Age), median(Age, na.rm = TRUE), Age), # NA age to median age
         FamilySize = SibSp + Parch + 1) %>%    # count family members
  select(Survived,  Sex, Pclass, Age, Fare, SibSp, Parch, FamilySize, Embarked)

#Split titanic_clean into test and training sets.

set.seed(42)
test_index <- createDataPartition(titanic_clean$Survived, times = 1, p = 0.2, list = FALSE)
train_set <- titanic_clean[-test_index,]
test_set <- titanic_clean[test_index,]
nrow(train_set)
nrow(test_set)
mean(train_set$Survived == 1)

# What is the accuracy of guessing method?

set.seed(3)
guess_ <- sample(c(0,1), nrow(test_set), replace = TRUE)
test_set %>% 
  filter(Survived == guess_) %>%
  summarize(n() / nrow(test_set))
# guess with equal probability of survival
#guess <- sample(c(0,1), nrow(test_set), replace = TRUE)
#mean(guess == test_set$Survived)

# What proportion of training set females survived?

train_set %>%
  group_by(Sex) %>%
  summarize(Survived = mean(Survived == 1))

# What is the accuracy of this sex-based prediction methon on the test set?

test_set %>%
  summarize( (sum(Sex == 'female' & Survived == 1) + sum(Sex == 'male' & Survived == 0)) / n())

# Which classes (Pclass) were passengers more likely to survive than die?

survival_class <- titanic_clean %>%
  group_by(Pclass) %>%
  summarize(PredictingSurvival = ifelse(mean(Survived == 1) >=0.5, 1, 0))
survival_class

# What is the accuracy of this class-based prediction method on the test set?

test_set %>%
  inner_join(survival_class, by='Pclass') %>%
  summarize(PredictingSurvival = mean(Survived == PredictingSurvival))

# Which sex and class combinations were more likely to survive than die?

survival_class <- titanic_clean %>%
  group_by(Sex, Pclass) %>%
  summarize(PredictingSurvival = ifelse(mean(Survived == 1) > 0.5, 1, 0))
survival_class

# What is the accuracy of this sex- and class-based prediction method on the test set?

test_set %>%
  inner_join(survival_class, by=c('Sex', 'Pclass')) %>%
  summarize(PredictingSurvival = mean(Survived == PredictingSurvival))

# What is the "positive" class used to calculate confusion matrix metrics?

# Confusion Matrix: sex model
library(broom)
sex_model <- train_set %>%
  group_by(Sex) %>%
  summarize(Survived_predict = ifelse(mean(Survived == 1) > 0.5, 1, 0))
test_set1 <- test_set %>%
  inner_join(sex_model, by = 'Sex')
cm1 <- confusionMatrix(data = factor(test_set1$Survived_predict), reference = factor(test_set1$Survived))
cm1 %>%
  tidy() %>%
  filter(term == 'sensitivity') %>%
  .$estimate
cm1 %>%
  tidy() %>%
  filter(term == 'specificity') %>%
  .$estimate
cm1 %>%
  tidy() %>%
  filter(term == 'balanced_accuracy') %>%
  .$estimate
# Confusion Matrix: class model
class_model <- train_set %>%
  group_by(Pclass) %>%
  summarize(Survived_predict = ifelse(mean(Survived == 1) > 0.5, 1, 0))
test_set2 <- test_set %>%
  inner_join(class_model, by = 'Pclass')
cm2 <- confusionMatrix(data = factor(test_set2$Survived_predict), reference = factor(test_set2$Survived))
cm2 %>%
  tidy() %>%
  filter(term == 'sensitivity') %>%
  .$estimate
cm2 %>%
  tidy() %>%
  filter(term == 'specificity') %>%
  .$estimate
cm2 %>%
  tidy() %>%
  filter(term == 'balanced_accuracy') %>%
  .$estimate
# Confusion Matrix: sex and class model
sex_class_model <- train_set %>%
  group_by(Sex, Pclass) %>%
  summarize(Survived_predict = ifelse(mean(Survived == 1) > 0.5, 1, 0))
test_set3 <- test_set %>%
  inner_join(sex_class_model, by=c('Sex', 'Pclass'))
cm3 <- confusionMatrix(data = factor(test_set3$Survived_predict), reference = factor(test_set3$Survived))
cm3 %>%
  tidy() %>%
  filter(term == 'sensitivity') %>%
  .$estimate
cm3 %>%
  tidy() %>%
  filter(term == 'specificity') %>%
  .$estimate
cm3 %>%
  tidy() %>%
  filter(term == 'balanced_accuracy') %>%
  .$estimate

# Which model has the highest F1 score?

F_meas(data=factor(test_set1$Survived), reference = factor(test_set1$Survived_predict))
F_meas(data=factor(test_set2$Survived), reference = factor(test_set2$Survived_predict))
F_meas(data=factor(test_set3$Survived), reference = factor(test_set3$Survived_predict))