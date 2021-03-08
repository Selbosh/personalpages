#baseline tables

rm(list = ls())
library(tidyverse)
library(xlsx)

# open data
data(iris)

# summary statistics for a variable
iris %>%
  summarise(mean1=mean(Sepal.Length, na.rm = TRUE), 
            sd=sd(Sepal.Length, na.rm= TRUE),
            median=median(Sepal.Length, na.rm = TRUE), 
            `25%`=quantile(Sepal.Length, probs=0.25, na.rm = TRUE),
            `75%`=quantile(Sepal.Length, probs=0.75, na.rm = TRUE),
            non_na_count = sum(!is.na(Sepal.Length)),
            na_count = sum(is.na(Sepal.Length)),
            na_percentage = (sum(is.na(Sepal.Length))/n()*100))

# put those statistics into dataframes
d1 <- iris %>%
  summarise(mean=mean(Sepal.Length, na.rm = TRUE), 
            sd=sd(Sepal.Length, na.rm= TRUE),
            median=median(Sepal.Length, na.rm = TRUE), 
            `25%`=quantile(Sepal.Length, probs=0.25, na.rm = TRUE),
            `75%`=quantile(Sepal.Length, probs=0.75, na.rm = TRUE),
            non_na_count = sum(!is.na(Sepal.Length)),
            na_count = sum(is.na(Sepal.Length)),
            na_percentage = (sum(is.na(Sepal.Length))/n()*100))
d1$var <- "Sepal.Length"

d2 <- iris %>%
  summarise(mean=mean(Sepal.Width, na.rm = TRUE), 
            sd=sd(Sepal.Width, na.rm= TRUE),
            median=median(Sepal.Width, na.rm = TRUE), 
            `25%`=quantile(Sepal.Width, probs=0.25, na.rm = TRUE),
            `75%`=quantile(Sepal.Width, probs=0.75, na.rm = TRUE),
            non_na_count = sum(!is.na(Sepal.Width)),
            na_count = sum(is.na(Sepal.Width)),
            na_percentage = (sum(is.na(Sepal.Width))/n()*100))
d2$var <- "Sepal.Width"


d3 <- iris %>%
  summarise(mean=mean(Petal.Width, na.rm = TRUE), 
            sd=sd(Petal.Width, na.rm= TRUE),
            median=median(Petal.Width, na.rm = TRUE), 
            `25%`=quantile(Petal.Width, probs=0.25, na.rm = TRUE),
            `75%`=quantile(Petal.Width, probs=0.75, na.rm = TRUE),
            non_na_count = sum(!is.na(Petal.Width)),
            na_count = sum(is.na(Petal.Width)),
            na_percentage = (sum(is.na(Petal.Width))/n()*100))
d3$var <- "Petal.Width"

# bind together
bl_char <- rbind(d1, d2, d3)

# reorder
bl_char <- bl_char[, c(9, 1, 2, 3, 4, 5, 6, 7, 8)]

# write to excel
write.xlsx(bl_char, "inset file pathway")





