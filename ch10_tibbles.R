# R for Data Science
# Chapter 10 - Tibbles
# Date: 9/27/2019


# Load Packages ----------------------------------------------------------------

library(tidyverse)

# 10.5 Exercises ---------------------------------------------------------------

# Exercises

# How can you tell if an object is a tibble? (Hint: try printing mtcars, 
# which is a regular data frame).

tib_mtcars<-as_tibble(mtcars)

print(mtcars)
print(tib_mtcars)

# Answer:  When you print the object, the first line of a tibble will read:
#          A Tibble: nrows x ncols

 
# Compare and contrast the following operations on a data.frame and equivalent 
# tibble. What is different? Why might the default data frame behaviours cause 
# you frustration?

# Operation 1
# create data.frame                            
df <- data.frame(abc = 1, xyz = "a")

# create equivilant tibble
tib <- tibble(abc = 1, xyz = "a")

# Answer: 
#         data.frame() converted strings to factors, while tibble() did not
#         data.frame() can rename columns (for instance, if a column name 
#            starts is not a valid R column name) while tibble() accepts 
#            non-syntactic variable names
#         a tibble prints with more information than a data.frame (for 
#         instance, a tibble will print with the number of rows and columns
#         identified as well as the column classes)


# Operation 2
df$x
tib$x

# Answer: 
#        data.frames allows partial matching, so this code worked to pull 
#           the "xyz" column from the data.frame.  
#        tibbles do not allow partial matching, so this code did not work to 
#           pull out the "xyz" column.


# Operation 3
df[, "xyz"]
tib[, "xyz"]

# Answer: 
#          This code worked to pull the column "xyz" from both the data.frame
#          and the tibble. The tibble printed additional information: the 
#          number of rows and columns, and the variable class.  However, the
#          type of object differed: the operation pulled a vector from the 
#          data.frame, and pulled a tibble from the tibble


# Operation 4

df[, c("abc", "xyz")]
tib[, c("abc", "xyz")]

# Answer: 
#         This code worked to pull the columns "abc" and "xyz" from both the 
#         data.frame and the tibble. The tibble printed additional 
#         information: the number of rows and columns, and the variable 
#         classes.  The operation pulled a data.frame from the data.frame, and
#         a tibble from the tibble. 


# If you have the name of a variable stored in an object, e.g. var <- "mpg", 
# how can you extract the reference variable from a tibble?
# Answer: By name, using double brackets: tibble[[var]]


# Practice referring to non-syntactic names in the following data frame by:

annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)

# Extracting the variable called 1.
annoying$`1`
annoying[["1"]]
annoying[[1]]

# Plotting a scatterplot of 1 vs 2.
ggplot(annoying, aes(`1`, `2`)) +
       geom_point()
       
# Creating a new column called 3 which is 2 divided by 1.
annoying<-mutate(annoying, `3`=`2`/`1`)
 
# Renaming the columns to one, two and three.
annoying<-rename(annoying, one = `1`, two = `2`, three = `3`)


# What does tibble::enframe() do? When might you use it?
# Answer: tibble::enframe converts atomic vectors or lists to data frames

   
# What option controls how many additional column names are printed at 
# the footer of a tibble?
# Answer: You can specify the number of columns printed using the argument 
#         "n = x".  For instance, print(tib_mtcars, n = 13)
