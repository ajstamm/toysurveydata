#' Create a set of single-selection categorical variables
#' 
#' @param d     dataset containing variable details
#' @param count integer; number of responses (rows)
#' 
#' @examples
#' d <- data.frame(
#'   type = "select-one",
#'   variable = "my_letters",
#'   options = letters[1:5],
#'   probability_1 = 1:5,
#'   miss_pct = 10
#' )
#' 
#' select_categorical_set(d, count = 10)
#' 
#' @export

select_categorical_set <- function(d, count) {
  dt <- unique(d$variable[which(d$type == "select-one")])
  if (length(dt) > 0) {
    l <- data.frame(id = 1:count)
    for (i in dt) {
      miss_pct = max(d$miss_pct, na.rm = TRUE)
      if (!is.finite(miss_pct) | miss_pct < 0 | miss_pct > 100) miss_pct <- 0
      t <- dplyr::filter(d, variable == i)
      l$temp <- sample_one(options = t$options, probs = t$probability_1, 
                           count = count, 
                           miss_pct = miss_pct)
      l <- dplyr::rename(l, !!dplyr::sym(i) := temp)
    }
  } else l <- NULL
  
  return(l)
}
