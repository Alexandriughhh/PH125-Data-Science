# Copy the spreadsheet containing the US murders data (included as part of the dslabs package) 

filename <- "murders.csv"
dir <- system.file("extdata", package = "dslabs") 
fullpath <- file.path(dir, filename)
file.copy(fullpath, "murders.csv")

# Once the file is copied, import the data with a line of code. Use the read_csv function from the readr package (included in the tidyverse)
library(tidyverse)
dat <- read_csv(filename)

# See an example of a full path on your system 
system.file(package = "dslabs")

# Use the function list.files to see examples of relative paths
dir <- system.file(package = "dslabs")
list.files(path = dir)

# Get the full path of your working directory by using the getwd function
wd <- getwd()

# Obtain a full path without writing out explicitly 
filename <- "murders.csv"
dir <- system.file("extdata", package = "dslabs") 
fullpath <- file.path(dir, filename)

# By exploring the directories in dir we find that the extdata contains the file we want
dir <- system.file(package = "dslabs") 
filename %in% list.files(file.path(dir, "extdata"))

# Copy the file to our working directory 
filename <- "murders.csv"
dir <- system.file("extdata", package = "dslabs") 
fullpath <- file.path(dir, filename)
file.copy(fullpath, "murders.csv")

# Load it directly
library(readr)

# Open the file to take a look or use the function read_lines to look at a few lines
read_lines("murders.csv", n_max = 3)

# Read-in the data into R from the .csv suffix 
dat <- read_csv(filename)

# Confirm that the data has in fact been read-in 
View(dat)

# Use the full path for the file
dat <- read_csv(fullpath)

# Load the readxl package using
library(readxl)

install.packages("munsell")

install.packages("readr")  # Only needed once
library(readr)
dat <- read_csv("murders.csv")
