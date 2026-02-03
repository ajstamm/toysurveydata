# Create a set of single-selection date variables

Create a set of single-selection date variables

## Usage

``` r
select_dates_set(d, count)
```

## Arguments

- d:

  dataset containing variable details

- count:

  integer; number of responses (rows)

## Examples

``` r
d <- data.frame(variable = "my_dates", type = "date", miss_pct = 10,
                min_val = "6/1/2025",  max_val = "8/31/2025")

select_dates_set(d, count = 10)
#>    id   my_dates
#> 1   1 2025-07-16
#> 2   2 2025-08-09
#> 3   3 2025-08-21
#> 4   4 2025-06-21
#> 5   5 2025-07-20
#> 6   6       <NA>
#> 7   7 2025-06-21
#> 8   8 2025-08-11
#> 9   9 2025-07-19
#> 10 10 2025-07-19
```
