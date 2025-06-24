library(caret)
data(iris)

# Remove setosa and define y
iris <- iris[-which(iris$Species == 'setosa'),]
y <- iris$Species

# Train/test split
set.seed(76)
test_index <- createDataPartition(y, times = 1, p = 0.5, list = FALSE)
train <- iris[-test_index,]
test  <- iris[test_index,]

# Function to find best accuracy for a single feature
get_best_accuracy <- function(feature_name) {
  x <- train[[feature_name]]
  cutoffs <- seq(min(x), max(x), 0.1)
  
  accuracies <- sapply(cutoffs, function(cutoff) {
    y_hat <- ifelse(x > cutoff, "virginica", "versicolor")
    mean(y_hat == train$Species)
  })
  
  max(accuracies)
}

# Apply to all four features
features <- colnames(train)[1:4]
accuracies <- sapply(features, get_best_accuracy)

# Show results
accuracies

# Step 1: Find the best cutoff on training data
train_pw <- train$Petal.Width
cutoffs <- seq(min(train_pw), max(train_pw), 0.1)

accuracies <- sapply(cutoffs, function(cutoff) {
  y_hat <- ifelse(train_pw > cutoff, "virginica", "versicolor")
  mean(y_hat == train$Species)
})

# Best cutoff
best_cutoff <- cutoffs[which.max(accuracies)]
best_cutoff
# Step 2: Apply cutoff to test set
test_pw <- test$Petal.Width
y_hat_test <- ifelse(test_pw > best_cutoff, "virginica", "versicolor")

# Step 3: Calculate accuracy
mean(y_hat_test == test$Species)


library(caret)
data(iris)

# Step 1: Prepare data (remove setosa and split train/test)
iris <- iris[iris$Species != "setosa", ]
set.seed(76)
test_index <- createDataPartition(iris$Species, times = 1, p = 0.5, list = FALSE)
train <- iris[-test_index, ]
test <- iris[test_index, ]

# Step 2: Grid search for best combination of cutoffs
length_range <- seq(min(train$Petal.Length), max(train$Petal.Length), 0.1)
width_range <- seq(min(train$Petal.Width), max(train$Petal.Width), 0.1)

# Initialize variables to store best accuracy and cutoffs
best_accuracy <- 0
best_length_cutoff <- 0
best_width_cutoff <- 0

for (l_cut in length_range) {
  for (w_cut in width_range) {
    y_hat <- ifelse(train$Petal.Length > l_cut & train$Petal.Width > w_cut, 
                    "virginica", "versicolor")
    acc <- mean(y_hat == train$Species)
    
    if (acc > best_accuracy) {
      best_accuracy <- acc
      best_length_cutoff <- l_cut
      best_width_cutoff <- w_cut
    }
  }
}

# Step 3: Apply best rule to test set
y_hat_test <- ifelse(test$Petal.Length > best_length_cutoff & 
                       test$Petal.Width > best_width_cutoff, 
                     "virginica", "versicolor")

# Step 4: Calculate accuracy on test set
test_accuracy <- mean(y_hat_test == test$Species)
test_accuracy
specificity(y_hat, y)