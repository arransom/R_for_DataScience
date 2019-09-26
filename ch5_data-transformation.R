# R for Data Science
# Chapter 5 - Data Transformation
# Date: 9/18/2019

# Load Packages ----------------------------------------------------------------

install.packages("nycflights13")
library(nycflights13)
library(tidyverse)

# 5.2 Filter Rows with filter() ------------------------------------------------

# Exercises

# Find all flights that:

# Had an arrival delay of two or more hours
filter(flights, arr_delay >= 120)

# Flew to Houston (IAH or HOU)
filter(flights, dest == 'IAH' | dest == 'HOU')
# or
filter(flights, dest %in% c('IAH', 'HOU'))

# Were operated by United, American, or Delta
filter(flights, carrier == 'UA' | carrier == 'AA' | carrier == 'DL')
# or
filter(flights, carrier %in% c('UA', 'AA', 'DL'))

# Departed in summer (July, August, and September)
filter(flights, month == 7 | month == 8 | month == 9)
# or
filter(flights, month %in% c(7, 8, 9))
# or
filter(flights, between(month, 7,9))

# Arrived more than two hours late, but didn't leave late
filter(flights, arr_delay >= 120 & dep_delay <= 0)

# Were delayed by at least an hour, but made up over 30 minutes in flight
filter(flights, dep_delay >= 60 & (dep_delay - arr_delay >= 30))

# Departed between midnight and 6am (inclusive)
filter(flights, dep_time ==2400 | dep_time <=600)
# or
filter(flights, dep_time %in% c(0:600, 2400))
       
# Another useful dplyr filtering helper is between(). What does it do? 
# Answer: 'between()' selects the values of a numeric vector that fall within
#         a specified range

# Can you use it to simplify the code needed to answer the previous challenges?
# Answer: You can use it to simplify some of the code, however it only works
#         with numeric variables

# How many flights have a missing dep_time? What other variables are missing? 
count(filter(flights, is.na(dep_time)))
# Answer: 8255 flights have missing departure times.  They also have missing
#         departure delays, arrival times and arrival delays, and air time. 

# What might these rows represent?
# Answer: These rows might represent cancelled flights. 

# Why is NA ^ 0 not missing? 
NA ^ 0
# Answer: Because any number raised to the zero degree equals 1.  

# Why is NA | TRUE not missing? 
NA | TRUE
# Answer: Becaues TRUE *or* any other value evaluates to TRUE

# Why is FALSE & NA not missing? 
FALSE & NA
# Answer: Because FALSE *and* any other value evaluates to FALSE

# Can you figure out the general rule? (NA * 0 is a tricky counterexample!)
# Answer: If a statement or equation would evaluate to a specific, static 
#         result no matter what the missing value may be, it will not evaluate
#         to NA.



# 5.3 Arrange Rows with arrange() ----------------------------------------------

# How could you use arrange() to sort all missing values to the start? 
# (Hint: use is.na()).
arrange(flights, desc(is.na(dep_time)))

# Sort flights to find the most delayed flights. 
arrange(flights, desc(dep_delay))

# Find the flights that left earliest.
arrange(flights, dep_delay)

# Sort flights to find the fastest flights.
# Note: I am assuming that this means the shortest air time, not the fastest 
#       flight speed
arrange(flights, air_time)

# Which flights travelled the longest? Which travelled the shortest?
arrange(flights, desc(distance))
arrange(flights, distance)
