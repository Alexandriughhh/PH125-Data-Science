# Plot the kNN model

set.seed(6)
fit_knn <- train(Survived ~ .,
                 method = "knn",
                 data = train_set,
                 tuneGrid = data.frame(k = seq(3, 51, 2)),
                 trControl = trainControl(method = "cv", number = 10))


plot(fit_knn)

set.seed(8)
fit_knn10 <- train(Survived ~ ., 
                   data=train_set, 
                   method = "knn",
                   tuneGrid = data.frame(k = seq(3, 51, 2)),
                   trControl = trainControl(method = "cv", number=10, p=0.9))
fit_knn10
survived_hat <- predict(fit_knn10, test_set)
cm_test <- confusionMatrix(data = survived_hat, reference = test_set$Survived)
cm_test$overall["Accuracy"]

library(caret)
library(tidyverse)

# Make sure 'Survived' is a factor in both sets
train_set <- train_set %>% mutate(Survived = factor(Survived))
test_set <- test_set %>% mutate(Survived = factor(Survived))

# Set seed
set.seed(8)

# Train with 10-fold cross-validation
fit_knn_cv <- train(Survived ~ .,
                    method = "knn",
                    data = train_set,
                    tuneGrid = data.frame(k = seq(3, 51, 2)),
                    trControl = trainControl(method = "cv", number = 10))

# View optimal k
fit_knn_cv$bestTune
# Predict on the test set
predictions <- predict(fit_knn_cv, newdata = test_set)

# Compute accuracy
confusionMatrix(predictions, test_set$Survived)$overall["Accuracy"]

# Set the seed to 14. Use the caret train function with the rf method to train a random forest. Test values of mtry ranging from 1 to 7. Set ntree to 100.

set.seed(14, sample.kind = 'Rounding')
fit12_rf <- train(Survived ~., 
                  data = train_set,
                  method = "rf", 
                  tuneGrid = data.frame(mtry = seq(1, 7)), 
                  ntree = 100)
fit12_rf$bestTune
survived_hat <- predict(fit12_rf, test_set)
mean(survived_hat == test_set$Survived)
varImp(fit12_rf)

# Cross Validation, optimal value and accuracy?

set.seed(8)
fit_knn10 <- train(Survived ~ ., 
                   data=train_set, 
                   method = "knn",
                   tuneGrid = data.frame(k = seq(3, 51, 2)),
                   trControl = trainControl(method = "cv", number=10, p=0.9))
fit_knn10
survived_hat <- predict(fit_knn10, test_set)
cm_test <- confusionMatrix(data = survived_hat, reference = test_set$Survived)
cm_test$overall["Accuracy"]

# What is the optimal value of the complexity parameter (cp)? What is the accuracy of the decision tree model on the test set?

set.seed(10)
fit_rpart11 <- train(Survived ~ ., 
                     data=train_set, 
                     method = "rpart",
                     tuneGrid = data.frame(cp = seq(0, 0.05, 0.002)))
plot(fit_rpart11)
survived_hat <- predict(fit_rpart11, test_set)
cm_test <- confusionMatrix(data = survived_hat, reference = test_set$Survived)

cm_test$overall["Accuracy"]


library(caret)
library(tidyverse)
library(rpart)

# Make sure Survived is a factor
train_set <- train_set %>% mutate(Survived = factor(Survived))

# Set seed
set.seed(10)

# Train decision tree with cp tuning
fit_rpart <- train(Survived ~ .,
                   method = "rpart",
                   data = train_set,
                   tuneGrid = data.frame(cp = seq(0, 0.05, 0.002)),
                   trControl = trainControl(method = "cv", number = 10))

# View the optimal cp value
fit_rpart$bestTune

# Which variables are used in the decision tree?

fit_rpart11$finalModel
plot(fit_rpart11$finalModel, margin=0.1)
text(fit_rpart11$finalModel, cex = 0.75)