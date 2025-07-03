library(dplyr)
library(ggplot2)
library(dslabs)
ds_theme_set()
data(murders)
murders %>% group_by(region) %>%
  summarize(n = n()) %>%
  mutate(Proportion = n/sum(n),
         region = reorder(region, Proportion)) %>%
  ggplot(aes(x=region, y=Proportion, fill=region)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  xlab("")

library(dplyr)
library(ggplot2)
library(dslabs)
ds_theme_set()
data(murders)
murders %>% group_by(region) %>%
  summarize(n = n()) %>%
  mutate(Proportion = n/sum(n), 
         region = reorder(region, Proportion)) %>%
  ggplot(aes(x=region, y=Proportion, fill=region)) + 
  geom_bar(stat = "identity", show.legend = FALSE) + 
  xlab("")

