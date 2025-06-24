
library(dplyr)
library(dslabs)
data(murders)
murders <- mutate(murders, rate = total / population * 10^5)

s <- murders %>%
  filter(region == "West") %>%
  summarize(minimum = min(rate),
            median = median(rate),
            maximum = max(rate))
s

s$median
s$maximum

mean(murders$rate)

us_murder_rate <- murders %>%
  summarize(rate = sum(total) / sum(population) * 10^5)
us_murder_rate

murders %>%
  filter(region == "West") %>%
  summarize(range = quantile(rate, c(0, 0.5, 1)))

my_quantile <- function(x){
  r <- quantile(x, c(0, 0.5, 1))
  data.frame(minimum = r[1], median = r[2], maximum = r[3])
}

murders %>%
  filter(region == "West") %>%
  summarize(my_quantile(rate))


us_murder_rate <- murders %>%
  summarize(rate = sum(total) / sum(population) * 10^5)
us_murder_rate

class(us_murder_rate)

us_murder_rate %>% pull(rate)

us_murder_rate <- murders %>%
  summarize(rate = sum(total) / sum(population) * 10^5) %>%
  pull(rate)
us_murder_rate

class(us_murder_rate)

us_murder_rate <- murders %>%
  summarize(rate = sum(total) / sum(population) * 10^5) %>%
  .$rate
us_murder_rate
class(us_murder_rate)

murders %>% group_by(region)

murders %>%
  group_by (region) %>%
  summarize(median = median(rate))

murders %>% arrange (population) %>% head()

murders %>% arrange(rate) %>% head()
murders %>% arrange(desc(rate)) %>% head()
murders %>% arrange(region, rate) %>% head()
murders %>% top_n(10, rate)
murders %>% arrange(desc(rate)) %>% top_n(10)


  