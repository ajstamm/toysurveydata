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
#> 1   1 2025-07-25
#> 2   2 2025-06-11
#> 3   3       <NA>
#> 4   4 2025-07-06
#> 5   5 2025-06-07
#> 6   6 2025-06-23
#> 7   7 2025-08-27
#> 8   8 2025-07-04
#> 9   9 2025-08-11
#> 10 10 2025-08-12
```
