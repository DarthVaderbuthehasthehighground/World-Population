#if .library has any error then install the packages before executing
#syntax of each pack. can be found on google
library(readr)
library(dplyr)
library(ggplot2)
library(gridExtra)
library(maptools)
library(RColorBrewer)
install.packages("gpclib")
gpclibPermit()


library("tidyverse")
global_pop <- read_csv("global_population.csv")

head(global_pop$Population, n = 10)

lapply(global_pop, class)

global_pop$Population <- gsub(",","", global_pop$Population, fixed = TRUE)
head(global_pop$Population, n = 10)

head(global_pop$Percentage, n = 10)

global_pop$Percentage <- as.numeric(gsub("%", "", global_pop$Percentage))/100
head(global_pop, n = 10)

lapply(global_pop, class)

global_pop$Population <- as.numeric(global_pop$Population)
lapply(global_pop, class)

pop_top <- head(global_pop, n = 10)

ggplot(pop_top, aes(x=Country, y=Population)) +
  geom_boxplot()

options(scipen = 999)

options(scipen = 000)

pop_top1 <- ggplot(pop_top, aes(x = Country, y = Population)) +
  geom_bar(stat = "identity")
pop_top2 <- ggplot(pop_top, aes(x=reorder(Country, -Population), y = Population)) +
  geom_bar(stat = "identity")
grid.arrange(arrangeGrob(pop_top1, pop_top2))

ggplot(pop_top, aes(x = reorder(Country, Population), y = Population)) +
  geom_bar(stat = "identity")

ggplot(pop_top, aes(x = reorder(Country, -Population), y = Population)) +
  geom_bar(stat = "identity") +
  ylim(0,1500000000) +
  xlab("Country") +
  ylab("Population") +
  ggtitle("2018 Top 10 Global Population") +
  theme(axis.text.x = element_text(angle = 45,hjust = 1)) +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(pop_top, aes(x = reorder(Country, -Population), y = Population, fill = Country)) +
  geom_bar(stat = "identity") +
  ylim(0,1500000000) +
  xlab("Country") +
  ylab("Population") +
  ggtitle("2018 Top 10 Global Population") +
  theme(axis.text.x = element_text(angle = 45,hjust = 1)) +
  theme(plot.title = element_text(hjust = 0.5))

data("wrld_simpl")
plot(wrld_simpl)

summary(wrld_simpl)

head(pop_top$Country, Rank , n = 10)

select(pop_top, Country, Rank)

countries <- pop_top$Country
countries <- wrld_simpl@data$NAME %in% (countries)
plot(wrld_simpl, col = c(gray(.80), "Yellow")[countries+1])

display.brewer.pal(9,"Greens")
global_pop$Population <- as.numeric(global_pop$Population)

pop_top14 <- head(global_pop, n = 14)
color_population <- colorRampPalette(brewer.pal(9, 'Blues'))(length(pop_top14$Population))
color_population <- color_population[with(pop_top14, findInterval(Population, sort(unique(Population))))]
color_country <- rep(grey(0.8), length(wrld_simpl@data$NAME))
color_country[match(pop_top14$Country, wrld_simpl@data$NAME)] <- color_population

plot(wrld_simpl, col = color_country)
head(global_pop, n = 14)

gg <- ggplot(pop_top, aes(x, y, colour = red))
gg <- gg + geom_point()
gg <- gg + geom_smooth(alpha=0.3, method="lm")
print(gg)
