## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", message = FALSE, warning = FALSE)
devtools::load_all("../R")

## ----table_function, include=FALSE--------------------------------------------
plot_table <- function(df, caption = "") {
  if (nrow(df) < 6) {
    base_options <- list(dom = 't', ordering = FALSE)
  } else {
    base_options <- list(ordering = TRUE, scrollX = TRUE, searching = TRUE, 
                         pageLength = 5, paging = TRUE, 
                         lengthMenu = list(c(5, 10, 25, 50), 
                                           c('5', '10', '25', '50')))
  }
  dt <- DT::datatable(df, selection = "none", class = 'cell-border stripe',
                      escape = FALSE, rownames = FALSE, options = base_options,
                      caption = caption)
  return(dt)
}

## ----set_categorical_one------------------------------------------------------
response_dates <- data.frame(
  variable = "my_dates", 
  type = "date",         
  miss_pct = 20,         
  min_val = "6/1/2025",  
  max_val = "8/31/2025"  
)

## ----make_dates---------------------------------------------------------------
dates_of_responses <- select_dates_set(d = response_dates, count = 20)

## ----set_continuous-----------------------------------------------------------
heights <- data.frame(
  variable = "height_cm", # variable name in final dataset
  type = "normal",        # string that triggers `select_continuous_set()`
  miss_pct = 20,          # percentage of missing values expected (between 0 and 100)
  min_val = 150,          # minimum allowed value
  max_val = 200,          # maximum allowed value
  mean_val = 170,         # mean expected value
  sd_val = 7              # expected standard deviation
)

## ----make_continuous----------------------------------------------------------
response_heights <- select_continuous_set(d = heights, count = 20)

## ----set_ages-----------------------------------------------------------------
age_date_settings <- data.frame(
  variable = c("birth_date", "response_date"), 
  type = "date",         
  miss_pct = 0,         
  min_val = c("1/1/1965", "1/1/2025"),
  max_val = c("1/1/2005", "12/31/2026")  
)
age_dates <- select_dates_set(d = age_date_settings, count = 20)

## ----make_ages----------------------------------------------------------------
age_dates$right_age <- sample_age(start_date = age_dates$birth_date, 
                                  end_date = age_dates$response_date, 
                                  error = 0)
age_dates$wrong_age <- sample_age(start_date = age_dates$birth_date, 
                                  end_date = age_dates$response_date, 
                                  error = 100)

