a <- 0
if(a!=0){
  print(1/a)
} else{
  print("No reciprocal for 0.")
}

library(dslabs)
data(murders)
murder_rate <- murders$total / murders$population*100000
ind <- which.min(murder_rate)
if(murder_rate[ind] < 0.5) {
  print(murders$state[ind])
} else{
  print("No state has murder rate that low")
}

if(murder_rate[ind] < 0.25){
  print(murders$state[ind])
}else{
  print("No state has a murder rate that low.")
}

a <- 0
ifelse(a >0, 1/a, NA)

a <- c(0,1,2,-4,5)
result <- ifelse(a > 0, 1/a, NA)

data(na_example)
no_nas <- ifelse(is.na(na_example), 0, na_example)
sum(is.na(no_nas))

z <- c(TRUE, TRUE, FALSE)
any(z)
all(z)


avg <- function(x) {
  s <- sum(x)
  n <- length(x)
  s/n
}

x <- 1:100
indentical(mean(x), avg(x))

s <- 3
avg(1:10)
s

my_function <- function(VARIABLE_NAME){
  perform operations on VARIABLE_NAME and calculate VALUE
  VALUE
}

avg <- function(x, arithmetic = TRUE){
  n <- length(x)
  ifelse(arithmetic, sum(x)/n, prod(x)^(1/n))
}

ifelse( n > 10, n, "None")

