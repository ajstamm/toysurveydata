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
#> 1   1      91.49
#> 2   2         NA
#> 3   3      79.13
#> 4   4      78.11
#> 5   5      82.80
#> 6   6      83.19
#> 7   7      59.52
#> 8   8      80.04
#> 9   9      65.67
#> 10 10      64.48
```
