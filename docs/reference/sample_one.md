# Create a random vector of responses

Create a random vector of responses

## Usage

``` r
sample_one(options, probs, count = 100, miss_pct = 10)
```

## Arguments

- options:

  vector of strings; value options

- probs:

  vector of numbers; probability options

- count:

  integer; number of responses (rows)

  Create a vector of values based on pre-defined choices and
  probabilities. You can also program in a certain percent of missing
  values.

- miss_pct:

  number between 0 and 100; percent of responses expected to be missing

## Examples

``` r
sample_one(options = letters[1:3], probs = 1:3, count = 10, miss_pct = 20)
#>  [1] "c" "c" NA  "c" "b" "c" "b" "c" "a" "b"
```
