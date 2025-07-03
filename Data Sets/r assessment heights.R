library(tidyverse)
library(dslabs)
data(heights)
heights
help(heights)

heights$sex[777]

max(heights$height)

which.min(heights$height)
heights[1,777]
heights[777,1]

mean(heights$height)
median(heights$height)
sum(heights$sex == "Female" & heights$height > 78)
sum(heights$sex == "Male" & heights$height > 78)
mean(heights$sex == "Male")