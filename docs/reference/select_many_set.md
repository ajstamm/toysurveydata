# Create a set of multiple-selection variables

Create a set of multiple-selection variables

## Usage

``` r
select_many_set(d, count = 100)
```

## Arguments

- d:

  dataset containing variable details

- count:

  integer; number of responses (rows)

## Examples

``` r
d <- data.frame(variable = "my_letters", type = "select-many", miss_pct = 10,
                options = letters[1:5], labels = letters[1:5], max_opts = 3,
                probability_1 = 9:5, probability_2 = 1:5)

select_many_set(d, count = 10)
#> # A tibble: 10 × 6
#>       id a     b     e     d     c    
#>    <int> <chr> <chr> <chr> <chr> <chr>
#>  1     1 NA    b     NA    d     NA   
#>  2     2 NA    NA    e     NA    c    
#>  3     3 NA    b     NA    NA    NA   
#>  4     4 NA    b     NA    d     c    
#>  5     5 a     NA    e     d     NA   
#>  6     6 NA    b     e     NA    NA   
#>  7     7 NA    b     NA    NA    c    
#>  8     8 NA    b     NA    NA    c    
#>  9     9 a     NA    e     NA    NA   
#> 10    10 NA    b     NA    d     c    
```
