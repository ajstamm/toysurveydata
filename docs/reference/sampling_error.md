# Add sampling data errors

Add sampling data errors

## Usage

``` r
sampling_error(var, type = "numeric", error = 5)
```

## Arguments

- var:

  vector of values to be modified

- type:

  type of data in the vector: accepts "character" or "numeric"

- error:

  numeric; amount of error to include, from 0 (none) to 100 (full
  dataset)

## Examples

``` r
d <- data.frame(x = signif(rnorm(10000, mean = 0, sd = 100), digits = 4))
d$y <- sampling_error(d$x)
#> Warning: There was 1 warning in `dplyr::mutate()`.
#> ℹ In argument: `var = dplyr::case_when(...)`.
#> Caused by warning:
#> ! NaNs produced
```
