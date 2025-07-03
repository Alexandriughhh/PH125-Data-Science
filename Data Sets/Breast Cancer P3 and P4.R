# Breast Cancer P3 and P4

set.seed(1) 
test_index <- createDataPartition(brca$y, times = 1, p = 0.2, list = FALSE)
test_x <- x_scaled[test_index,]
test_y <- brca$y[test_index]
train_x <- x_scaled[-test_index,]
train_y <- brca$y[-test_index]

# What proportion of the training set is benign?
mean(train_y == "B")

# What proportion of the test set is benign?
mean(test_y == "B")

# What is the accuracy of the logistic regression model on the test set?
# Load required package
library(caret)

# Set seed for reproducibility
set.seed(1)

# Split already done as per your code
# train_x, train_y, test_x, test_y are defined

# Create training data frame
train_data <- data.frame(train_x)
train_data$y <- train_y

# Fit logistic regression model
log_fit <- train(y ~ ., method = "glm", data = train_data, family = "binomial")

# Make predictions on test set
test_data <- data.frame(test_x)
predictions <- predict(log_fit, newdata = test_data)

# Calculate accuracy
accuracy <- mean(predictions == test_y)
accuracy

# Set seed to 5, What is the accuracy of the loess model on the test set?
# Install the required package if not already installed
if (!require(gam)) install.packages("gam")
library(caret)

# Set seed for reproducibility
set.seed(5)

# Create training data
train_data <- data.frame(train_x)
train_data$y <- train_y

# Fit the loess model using caret
loess_fit <- train(y ~ ., method = "gamLoess", data = train_data)

# Generate predictions on test data
test_data <- data.frame(test_x)
predictions <- predict(loess_fit, newdata = test_data)

# Calculate accuracy
accuracy <- mean(predictions == test_y)
accuracy

# what is the final value of k used in the model adter setting the seed to 7?

set.seed(7)
tuning <- data.frame(k = seq(3, 21, 2))
train_knn <- train(train_x, train_y,
                   method = "knn", 
                   tuneGrid = tuning)
train_knn$bestTune

knn_preds <- predict(train_knn, test_x)
mean(knn_preds == test_y)

set.seed(9)
tuning <- data.frame(mtry = c(3, 5, 7, 9))
train_rf <- train(train_x, train_y,
                  method = "rf",
                  tuneGrid = tuning,
                  importance = TRUE)
train_rf$bestTune

rf_preds <- predict(train_rf, test_x)
mean(rf_preds == test_y)

ensemble <- cbind(glm = glm_preds == "B", lda = lda_preds == "B", qda = qda_preds == "B", loess = loess_preds == "B", rf = rf_preds == "B", knn = knn_preds == "B", kmeans = kmeans_preds == "B")

ensemble_preds <- ifelse(rowMeans(ensemble) > 0.5, "B", "M")
mean(ensemble_preds == test_y)