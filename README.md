# Toy Survey Data

An R package designed to simplify the process of creating fake survey data

This R package began as a project to create a simple fake dataset based on annual Community Health Assessment surveys. I was preparing to give a presentation on cleaning and validating survey data, but I did not have access to real survey data, for which privacy and confidentiality are major concerns. I reviewed some existing survey creation packages, but they either did not allow the level of customization I needed or used models that read in real data, which I did not have, as a starting point.

This package is designed to be very simple. It does not consider relationships between variables. It includes optional missingness, but it does not include error creation. 

To create your dataset, you need to read in a table of settings in a specific format. The package is designed so that if your table is set up correctly, you can run all functions on that one table.
