library(tidyverse)
library(caret)

# Step 1: Generate data
set.seed(1996)
n <- 1000
p <- 10000
x <- matrix(rnorm(n * p), n, p)
colnames(x) <- paste("x", 1:ncol(x), sep = "_")
y <- rbinom(n, 1, 0.5) %>% factor()

# Step 2: Convert y to numeric for t-test filtering
y_num <- as.numeric(as.character(y))

# Step 3: Perform t-tests to find "significant" predictors
pvals <- rep(0, ncol(x))
for (i in 1:ncol(x)) {
  pvals[i] <- t.test(x[,i][y_num == 0], x[,i][y_num == 1], var.equal = TRUE)$p.value
}

# Step 4: Subset to predictors with p < 0.01
ind <- which(pvals < 0.01)
x_subset <- x[, ind]

# Step 5: Cross-validation with logistic regression
set.seed(1)
fit <- train(x_subset, y, method = "glm")
fit$results

