beads <- rep(c("red", "blue"), times = c(2,3))
mean(beads == "blue")

balls <-rep(c("cyan", "magenta", "yellow"), times = c(3, 5, 7))
mean(balls == "cyan")

p <- 0.2 
p_not <- 1 - p
print(p_not)

events <- sample(balls, B, replace = TRUE)
prop.table(table(events))

p_cyan_first <- 3/15
p_not_cyan_second <- 12/14
p_combined <- p_cyan_first * p_not_cyan_second
print(p_combined)


p_cyan_first <- 3/15
p_not_cyan_second <- 12/15
p_combined <- p_cyan_first * p_not_cyan_second
print(p_combined)

mean(balls == "yellow")

dice <- rep(c(1, 2, 3,4,5,6), times = c(1,1,1,1,1,1))
mean(dice == 6)