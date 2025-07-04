library(dplyr)
library(dslabs)
data("murders")

x <- murders$population /10^6
y <- murders$total
plot(x,y)

murders <- mutate(murders, rate = total/population * 100000)
hist(murders$rate)

boxplot(rate~region, data = murders)