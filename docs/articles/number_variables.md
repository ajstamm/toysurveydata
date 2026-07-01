# Simulating number variables

This vignette covers the basics of creating number variables, including
dates, ages, and continuous variables. For other variable types, please
see the [Settings Table
Design](https://ajstamm.github.io/toysurveydata/articles/settings_table.html)
vignette.

The `toysurveydata` package is designed to be a quick, easy way to
create synthetic data that mimic real data structures for the following
purposes:

- to test workflows and error handling
- to teach data management

When *not* to use `toysurveydata`

This package does not perform any special modeling and does not require
existing data. Most functions calculate only one variable at a time and
do not take into account the values of or relationships with other
variables. This package would *not* be appropriate for research.

Most of the functions in this package read in a settings table that
follows a specific data schema. The settings table should be populated
with values and probabilities based on the results of past surveys and
research. The settings table is used to generate some - not all - of the
settings table values.

## Date data

I created the dates function to simulate survey dates, where the survey
is available for a short range of time and each day has an equal chance
of being chosen.

*Note:* If you want a random sample of appointment dates or birth dates,
this function might also be used for that. However, there is not a
mechanism to limit dates to only certain days of the week or month. If
you would like that addressed, please leave an issue in
[GitHub](https://github.com/ajstamm/toysurveydata/issues).

### Settings dataset

For date data, your table should contain the following settings. All
other settings are ignored.

- **variable**: variable name in final dataset
- **type = “date”**: string that triggers
  [`select_dates_set()`](https://ajstamm.github.io/toysurveydata/reference/select_dates_set.md)  
- **min_val**: the minimum allowed value for selections based on a
  normal distribution
- **max_val**: the maximum allowed value for selections based on a
  normal distribution
- **miss_pct**: percentage of missing values expected (between 0 and
  100)
  - If you want no missing values, set “miss_pct” to 0.
  - If “miss_pct” is missing, “miss_pct” is set to 0.

### Response dataset

The response dataset is created by running the
[`select_dates_set()`](https://ajstamm.github.io/toysurveydata/reference/select_dates_set.md)
function. If your survey contains many date variables, this function
allows you to generate the data for all of the variables at once.

### Example code

Create a simple data frame with each of these settings. This data frame
could contain multiple different variables. I am showing only one
variable here for simplicity.

``` r

response_dates <- data.frame(
  variable = "my_dates", 
  type = "date",         
  miss_pct = 20,         
  min_val = "6/1/2025",  
  max_val = "8/31/2025"  
)
```

After your settings file is created, read it into
[`select_dates_set()`](https://ajstamm.github.io/toysurveydata/reference/select_dates_set.md).

``` r

dates_of_responses <- select_dates_set(d = response_dates, count = 20)
```

## Continuous data

I created the continuous data function to simulate normally distributed
continuous measures like height and weight. Note that upper and lower
limits are coded in and cannot be missing.

*Note:* If you want a random sample of temperatures, this function might
also be used for that. However, this function has only been tested on
positive numbers and rounds responses to the nearest hundredth. If you
would like that addressed, please leave an issue in
[GitHub](https://github.com/ajstamm/toysurveydata/issues).

### Settings dataset

For continuous data, your table should contain the following settings.
All other settings are ignored.

- **variable**: variable name in final dataset
- **type = “normal”**: string that triggers
  [`select_continuous_set()`](https://ajstamm.github.io/toysurveydata/reference/select_continuous_set.md)  
- **min_val**: minimum allowed value based on a normal distribution
- **max_val**: maximum allowed value based on a normal distribution
- **miss_pct**: percentage of missing values expected (between 0 and
  100)
  - If you want no missing values, set “miss_pct” to 0.
  - If “miss_pct” is missing, “miss_pct” is set to 0.
- **mean_val**: mean value based on a normal distribution
- **sd_val**: standard deviation based on a normal distribution

### Response dataset

The response dataset is created by running the
[`select_continuous_set()`](https://ajstamm.github.io/toysurveydata/reference/select_continuous_set.md)
function. If your survey contains many continuous variables, this
function allows you to generate the data for all of the variables at
once.

### Example code

Create a simple data frame with each of these settings. This data frame
could contain multiple different variables. I am showing only one
variable here for simplicity.

``` r

heights <- data.frame(
  variable = "height_cm", # variable name in final dataset
  type = "normal",        # string that triggers `select_continuous_set()`
  miss_pct = 20,          # percentage of missing values expected (between 0 and 100)
  min_val = 150,          # minimum allowed value
  max_val = 200,          # maximum allowed value
  mean_val = 170,         # mean expected value
  sd_val = 7              # expected standard deviation
)
```

After your settings file is created, read it into
[`select_continuous_set()`](https://ajstamm.github.io/toysurveydata/reference/select_continuous_set.md).

``` r

response_heights <- select_continuous_set(d = heights, count = 20)
```

## Age data

I created the age function to calculate incorrect ages as a data
validation exercise. The function generates age from two dates (such as
birth date and survey date), and includes an option to add error. I
added missingness to my own age variable by using start and end date
variables that contained missingness.

This function is not run using the settings table. It takes three
inputs, start date, end date, and a number representing the amount of
error (0 to 100 percent). The only variable returned is age.

### Example code

To generate ages, we will begin by generating two dates. Create your
settings file, then read it into
[`select_dates_set()`](https://ajstamm.github.io/toysurveydata/reference/select_dates_set.md).

``` r

age_date_settings <- data.frame(
  variable = c("birth_date", "response_date"), 
  type = "date",         
  miss_pct = 0,         
  min_val = c("1/1/1965", "1/1/2025"),
  max_val = c("1/1/2005", "12/31/2026")  
)
age_dates <- select_dates_set(d = age_date_settings, count = 20)
```

We will generate two ages, one without error and one with very high
error, so you can see the difference.

``` r

age_dates$right_age <- sample_age(start_date = age_dates$birth_date, 
                                  end_date = age_dates$response_date, 
                                  error = 0)
age_dates$wrong_age <- sample_age(start_date = age_dates$birth_date, 
                                  end_date = age_dates$response_date, 
                                  error = 100)
```
