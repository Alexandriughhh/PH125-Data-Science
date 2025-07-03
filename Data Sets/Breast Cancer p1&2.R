# Breast Cancer Part One and two

options(digits = 3)
library(matrixStats)
library(tidyverse)
library(caret)
library(dslabs)
data(brca)

# How many samples are in the dataset?
dim(brca$x)[1]
# How many predictors are in the matrix?
dim(brca$x)[2]
# What proportion of the samples are malignant?
mean(brca$y == "M")
# Which column number has the highest mean?
which.max(colMeans(brca$x))
# Which column number has the lowest standard deviation?
which.min(colSds(brca$x))
# After scaling, what is the standard deviation of the first column?
x_centered <- sweep(brca$x, 2, colMeans(brca$x))
x_scaled <- sweep(x_centered, 2, colSds(brca$x), FUN = "/")

sd(x_scaled[,1])
# After scaling, what is the median value of the first column?
median(x_scaled[,1])

# What proportion of variance is explained by the first principal component?
pca <- prcomp(x_scaled)
summary(pca)

# Plot the first two principal components with color representing tumor type (benign/malignant).
data.frame(pca$x[,1:2], type = brca$y) %>%
  ggplot(aes(PC1, PC2, color = type)) +
  geom_point() 

# Make a boxplot of the first 10 PCs grouped by tumor type.
data.frame(type = brca$y, pca$x[,1:10]) %>%
  gather(key = "PC", value = "value", -type) %>%
  ggplot(aes(PC, value, fill = type)) +
  geom_boxplot()

