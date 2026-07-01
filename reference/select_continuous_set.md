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
#> 1   1      83.93
#> 2   2      67.22
#> 3   3      79.37
#> 4   4      79.13
#> 5   5         NA
#> 6   6      86.47
#> 7   7      87.17
#> 8   8      75.00
#> 9   9      82.55
#> 10 10      78.42
```
