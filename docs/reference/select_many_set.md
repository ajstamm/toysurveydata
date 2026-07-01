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
#>       id b     a     e     c     d    
#>    <int> <chr> <chr> <chr> <chr> <chr>
#>  1     1 b     NA    e     c     NA   
#>  2     2 b     NA    NA    c     NA   
#>  3     3 b     NA    e     NA    NA   
#>  4     4 b     a     NA    c     NA   
#>  5     5 NA    NA    NA    NA    d    
#>  6     6 NA    NA    e     NA    d    
#>  7     7 NA    NA    NA    c     d    
#>  8     8 b     NA    e     NA    d    
#>  9     9 b     NA    NA    c     NA   
#> 10    10 NA    NA    NA    c     NA   
```
