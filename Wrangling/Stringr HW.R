library(rvest)
library(tidyverse)
library(stringr)
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
tab <- read_html(url) %>% html_nodes("table")
polls <- tab[[6]] %>% html_table(fill = TRUE)

library(rvest)
library(tidyverse)
library(stringr)

url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"

# Read the tables on the page
tab <- read_html(url) %>% html_nodes("table")

# Extract the 6th table
polls <- tab[[6]] %>% html_table(fill = TRUE)

# Rename columns
colnames(polls) <- c("dates", "remain", "leave", "undecided", "lead", "samplesize", "pollster", "poll_type", "notes")

# Keep only rows where the 'remain' column contains a percent sign
polls_filtered <- polls %>% filter(str_detect(remain, "%"))

# Check how many rows remain
num_rows <- nrow(polls_filtered)
print(num_rows)
