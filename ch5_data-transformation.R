# R for Data Science
# Chapter 5 - Data Transformation
# Date: 9/18/2019

# Load Packages ----------------------------------------------------------------

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

# 5.4 Select columns with select() ---------------------------------------------

# Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, 
# and arr_delay from flights.

flights %>% select("dep_time", "dep_delay", "arr_time", "arr_delay")
flights %>% select(4,6,7,9)

flights %>% select("dep_time", "dep_delay":"arr_time", "arr_delay")
flights %>% select(4,6:7,9)

flights %>% select(4:9, -5, -8)
flights %>% select("dep_time":"arr_delay", -"sched_dep_time", -"sched_arr_time")

flights %>% select(4:9, -c(5, 8))
flights %>% select("dep_time":"arr_delay", -c("sched_dep_time", "sched_arr_time"))

flights %>% select("dep_time":"arr_delay", -contains("sched"))
flights %>% select(contains("dep"), contains("arr"), -contains("sched"))

flights %>% select(starts_with("dep"), starts_with("arr"))
flights %>% select(ends_with("time"), ends_with("delay"), 
                   -contains("sched"), -contains("air"))

flights %>% select(everything(), -c(1:3, 5,8, 10:19))
flights %>% select((1:last_col()), -c(1:3, 5,8, 10:last_col()))

# What happens if you include the name of a variable multiple times in a 
# select() call?
  
flights %>% select(dep_time, dep_time, dep_delay)
# Answer: The column will only be included once in the returned dataframe

# What does the one_of() function do? 
# Answer: The one_of() function is a helper function to the tidyverse' select()
#         function.  It matches variable names in a character vector

# Why might it be helpful in conjunction with this vector?
vars <- c("year", "month", "day", "dep", "arr_delay")

# Answer: You can create a vector to store the names of variables that you 
#         would like to call, and then call the vector using the one_of() 
#         function in conjunction with the select_function.  This will be 
#         especially useful if you expect to need to call the same set of
#         variables regularly. 
#         See example below:
flights %>% select(one_of(vars))

# Does the result of running the following code surprise you? 
select(flights, contains("TIME"))
# Answer: Yes.  R is usually case sensitive.

# How do the select helpers deal with case by default? 
# Answer:  By default, the select helpers will ignore case. 

# How can you change that default?
# You can tell the select helpers not to ignore case by using the argument
# ignore.case = FALSE


# 5.5 Add new variables with Mutate() ------------------------------------------

# Currently dep_time and sched_dep_time are convenient to look at, but hard to 
# compute with because they’re not really continuous numbers. 
# Convert them to a more convenient representation of number of minutes since 
# midnight.

flight_times<-flights %>%
  mutate(dep_hour = dep_time %/% 100,
         dep_minute = dep_time %% 100,
         dep_mins_past_midnight = dep_hour * 60 + dep_minute,
         sched_dep_hour = sched_dep_time %/% 100,
         sched_dep_minute = sched_dep_time %% 100,
         sched_dep_mins_past_midnight = sched_dep_hour * 60 + sched_dep_minute) %>%
  select(-c(dep_hour, dep_minute, sched_dep_hour, sched_dep_minute))


# Compare air_time with arr_time - dep_time. 
flight_compare <- flights %>%
  mutate(wrong_calc = arr_time - dep_time) %>%
  select(air_time, wrong_calc, arr_time, dep_time) %>%
  print(nrows=Inf)

# What do you expect to see? What do you see? What do you need to do to fix it?
# Answer: I expect that air_time and the result of arr_time - dep_time will
#         be different. My expectation was correct: arr_time and dep_time were
#         treated as integers because of the way they were stored (as objects of 
#         class: "integer" not class "datetime"). To fix it, I could either
#         create new variables representing arr_time and dep_time as the number
#         of minutes past midnight, or convert them to class: "datetime" 


# Compare dep_time, sched_dep_time, and dep_delay. 
# How would you expect those three numbers to be related?
  
# Answer: As with the question above, I would not expect to be able to 
#         accurately calculate dep_delay from dep_time and sched_dep_time 
#         without first converting dep_time and sched_dep_time to new variables
#         representing the number of minutes past midnight, or objects of the
#         class "datetime."  Without these changes, I would only expect the
#         calculation to output accurate results when the dep_time and 
#         sched_dep_time are within the same hour

# Find the 10 most delayed flights using a ranking function. How do you want to 
# handle ties? Carefully read the documentation for min_rank().
flight_delays<-flights %>%
  mutate(most_delayed = min_rank(desc(dep_delay))) %>%
  arrange(most_delayed) %>%
  head(10)


# What does 1:3 + 1:10 return? Why?
1:3 + 1:10
# Answer:  The code returns a vecter with the following values:
#          Vector: 2  4  6  5  7  9  8 10 12 11
#          This vectorized funtion uses 'recycling' rules, repeating the values 
#          in the shorter vector until it matches the length of the longer 
#          vector
#          

# What trigonometric functions does R provide?
# Answer: R provides the following trigonometric functions: cos(), sin(), tan(), 
# acos(), asin(), atan(), atan2(), cospi(), sinpi(), tanpi() 
