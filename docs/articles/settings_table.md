# Settings table design

A settings table has a very specific schema that can be read and
understood by the functions. While all settings for all variables can be
included in the same table, this vignette will focus only in the
settings needed for each variable type. Depending on your needs, the
remaining settings can be ignored or left blank.

## Data schema

This is the full list of variables (settings) that can be included in
the settings file. The necessary variables for each function will be
included in the section for that function.

- variable (string): what to call the variable in the final dataset
- type (string): specific strings trigger specific function calls; all
  others are ignored
- options (string): options for categorical variables, with a separate
  option on each row
- probability_1 (number): the likelihood of that item being selected,
  based on the function [`sample()`](https://rdrr.io/r/base/sample.html)
- labels (string): labels to use for values in select-many type
  questions
- probability_2 (number): the likelihood of that item being selected in
  a second (or more) run in select-many type questions, based on the
  function [`sample()`](https://rdrr.io/r/base/sample.html)
- min_val (number): the minimum allowed value for selections based on a
  normal distribution
- max_val (number): the maximum allowed value for selections based on a
  normal distribution
- mean_val (number): the mean value for selections based on a normal
  distribution
- sd_val (number): the standard deviation for selections based on a
  normal distribution
- max_opts (integer): the maximum possible number of selections for
  select-many options
- miss_pct (number): the percentage of responses that are expected to
  contain missing values

## Categorical single item selection data

For categorical data where only one item is selected, your table should
contain the following settings: variable, type, options, probability_1,
and miss_pct. All other settings are ignored.

For illustration, first create a simple data frame with each of these
settings.

``` r
cat1 <- data.frame(
  variable = "my_letters", # variable name in final dataset
  type = "select-one",     # string that triggers `select_categorical_set()`
  options = letters[1:5],  # value options
  probability_1 = 1:5,     # proportions or probabilities (need not sum to 100)
  miss_pct = 10            # percentage of missing values expected (between 0 and 100)
)
```

| variable   | type       | options | probability_1 | miss_pct |
|:-----------|:-----------|:--------|--------------:|---------:|
| my_letters | select-one | a       |             1 |       10 |
| my_letters | select-one | b       |             2 |       10 |
| my_letters | select-one | c       |             3 |       10 |
| my_letters | select-one | d       |             4 |       10 |
| my_letters | select-one | e       |             5 |       10 |

Table 1. Example settings for single item selection categorical data

After your dataset is created, run the
[`select_categorical_set()`](https://ajstamm.github.io/toysurveydata/reference/select_categorical_set.md)
function, which is a wrapper for the
[`sample_one()`](https://ajstamm.github.io/toysurveydata/reference/sample_one.md)
function and allows you to generate multiple variables at once, if your
dataset contains many single item selection questions.

``` r
cat1data <- select_categorical_set(d = cat1, count = 5)
```

|  id | my_letters |
|----:|:-----------|
|   1 | e          |
|   2 | b          |
|   3 | c          |
|   4 | e          |
|   5 | e          |

Table 2. Example single item selection categorical data

## Categorical multiple item selection data

For categorical data where multiple items can be selected, your table
should contain the following settings: variable, type, options,
probability_1, probability_2, labels, max_opts, and miss_pct. All other
settings are ignored.

For illustration, first create a simple data frame with each of these
settings.

``` r
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
```

| variable   | type        | options | probability_1 | miss_pct | labels | probability_2 | max_opts |
|:-----------|:------------|:--------|--------------:|---------:|:-------|--------------:|---------:|
| my_letters | select-many | a       |             1 |        5 | a      |             5 |        3 |
| my_letters | select-many | b       |             2 |        5 | b      |             4 |        3 |
| my_letters | select-many | c       |             3 |        5 | c      |             3 |        3 |
| my_letters | select-many | d       |             4 |        5 | d      |             2 |        3 |
| my_letters | select-many | e       |             5 |        5 | e      |             1 |        3 |

Table 3. Example settings for multiple item selection categorical data

After your dataset is created, run the
[`select_many_set()`](https://ajstamm.github.io/toysurveydata/reference/select_many_set.md)
function, which is a wrapper for the
[`sample_many()`](https://ajstamm.github.io/toysurveydata/reference/sample_many.md)
function and allows you to generate multiple variables at once, if your
dataset contains many multiple item selection questions.

``` r
cat2data <- select_many_set(d = cat2, count = 5)
```

|  id | d   | e   | b   | a   |
|----:|:----|:----|:----|:----|
|   1 | d   | NA  | NA  | a   |
|   2 | d   | NA  | b   | a   |
|   3 | d   | NA  | NA  | a   |
|   4 | NA  | NA  | b   | NA  |
|   5 | NA  | e   | b   | NA  |

Table 4. Example multiple item selection categorical data

## Continuous data

In this package, continuous data are assumed to be normally distributed,
but upper and lower limits are coded in and cannot be missing. The
function used,
[`select_continuous_set()`](https://ajstamm.github.io/toysurveydata/reference/select_continuous_set.md),
has only been tested on positive numbers.

For continuous data, your table should contain the following settings:
variable, type, miss_pct, min_val, max_val, mean_val, and sd_val. All
other settings are ignored.

For illustration, first create a simple data frame with each of these
settings.

``` r
cont <- data.frame(
  variable = "my_numbers", # variable name in final dataset
  type = "normal",         # string that triggers `select_many_set()`
  miss_pct = 20,           # percentage of missing values expected (between 0 and 100)
  min_val = 0,             # minimum allowed value
  max_val = 100,           # maximum allowed value
  mean_val = 75,           # mean expected value
  sd_val = 10              # expected standard deviation
)
```

| variable   | type   | miss_pct | min_val | max_val | mean_val | sd_val |
|:-----------|:-------|---------:|--------:|--------:|---------:|-------:|
| my_numbers | normal |       20 |       0 |     100 |       75 |     10 |

Table 5. Example settings for continuous data

After your dataset is created, run the
[`select_continuous_set()`](https://ajstamm.github.io/toysurveydata/reference/select_continuous_set.md)
function, which utilizes `truncnorm::rturncnorm()` and allows you to
generate multiple variables at once, if your dataset contains many
continuous values response questions.

``` r
contdata <- select_continuous_set(d = cont, count = 5)
```

|  id | my_numbers |
|----:|-----------:|
|   1 |      69.46 |
|   2 |      81.29 |
|   3 |      95.65 |
|   4 |         NA |
|   5 |      80.12 |

Table 6. Example continuous data

The function
[`select_continuous_set()`](https://ajstamm.github.io/toysurveydata/reference/select_continuous_set.md)
rounds all responses to the nearest hundredth. This could easily be
changed or made into a function option if there is interest. I have used
this function to generate a normal distribution of years, then in
post-processing, I rounded to the nearest integer.

## Date data

I created the dates function to simulate survey dates, where the survey
is available for a short range of time and each day has an equal chance
of being chosen. If you want a random sample of birth dates, this
function could be used for that, but that is not its intent.

For date data, your table should contain the following settings:
variable, type, miss_pct, min_val, and max_val. All other settings are
ignored.

For illustration, first create a simple data frame with each of these
settings.

``` r
date <- data.frame(
  variable = "my_dates", # variable name in final dataset
  type = "date",         # string that triggers `select_many_set()`
  miss_pct = 20,         # percentage of missing values expected (between 0 and 100)
  min_val = "6/1/2025",  # earliest allowed date ("yyyy-mm-dd" format also accepted)
  max_val = "8/31/2025"  # latest allowed date ("yyyy-mm-dd" format also accepted)
)
```

| variable | type | miss_pct | min_val  | max_val   |
|:---------|:-----|---------:|:---------|:----------|
| my_dates | date |       20 | 6/1/2025 | 8/31/2025 |

Table 7. Example settings for date data

After your dataset is created, run the
[`select_dates_set()`](https://ajstamm.github.io/toysurveydata/reference/select_dates_set.md)
function, which allows you to generate multiple variables at once, if
your dataset contains many date response questions.

``` r
datedata <- select_dates_set(d = date, count = 5)
```

|  id | my_dates   |
|----:|:-----------|
|   1 | 2025-07-04 |
|   2 | 2025-07-05 |
|   3 | 2025-08-28 |
|   4 | 2025-08-25 |
|   5 | NA         |

Table 8. Example date data

## Extra functions in the package

### IP address data

I created the internet protocol (IP) address function as a request to
simulate random IP addresses. IP addresses vary by geography. This
function assumes total randomness, so if geography is important, you may
want to clone and modify it to fit your needs.

This function is not run using the settings table. It takes only one
input, the number of responses. It only produces one variable,
“ip_address”.

``` r
ipdata <- sample_ip(count = 5)
```

|  id | ip_address     |
|----:|:---------------|
|   1 | 70.159.183.161 |
|   2 | 9.116.21.178   |
|   3 | 150.161.94.173 |
|   4 | 255.16.128.64  |
|   5 | 10.179.69.24   |

Table 9. Example IP address data

### Age data

I created the age function to meet my very specific needs, which
required incorrect ages as a data validation exercise. As a result, the
function generates age from two dates (in my case, birth date and survey
date), and includes an option to add error. I added missingness to my
own age variable by using start and end date variables that contained
missingness.

This function is not run using the settings table. It takes three
inputs, start date, end date, and whether to include error. The only
variable returned is age. In the example below, all dates in our date
example were from 2025, so all ages will be 25 unless we introduce
error.

``` r
# since the chance of error is low, we will artificially increase the number of records
end_dates = rep(datedata$my_dates, 10) # enter 50 end dates instead of 5
age <- sample_age(start_date = "2000-01-01", end_date = end_dates, error = TRUE)
```

| age | Freq |
|:----|-----:|
| 25  |   39 |
| 26  |    1 |
| NA  |   10 |

Table 10. Frequency table of age data with errors
