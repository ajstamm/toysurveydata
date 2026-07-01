# Create fictional ages based on birth date and survey date

Create fictional ages based on birth date and survey date

## Usage

``` r
sample_age(start_date, end_date = Sys.Date(), error = 0)
```

## Arguments

- start_date:

  date or vector of dates; birth date or other origin date

- end_date:

  dateor vector of dates; survey date or other completion date

- error:

  numeric; amount of error to include, from 0 (none) to 100 (full
  dataset)

## Examples

``` r
sample_age(start_date = "1900-01-01", end_date = "1960-07-31", error = 100)
#> [1] 60
```
