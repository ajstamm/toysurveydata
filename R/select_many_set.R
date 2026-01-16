#' Create a set of multiple-selection variables
#' 
#' @param d     dataset containing variable details
#' @param count integer; number of responses (rows)
#' 
#' @examples
#' d <- data.frame(variable = "my_letters", type = "select-many", miss_pct = 10,
#'                 options = letters[1:5], labels = letters[1:5], max_opts = 3,
#'                 probability_1 = 9:5, probability_2 = 1:5)
#' 
#' select_many_set(d, count = 10)
#' 
#' @export
#' 
#' 

select_many_set <- function(d, count = 100) {
  dt <- unique(d$variable[d$type == "select-many"])
  
  if (length(dt) > 0) {
    l <- list()
    for (i in dt) {
      l[[i]] <- sample_many(var = i, d = d, count = count)
    }
    t <- purrr::reduce(l, dplyr::left_join, by = "id")
  } else t <- NULL
  
  return(t)
}

