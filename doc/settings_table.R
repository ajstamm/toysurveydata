## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", message = FALSE, warning = FALSE)
devtools::load_all("../R")

## ----set_categorical_one------------------------------------------------------
cat1 <- data.frame(
  variable = "my_letters", # variable name in final dataset
  type = "select-one",     # string that triggers `select_categorical_set()`
  options = letters[1:5],  # value options
  probability_1 = 1:5,     # proportions or probabilities (need not sum to 100)
  miss_pct = 10            # percentage of missing values expected (between 0 and 100)
)

## ----make_categorical_one-----------------------------------------------------
cat1data <- select_categorical_set(d = cat1, count = 5)

## ----set_categorical_many-----------------------------------------------------
cat2 <- data.frame(
  variable = "my_letters", # variable name in final dataset
  type = "select-many",    # string that triggers `select_many_set()`
  options = letters[1:5],  # value options
  probability_1 = 1:5,     # proportions or probabilities (need not sum to 100)
  miss_pct = 5,            # percentage of missing values expected (between 0 and 100)
  labels = letters[1:5],   # value label in the variable (can duplicate "variable")
  probability_2 = 5:1,     # proportions or probabilities (can duplicate "probability_1")
  max_opts = 3             # maximum allowed responses (could be less)
)

## ----make_categorical_many----------------------------------------------------
cat2data <- select_many_set(d = cat2, count = 5)

## ----set_continuous-----------------------------------------------------------
cont <- data.frame(
  variable = "my_numbers", # variable name in final dataset
  type = "normal",         # string that triggers `select_many_set()`
  miss_pct = 20,           # percentage of missing values expected (between 0 and 100)
  min_val = 0,             # minimum allowed value
  max_val = 100,           # maximum allowed value
  mean_val = 75,           # mean expected value
  sd_val = 10              # expected standard deviation
)

## ----make_continuous----------------------------------------------------------
contdata <- select_continuous_set(d = cont, count = 5)

## ----set_dates----------------------------------------------------------------
date <- data.frame(
  variable = "my_dates", # variable name in final dataset
  type = "date",         # string that triggers `select_many_set()`
  miss_pct = 20,         # percentage of missing values expected (between 0 and 100)
  min_val = "6/1/2025",  # earliest allowed date ("yyyy-mm-dd" format also accepted)
  max_val = "8/31/2025"  # latest allowed date ("yyyy-mm-dd" format also accepted)
)

## ----make_dates---------------------------------------------------------------
datedata <- select_dates_set(d = date, count = 5)

## ----make_ip------------------------------------------------------------------
ipdata <- sample_ip(count = 5)

## ----make_age, warning = FALSE------------------------------------------------
# since the chance of error is low, we will artificially increase the number of records
end_dates = rep(datedata$my_dates, 10) # enter 50 end dates instead of 5
age <- sample_age(start_date = "2000-01-01", end_date = end_dates, error = TRUE)

