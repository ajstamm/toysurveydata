# Simulating categorical variables

This vignette covers the basics of creating categorical variables. I
would like your feedback on some of the features I am considering
adding. For other variable types, please see the [Settings Table
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
research.

## Categorical single item selection

### Settings dataset

For categorical data where only one item is selected, your table should
contain the following settings. All other settings are ignored.

- **variable**: variable name in final dataset
- **type = “select-one”**: string that triggers
  [`select_categorical_set()`](https://ajstamm.github.io/toysurveydata/reference/select_categorical_set.md)  
  Only the value in the first row is used.
- **options**: possible values, with one value for each row
- **probability_1**: proportions or probabilities of that item being
  selected
  - Use response probabilities from past surveys.
  - The function uses [`sample()`](https://rdrr.io/r/base/sample.html),
    so probabilities need not sum to 100.
- **miss_pct**: percentage of missing values expected (between 0 and
  100)
  - If you want no missing values, set “miss_pct” to 0.
  - If there are multiple values for “miss_pct”, the function uses the
    maximum non-missing value.
  - If all values are missing, “miss_pct” is set to 0.

### Response dataset

The response dataset is created by running the
[`select_categorical_set()`](https://ajstamm.github.io/toysurveydata/reference/select_categorical_set.md)
function, which is a wrapper for the
[`sample_one()`](https://ajstamm.github.io/toysurveydata/reference/sample_one.md)
function. If your survey contains many single item selection questions,
this function allows you to generate the data for all of the questions
at once.

### Example

Create a simple data frame with each of these settings. This data frame
could contain multiple different variables. I am showing only one
variable here for simplicity.

``` r
gender_opts <- data.frame(
  variable = "gender", 
  type = "select-one", 
  options = c("Female", "Male", "Other", "Prefer not to say"),
  probability_1 = c(50, 50, 5, 5),
  miss_pct = 10 
)
```

After your settings file is created, read it into
[`select_categorical_set()`](https://ajstamm.github.io/toysurveydata/reference/select_categorical_set.md).

``` r
gender_resp <- select_categorical_set(d = gender_opts, count = 20)
```

## Categorical multiple item selection

### Settings dataset

For categorical data where multiple items can be selected, your table
should contain the following settings. All other settings are ignored.

- **variable**: variable name used to identify options to use in the
  function
- **type = “select-many”**: string that triggers
  [`select_many_set()`](https://ajstamm.github.io/toysurveydata/reference/select_many_set.md)
- **options**: possible values, with one value for each row
  - These will become the variable names in the final dataset, so they
    should be valid R object names. (Imagine question labels in survey
    software.)
  - The string “none” is special. The function checks if any strings in
    the options contain it. If so, any additional selections for the
    same record are removed.
- **labels**: value labels for the options (can duplicate “options”)
  - For numeric values instead of strings, replace the strings with
    numbers. The Boolean value TRUE for all options also works.
- **probability_1**: proportions or probabilities of that item being
  selected
  - Use response probabilities from past surveys.
  - The function uses [`sample()`](https://rdrr.io/r/base/sample.html),
    so probabilities need not sum to 100.
- **probability_2**: proportions or probabilities (can duplicate
  “probability_1”)
  - I added two settings for probabilities for two reasons:
    1.  to remove very common values, to prevent all records from being
        assigned to them.
    2.  to remove “none” as a possible value for additional selections.
- **max_opts**: maximum allowed responses
  - A record can be assigned between 1 and “max_opts” values.
  - If there are multiple values for “max_opts”, the function takes the
    maximum non-missing value.
- **miss_pct**: percentage of missing values expected (between 0 and
  100)
  - If you want no missing values, set “miss_pct” to 0.
  - If there are multiple values for “miss_pct”, the function uses the
    maximum non-missing value.
  - If all values for “miss_pct” are missing, “miss_pct” is set to 0.

Future multiple item selection features under consideration

1.  Add an option to skip the step that removes additional values when a
    record is assigned “none” to provide messier data for teaching data
    validation and cleaning.
2.  Add an option to force records that were not assigned “none” to be
    assigned exactly “max_opts” values.
3.  Add an option to set unchecked values as something other than
    missing when at least one value is checked.
4.  If “max_opts” is missing, set “max_opts” to the total number of
    values.

### Response dataset

The response dataset is created by running the
[`select_many_set()`](https://ajstamm.github.io/toysurveydata/reference/select_many_set.md)
function, which is a wrapper for the
[`sample_many()`](https://ajstamm.github.io/toysurveydata/reference/sample_many.md)
function. If your survey contains many multiple item selection
questions, this function allows you to generate the data for all of the
questions at once.

### Example

Create a simple data frame with each of these settings. In this
fictional community, most people prefer to visit their primary care
doctors for all health needs.

``` r
seek_care_opts <- data.frame(
  variable = "seek_care", 
  type = "select-many", 
  options = c("care_doc", "care_clinic", "care_emerg", 
              "care_tele", "care_urgent", "care_other", "care_none"), 
  labels = c("Doctor's office", "Outpatient clinic", "Emergency room", 
             "Telehealth", "Urgent care clinic", "Other", "Do not seek care"),
  probability_1 = c(90, 5, 1, 2, 3, 1, 1), 
  probability_2 = c( 0, 5, 1, 2, 3, 1, 0), 
  max_opts = 3, 
  miss_pct = 0
)
```

After your settings file is created, read it into
[`select_many_set()`](https://ajstamm.github.io/toysurveydata/reference/select_many_set.md).

``` r
seek_care_resp <- select_many_set(d = seek_care_opts, count = 20)
```

## Combining all data

The functions add “id” columns to all response datasets, so I can join
on “id” to combine the datasets. This step is not handled by the
package.

``` r
resps <- list(gender_resp, seek_care_resp)
full_data <- purrr::reduce(resps, dplyr::left_join, by = "id") |> 
  dplyr::arrange(id)
```
