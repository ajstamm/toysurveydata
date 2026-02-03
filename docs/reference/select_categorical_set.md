# Create a set of single-selection categorical variables

Create a set of single-selection categorical variables

## Usage

``` r
select_categorical_set(d, count)
```

## Arguments

- d:

  dataset containing variable details

- count:

  integer; number of responses (rows)

## Examples

``` r
d <- data.frame(
  type = "select-one",
  variable = "my_letters",
  options = letters[1:5],
  probability_1 = 1:5,
  miss_pct = 10
)

select_categorical_set(d, count = 10)
#>    id my_letters
#> 1   1          b
#> 2   2          d
#> 3   3          d
#> 4   4          c
#> 5   5          e
#> 6   6          c
#> 7   7          e
#> 8   8          b
#> 9   9          e
#> 10 10          b
```
