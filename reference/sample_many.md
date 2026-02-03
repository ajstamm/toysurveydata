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
#>       id c     e     a     d     b    
#>    <int> <chr> <chr> <chr> <chr> <chr>
#>  1     1 c     NA    a     NA    b    
#>  2     2 c     NA    a     NA    NA   
#>  3     3 NA    e     a     d     NA   
#>  4     4 NA    e     NA    d     NA   
#>  5     5 c     NA    a     d     NA   
#>  6     6 NA    NA    NA    d     b    
#>  7     7 c     e     NA    NA    b    
#>  8     8 c     NA    NA    d     NA   
#>  9     9 c     e     NA    d     NA   
#> 10    10 c     NA    NA    NA    b    
```
