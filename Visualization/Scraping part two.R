library(rvest)
library(dplyr)

url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
h <- read_html(url)
nodes <- html_nodes(h, "table")

# Convert nodes 10 and 19 to data frames
tab_1 <- html_table(nodes[[10]])
tab_2 <- html_table(nodes[[19]])

# Remove the first column of tab_1 (the "No." column)
tab_1 <- tab_1[, -1]

# Remove the first row (which is the repeated header)
tab_1 <- tab_1[-1, ]
tab_2 <- tab_2[-1, ]

# Rename columns
colnames(tab_1) <- c("Team", "Payroll", "Average")
colnames(tab_2) <- c("Team", "Payroll", "Average")

# Join the two tables
joined_tab <- full_join(tab_1, tab_2, by = "Team")

nrow(joined_tab)

library(rvest)
library(tidyverse)

# Define the URL (historic snapshot of the Wikipedia page)
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"

# Read the HTML from the page
webpage <- read_html(url)

# Extract all table nodes
tab <- html_nodes(webpage, "table")

# Count how many tables there are
length(tab)

library(rvest)
library(tidyverse)

# Load the Wikipedia page
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
page <- read_html(url)

# Extract all tables
tables <- html_nodes(page, "table")

# Loop through tables and find the first one with 9 columns and the first column named "Date(s) conducted"
for (i in seq_along(tables)) {
  table <- html_table(tables[[i]], fill = TRUE)
  if (ncol(table) == 9 && names(table)[1] == "Date(s) conducted") {
    print(paste("First matching table is table number:", i))
    break
  }
}

