# Toy Survey Data

An R package designed to simplify the process of creating fake survey data.

## Why create this package?

This R package began as a project to create a simple fake dataset based on annual Community Health Assessment surveys. I was preparing to give a presentation on cleaning and validating survey data, but I did not have access to real survey data, for which privacy and confidentiality are major concerns. I reviewed some existing survey creation packages, but they either did not allow the level of customization I needed or used models that read in real data, which I did not have, as a starting point.

## What does this package do?

This package was built initially to generate responses for individual categorical questions based on *a priori* knowledge of response proportions. Some numeric variable and date handling were added later, mostly based on normal distributions.

While functions can be used individually, the package is designed to allow you to build a settings table, then run most functions on that table to generate the full dataset. 


## Getting started

This package is still in active development, but you can install it directly from GitHub using the code `devtools::install_github("ajstamm/toysurveydata")`.

To create your dataset, you will need to read in a table of pre-defined variable settings. Learn how to set up your table in the [Settings Table Design](https://ajstamm.github.io/toysurveydata/articles/settings_table.html) vignette. The package is designed so that if your table is set up correctly, you can run nearly all functions on that one table. 

## Limitations of this package

This package is designed to be very simple and easy to run. It does not consider relationships between variables. It includes optional missingness and a function to introduce random error of different kinds to your data. 

## Future plans

1. Add an option in the select-many function to require an exact number of selections
1. Add a function to handle ranked choice questions
1. Add error-creation functions for text values such as random upper/lower-case, misspellings
2. Add non-random missingness
1. Rethink or improve instructions for percent missing and number of options in the settings table
1. Maybe integrate with or suggest packages that handle things like random addresses
1. Maybe make the IP function at least nominally geographically sensitive


