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
#>       id a     d     e     c     b    
#>    <int> <chr> <chr> <chr> <chr> <chr>
#>  1     1 NA    d     NA    c     NA   
#>  2     2 NA    d     e     NA    NA   
#>  3     3 NA    d     NA    c     NA   
#>  4     4 NA    NA    e     NA    b    
#>  5     5 a     d     NA    NA    NA   
#>  6     6 NA    NA    NA    NA    b    
#>  7     7 a     NA    NA    c     NA   
#>  8     8 NA    NA    e     NA    b    
#>  9     9 NA    d     NA    NA    b    
#> 10    10 a     NA    e     c     NA   
```
