# Calculate multiple booleans

This function provides up to the maximum allowed number of responses.
Some responses will have less and if your "miss_pct" is greater than
zero, some responses will have no selections.

## Usage

``` r
sample_many(var, d, count = 100)
```

## Arguments

- var:

  string; variable name

- d:

  dataset; contains labels and probabilities

- count:

  integer; number of responses (rows)

## Examples

``` r
d <- data.frame(variable = "my_letters", type = "select-many", miss_pct = 10,
                options = letters[1:5], labels = letters[1:5], max_opts = 3,
                probability_1 = 9:5, probability_2 = 1:5)

sample_many(var = "my_letters", d = d, count = 10)
#> # A tibble: 10 × 6
#>       id b     d     e     a     c    
#>    <int> <chr> <chr> <chr> <chr> <chr>
#>  1     1 NA    d     e     NA    NA   
#>  2     2 NA    d     e     NA    c    
#>  3     3 NA    NA    NA    a     c    
#>  4     4 NA    d     e     NA    NA   
#>  5     5 b     d     e     NA    NA   
#>  6     6 b     NA    NA    a     c    
#>  7     7 NA    NA    NA    a     c    
#>  8     8 NA    d     e     a     NA   
#>  9     9 NA    d     e     NA    NA   
#> 10    10 NA    d     NA    a     c    
```
