library(dplyr)
library(dslabs)
data(murders)

murders <- setDT(murders)
select(murders, state, region)

murders[, c("state", "region")] |> head()
murders[, .(state, region)] |> head()

murders <- mutate(murders, rate = total/ population * 10^5)

murders[, rate := total/population * 100000]
head(murders)
murders[, ":="(rate = total / population * 100000, rank = rank(population))]

x <- data.table(a =1)
y <- x

x[,a := 2]
y

y[,a := 1]
x

x<- data.table(a = 1)
y <- copy(x)
x[,a := 2]
y

filter(murders, rate <= 0.7)
murders[rate <= 0.7]
murders[rate <= 0.7, .(state, rate)]
murders %>% filter(rate <= 0.7) %>% select(state, rate)