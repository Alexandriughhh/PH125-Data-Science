install.packages("dplyr")
library(dplyr)

library(dslabs)
data("murders")
murders <- mutate(murders, rate = total / population *100000)

filter(murders, rate <= 0.71)

new_table <- select(murders, state, region, rate)

murders %>% select(state, region, rate) %>% filter(rate <= 0.71)

grades <- data.frame(names = c("John", "Juan", "Jean", "Yao"),
                     exam_1 = c(95,80,90,85),
                     exam_2 = C(90, 85, 85, 90),
                     stringsAsFactors = FALSE)
