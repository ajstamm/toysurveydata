#' Create a set of multiple-selection variables
#' 
#' @param d       table (data frame or tibble) containing variable details
#' @param count   integer; number of responses (rows)
#' @param rank_as string; whether rank is the variable name ("variable") 
#'                or value ("value")
#' 
#' @examples
# d <- data.frame(variable = "my_letters", type = "select-rank", miss_pct = 10,
#                 options = letters[1:5], labels = letters[1:5], max_opts = 3,
#                 probability_1 = 9:5, probability_2 = 1:5)
#' 
#' select_rank_set(d, count = 10, rank_as = "value")
#' 
#' @export
#' 
#' 

select_rank_set <- function(d, count = 100, rank_as = "value") {
  dt <- unique(d$variable[d$type == "select-rank"])
  
  if (length(dt) > 0) {
    l <- list()
    for (i in dt) {
      l[[i]] <- sample_rank(var = i, d = d, count = count, rank_as = rank_as)
    }
    t <- purrr::reduce(l, dplyr::left_join, by = "id")
  } else t <- NULL
  
  return(t)
}

