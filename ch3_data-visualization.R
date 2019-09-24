# R for Data Science
# Chapter 3 - Data Visualization
# Date: 9/9/2019

# Load Packages ----------------------------------------------------------------

library(tidyverse)

# 3.2 First Steps --------------------------------------------------------------

# Exercises 

# Run ggplot(data = mpg). What do you see? 
ggplot(data = mpg) # Answer: Empty graph / plot

# How many rows are in mpg? How many columns?
glimpse(mpg) # Answer: 234 rows, 11 columns

# What does the drv variable describe? 

?mpg #Answer: f = front-wheel drive, r = rear-wheel drive, 4 = 4wd

# Make a scatterplot of hwy vs cyl.

ggplot(data = mpg) +
  geom_point(mapping = aes(x = cyl, y = hwy))

# What happens if you make a scatterplot of class vs drv? 
# Why is the plot not useful?
  
ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))

# Answer: It is not useful because vehicle class and drive are not related.  