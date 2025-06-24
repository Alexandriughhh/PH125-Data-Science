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

# Our dslabs package is on GitHub and the file we downloaded with the package has a url
url <- "https://raw.githubusercontent.com/rafalab/dslabs/master/inst/extdata/murders.csv"

# Use read_csv file to read these files directly
dat <- read_csv(url)

# Use the download.file function in order to have a local copy of the file
download.file(url, "murders.csv")

# Run a command like this which erases the temporary file once it imports the data
tmp_filename <- tempfile()
download.file(url, tmp_filename)
dat <- read_csv(tmp_filename)
file.remove(tmp_filename)

# Use scan to read-in each cell of a file
path <- system.file("extdata", package = "dslabs")
filename <- "murders.csv"
x <- scan(file.path(path, filename), sep = ",", what = "c")
x[1:10]