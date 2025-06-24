library(dplyr)
library(ggplot2)
library(dslabs)
ds_theme_set()
data(gapminder)
gapminder %>% 
  filter(year == 2010) %>% 
  group_by(continent) %>% 
  ggplot(aes(x=continent, y=population/10^6)) + 
  geom_boxplot() + 
  scale_y_continuous(trans = "log10", breaks = c(1,10,100,1000)) + 
  ylab("Population in millions")


gapminder %>%
  filter(year == 2010) %>%
  group_by(continent) %>%
  ggplot(aes(x=continent, y=population/10^6)) + 
  geom_boxplot() + 
  scale_y_continuous(trans = "log10", breaks = c(1,10,100,1000)) + 
  ylab("Population in millions")