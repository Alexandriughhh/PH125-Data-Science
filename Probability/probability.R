beads <- rep(c("red", "blue"), times = c(2,3))    # create an urn with 2 red, 3 blue
beads    # view beads object
sample(beads, 1)    # sample 1 bead at random

B <- 10000    # number of times to draw 1 bead
events <- replicate(B, sample(beads, 1))    # draw 1 bead, B times
tab <- table(events)    # make a table of outcome counts
tab    # view count table
prop.table(tab)    # view table of outcome proportions

beads <- rep(c("red", "blue"), times = c(2,3))
beads
 "red" "red" "blue" "blue" "blue"

mean(beads == "blue")
[1] 0.6

source("path/to/your_clean_script.R", echo=TRUE)

# Define the beads vector using rep()
beads <- rep(c("red", "blue"), times = c(2, 3))

# Calculate the mean of beads equal to "blue"
mean_blue <- mean(beads == "blue")
print(mean_blue)
