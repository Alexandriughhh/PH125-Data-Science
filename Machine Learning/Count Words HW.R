library(dslabs)
library(lubridate)
options(digits = 3)    # 3 significant digits

dates <- c("09-01-02", "01-12-07", "02-03-04")
ymd(dates)

data(brexit_polls)

# Load required packages
library(dslabs)
library(dplyr)
library(lubridate)

# Load the data
data(brexit_polls)

# Filter for polls that started in April and count them
brexit_polls %>%
  filter(month(startdate) == 4) %>%
  nrow()

# Load required packages
library(dslabs)
library(dplyr)
library(lubridate)

# Load the data
data(brexit_polls)

# Round enddate to the nearest week and count how many are in the week of 2016-06-12
brexit_polls %>%
  mutate(week_ending = round_date(enddate, unit = "week")) %>%
  filter(week_ending == as.Date("2016-06-12")) %>%
  nrow()

# Load required packages
library(dslabs)
library(dplyr)
library(lubridate)

# Load the data
data(brexit_polls)

# Count the number of polls ending on each weekday
brexit_polls %>%
  mutate(weekday = weekdays(enddate)) %>%
  count(weekday, sort = TRUE)

# Load required packages
library(dslabs)
library(dplyr)
library(lubridate)

# Load the data
data(movielens)

# Convert timestamp to datetime, extract year, and count reviews by year
movielens %>%
  mutate(review_date = as_datetime(timestamp),
         review_year = year(review_date)) %>%
  count(review_year, sort = TRUE)

# Load required packages
library(dslabs)
library(dplyr)
library(lubridate)

# Load the data
data(movielens)

# Convert timestamp and extract hour, then count and sort
movielens %>%
  mutate(review_datetime = as_datetime(timestamp),
         review_hour = hour(review_datetime)) %>%
  count(review_hour, sort = TRUE)


# Load libraries
library(tidyverse)
library(gutenbergr)
library(tidytext)
options(digits = 3)

# Search for titles that contain "Pride and Prejudice"
pride_matches <- gutenberg_metadata %>%
  filter(str_detect(title, "Pride and Prejudice"))

# View the results
pride_matches

# Count the number of unique Gutenberg IDs
n_distinct(pride_matches$gutenberg_id)


# Load necessary libraries
library(tidyverse)
library(gutenbergr)
library(tidytext)
options(digits = 3)

# Get distinct English-language works and search for "Pride and Prejudice"
gutenberg_works() %>%
  filter(str_detect(title, "Pride and Prejudice"))

library(tidyverse)
library(gutenbergr)
library(tidytext)
options(digits = 3)

# Download Pride and Prejudice (ID 1342) from the specified mirror
pride_text <- gutenberg_download(1342, mirror = "http://mirror.csclub.uwaterloo.ca/gutenberg/")

# Create a tidy table of words
words <- pride_text %>%
  unnest_tokens(word, text, token = "words")

# Filter out tokens that consist entirely of special characters (non-alphanumeric)
words_clean <- words %>%
  filter(str_detect(word, "[[:alnum:]]"))

# Count the number of words
num_words <- nrow(words_clean)

num_words

library(tidytext)  # just to be sure stop_words is loaded

# Remove stop words by anti_join with stop_words dataset
words_nostop <- words_clean %>%
  anti_join(stop_words, by = "word")

# Count remaining words
num_words_nostop <- nrow(words_nostop)

num_words_nostop

library(stringr)

# Remove words containing any digit
words_no_digits <- words_nostop %>%
  filter(!str_detect(word, "\\d"))

# Count remaining words
num_words_no_digits <- nrow(words_no_digits)

num_words_no_digits

# Count frequencies of remaining words
word_counts <- words_no_digits %>%
  count(word, sort = TRUE)

# Filter words that appear more than 100 times
common_words <- word_counts %>%
  filter(n > 100)

# Count how many such words there are
num_common_words <- nrow(common_words)

num_common_words

# Get the most common word
most_common_word <- word_counts %>%
  slice_max(n, n = 1)

most_common_word

library(tidytext)

# Download and load AFINN lexicon
afinn <- get_sentiments("afinn")
Selection: yes

afinn_sentiments <- words_no_digits %>%
  inner_join(afinn, by = "word")

num_afinn_words <- nrow(afinn_sentiments)

num_afinn_words

