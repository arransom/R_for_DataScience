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

# Answer: It is not useful because vehicle class and drive are independent 
#         variables.  If the two variables were related, we may be able to see
#         trends in their relationship.  (However, we may create a scatterplot
#         with the two variables to confirm that they are unrelated)


# 3.3 Aesthetic Mappings -------------------------------------------------------

# Exercises

# What’s gone wrong with this code? Why are the points not blue?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
# Answer: The argument "color = "blue" is in the wrong location within the code
#         Instead, you could use the following code:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# Which variables in mpg are categorical? 
# Answer: ggplot will read the following variables as categorical: 
#         manufacturer, model, trans, drv, fl, class
#         However, you may also want to analyze year and cyl as categorical 
#         values using the function: as.factor()

# Which variables are continuous? 
# Answer: ggplot will read the folowing values as continuous:
#         year, displ, cty, hwy

# How can you see this information when you run mpg?
# Answer: run glimpse() to see the class of each variable.  Categorical
#         variables will usually be in class "character" ("chr") while 
#         continuous variables will be numeric (class "integer" ("int") or 
#         "double" ("dbl"))

# Map a continuous variable to color, size, and shape. 
# How do these aesthetics behave differently for categorical vs. 
# continuous variables?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = cty))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = cty))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = cty))

# Answer: For color and size, the results appear along a gradient 
#         (from light blue to dark blue, for instance, or from small to large)
#         Attempts to map a continuous variable to shape result in error msg

# What happens if you map the same variable to multiple aesthetics?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = hwy))

# Answer: The variable is mapped to both (or all) of the aesthetics

# What does the stroke aesthetic do? What shapes does it work with? 
# Answer: For shapes with a border, the stroke aesthetic modifies the size of
#         the border.

# What happens if you map an aesthetic to something other than a variable name, 
# like aes(colour = displ < 5)? Note, you'll also need to specify x and y.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ <5))

# Answer: it maps the aesthetic to the data using the criteria you have given
