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
#> 1   1      79.47
#> 2   2         NA
#> 3   3      71.34
#> 4   4      62.02
#> 5   5      59.05
#> 6   6      67.96
#> 7   7      83.00
#> 8   8      76.28
#> 9   9      90.44
#> 10 10      76.51
```
