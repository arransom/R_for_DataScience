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


# 3.5 - Facets -----------------------------------------------------------------

# What happens if you facet on a continuous variable?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ cty, nrow = 4)
# Answer: You get a facet for every one of the distinct values in the 
#         continuous variable

# What do the empty cells in plot with facet_grid(drv ~ cyl) mean? 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
# Answer: There were no observations in the dataset with those combinations 
#         of drive and cyl

# How do they relate to this plot?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))

# Answer: That plot shows the possible combinations of drv and cyl and confirms
#         that no cars within the dataset match that combination of drv and cyl

# What plots does the following code make? What does . do?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) +  
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

#Answer: The first block of code creates a set of plots showing the
#        relationship between displ, hwy, and drv.
#        displ and hwy are displayed on the x and y axes, respectively,
#        Each row shows a different value of drv.  The . stands in for a
#        column variable and indicates that there is not one in this facet_grid. 
#
#        The second block of code creates a set of plots showing the
#        relationship between displ and hwy for each category of cyl 
#        Each column shows a different value of cyl.  The . stands in for a
#        row variable and indicates that there is not one in this facet_grid. 


# Take the first faceted plot in this section:

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))  


# What are the advantages to using faceting instead of the colour aesthetic? 
# Answer: It's much easier to see the differences between the vehicle types 
#         when they are separated into individual plots. Looking at the plots 
#         side to side, with the same axis ranges, you may be able to make new 
#         analytical insights

# What are the disadvantages? 
# Answer: If there are only a few observations in each category, or only a few 
#         categories to facet by, faceting may not be necessary or make the 
#         information easier to read.

# How might the balance change if you had a larger dataset?
# Answer: A single plot may be even more visually "busy" or overwhelming with  
#         a larger dataset. 

# Read ?facet_wrap. What does nrow do? What does ncol do? 
?facet_wrap
# Answer: nrow specifies the number of rows; ncol specifies the number of 
#         columns. 


# What other options control the layout of the individual panels? 
# Answer: scales, shrink, labeller, and switch

# Why doesn't facet_grid() have nrow and ncol arguments?
# Answer: The number of rows and columns will be informed by the number of
#         unique values or levels in the row variable and column variable, 
#         respectively

# When using facet_grid() you should usually put the variable with more 
# unique levels in the columns. Why?
# Answer: It will be a more efficient use of screen space



# 3.6 Geometric Objects ############################################################  

# What geom would you use to draw...
# A line chart?    Answer = geom_line
# A boxplot?       Answer = geom_boxplot
# A histogram?     Answer = geom_bar or geom_histogram
# An area chart?   Answer = geom_area
  
# Run this code in your head and predict what the output will look like. 
# Then, run the code in R and check your predictions.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# Answer: The output will be a scatterplot using the dataset mpg. 
#         The variable'displ' will be mapped to the x-axis, and the variable
#         'hwy' will be mapped to the y-axis.  Each value of the variable 'drv'
#         will be displayed in a different color. 
#         Trendlines will be mapped to the displ and hwy values for each
#         category of drv

#What does show.legend = FALSE do? What happens if you remove it?
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
  )

# Answer: It removes the legend from the plot.  If you remove it, the legend
#         will be displayed in the plot.

# Why do you think I used it earlier in the chapter?
# Answer: To highlight the fact that if you allow ggplot to automatically group
#         the data when you map an aesthetic to a discrete variable; whereas the 
#         "group()" aesthetic does not. 

# What does the se argument to geom_smooth() do?
# Answer: It displays the standard error of the line that geom_smooth() has 
#         mapped to your data.

#  Will these two graphs look different? Why/why not?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# Answer: No, they will be identical. If you pass the mappings to ggplot, 
#         they will be applied globally.  If you pass them to the individual 
#         geoms, they will be applied locally. 

# Recreate the R code necessary to generate the following graphs.(see book)

# Plot 1
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(size = 3) + 
  geom_smooth(size = 1.5, se = FALSE) 
  
# Plot 2
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv),
              size = 1.5, 
              se = FALSE) +
  geom_point(mapping = aes(x = displ, y = hwy),
             size = 3) 
  
# Plot 3
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point(size = 3) + 
  geom_smooth(size = 1.5, se = FALSE) 

# Plot 4
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv),
             size = 3) +
  geom_smooth(mapping = aes(x = displ, y = hwy),
              size = 1.5, 
              se = FALSE) 

# Plot 5
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv),
             size = 3) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv),
              size = 1.5, 
              se = FALSE) 

# Plot 6
ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy, fill = drv),
             shape = 21, 
             size = 3, 
             color = "white", 
             stroke = 3
             ) 
             