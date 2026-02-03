# Create a set of single-selection continuous variables

Create a set of single-selection continuous variables

## Usage

``` r
select_continuous_set(d, count)
```

## Arguments

- d:

  dataset containing variable details

- count:

  integer; number of responses (rows)

## Examples

``` r
d <- data.frame(type = "normal", variable = "my_numbers", miss_pct = 10,
                min_val = 0,  max_val = 100, mean_val = 75,  sd_val = 10)

select_continuous_set(d, count = 10)
#>    id my_numbers
#> 1   1      76.28
#> 2   2      90.44
#> 3   3      76.51
#> 4   4         NA
#> 5   5      86.45
#> 6   6      65.64
#> 7   7      71.57
#> 8   8      63.94
#> 9   9      51.24
#> 10 10      74.13
```
