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
data(heights)
heights %>% filter(sex=="Male") %>% ggplot(aes(height)) + 
  stat_ecdf() +
  ylab("F(a)") + xlab("a")

library(dplyr)
library(ggplot2)
library(dslabs)
data(heights)
heights %>% filter(sex=="Male") %>% ggplot(aes(height)) + 
  stat_ecdf() +
  ylab("F(a)") + xlab("a")

library(dplyr)
library(ggplot2)
library(dslabs)
ds_theme_set()
data(murders)
murders %>% mutate(murder_rate = total/population * 10^5) %>%
  ggplot(aes(murder_rate)) + 
  stat_ecdf() +
  ylab("F(a)") + xlab("a")

library(dplyr)
library(ggplot2)
library(dslabs)
ds_theme_set()
data(murders)
murders %>% mutate(murder_rate = total/population * 10^5) %>%
  ggplot(aes(murder_rate)) + 
  stat_ecdf() +
  ylab("F(a)") + xlab("a")


library(dplyr)
library(ggplot2)
library(dslabs)
data(heights)
heights %>% 
  filter(sex=="Male") %>% 
  ggplot(aes(height)) + 
  geom_histogram(binwidth = 1, color = "black")

library(dplyr)
library(ggplot2)
library(dslabs)
data(heights)
heights %>% 
  filter(sex=="Male") %>% 
  ggplot(aes(height)) + 
  geom_histogram(binwidth = 1, color = "black")

library(dplyr)
library(ggplot2)
library(dslabs)
data(murders)
murders %>% ggplot(aes(x=population/10^6)) + geom_density(fill = "grey") 
+ scale_x_log10() + xlab("Population in million")


library(dplyr)
library(ggplot2)
library(gridExtra)
library(dslabs)
data(murders)
p1 <- murders %>% ggplot(aes(x=population/10^6)) + geom_density(fill = "grey", bw = 5) + xlab("Population in millions") + ggtitle("1")
p2 <- murders %>% ggplot(aes(x=population/10^6)) + geom_density(fill = "grey", bw = .05) + scale_x_log10() + xlab("Population in millions") + ggtitle("2")
p3 <- murders %>% ggplot(aes(x=population/10^6)) + geom_density(fill = "grey", bw = 1) + scale_x_log10() + xlab("Population in millions") + ggtitle("3")
grid.arrange(p1,p2,p3,ncol=2)

