library(dslabs)
data(murders)
sort(murders$total)

x <- c(31,4,15,92,65)
x
sort(x)

index <- order(x)
x[index]
order(x)

murders$state[1:10]
murders$abb[1:10]

index <- order(murders$total)
murders$abb[index]

max(murders$total)
i_max <- which.max(murders$total)
murders$state[i_max]

x <- c(32, 4, 15, 92, 65)
x
rank(x) 