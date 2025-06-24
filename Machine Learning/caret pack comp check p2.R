library(tidyverse)
library(caret)
library(dslabs)
library(randomForest)

data("tissue_gene_expression")

# Set seed
set.seed(1991)

# Define mtry tuning grid
mtry_grid <- data.frame(mtry = seq(50, 200, 25))

# Train Random Forest model
fit <- train(tissue_gene_expression$x, 
             tissue_gene_expression$y,
             method = "rf",
             tuneGrid = mtry_grid,
             nodesize = 1)
fit$bestTune
