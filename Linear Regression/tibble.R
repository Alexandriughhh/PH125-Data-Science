murders %>% group_by(region)

murders %>% group_by(region) %>% class()

gapminder
as_tibble(gapminder)

class(murders[,1])
class(as_tibble(murders) [,1])

class(as_tibble(murders)$state)

murders$state
as_tibble(murders)$State

tibble(id = c(1, 2, 3), func = c(mean, median, sd))