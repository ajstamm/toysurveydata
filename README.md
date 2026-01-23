# Toy Survey Data

An R package designed to simplify the process of creating fake survey data.

## Why create this package?

This R package began as a project to create a simple fake dataset based on annual Community Health Assessment surveys. I was preparing to give a presentation on cleaning and validating survey data, but I did not have access to real survey data, for which privacy and confidentiality are major concerns. I reviewed some existing survey creation packages, but they either did not allow the level of customization I needed or used models that read in real data, which I did not have, as a starting point.

## What does this package do?

This package was built initially to generate responses for individual categorical questions based on *a priori* knowledge of response proportions. Some numeric variable and date handling were added later, mostly based on normal distributions.

While functions can be used individually, the package is designed to allow you to build a settings table, then run most functions on that table to generate the full dataset. 

## Limitations of this package

This package is designed to be very simple. It does not consider relationships between variables. It includes optional missingness, but it does not include error creation. 

## Getting started

This package is still in active development, so you may get errors if you try to install it directly from GitHub. In the meantime, clone the package and run `devtools::load_all()` to load and use the functions.

(To do: finish setting up the package to be installable.)

To create your dataset, you need to read in a table of settings in a specific format. The package is designed so that if your table is set up correctly, you can run all functions on that one table. 

(To do: add a link to the vignette, and set up pkgdown.)

## Future plans

1. Add an option in the select-many functions to require an exact number of selections
1. Add a function to handle ranked choice questions
1. Add error-creation functions for text and numeric values 
    1. Text: random upper/lower-case, misspellings
    1. Numeric: round to nearest 5 or 10, off by 1, switch positive/negative, false 0
