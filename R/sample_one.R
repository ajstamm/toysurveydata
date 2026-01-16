#' Create a random vector of responses
#' 
#' @param options  vector of strings; value options
#' @param probs    vector of numbers; probability options
#' @param miss_pct number between 0 and 100; percent of responses expected 
#'                 to be missing
#' @param count    integer; number of responses (rows)
#' 
#' Create a vector of values based on pre-defined choices and probabilities.
#' You can also program in a certain percent of missing values. 
#' 
#' 
#' @examples
#' sample_one(options = letters[1:3], probs = 1:3, count = 10, miss_pct = 20)
#' 
#' @export


sample_one <- function(options, probs, count = 100, miss_pct = 10) {
  options <- c(options, NA)
  probs <- c(probs, sum(probs) * miss_pct / (100 - miss_pct))
  t <- sample(options, size = count, replace = TRUE, prob = probs)
  return(t)
}
