library(dplyr)
library(dslabs)
data(heights)
heights <- setDT(heights)

s <- heights %>%
  summarize(average = mean(height), standard_deviation = sd(height))

s<- heights[, .(average = mean(height), standard_deviation = sd(height))]

s<- heights %>%
  filter(sex == "Female") %>%
  summarize(average = mean(height), standard_deviation = sd(height))

s <- heights[sex == "Female", .(average = mean(height), standard_deviation = sd(height))]

median_min_max <- function(x){
  qs <- quantile(x, c(0.5, 0, 1))
  data.frame(median = qs[1], minimum = qs[2], maximum = qs[3])
}

heights[, .(median_min_max(height))]

heights[, .(average = mean(height), standard_deviation = sd(height)), by = sex]

murders[order(population)] |> head()
murders[order(population, decreasing = TRUE)]
murders[order(region, rate)]
