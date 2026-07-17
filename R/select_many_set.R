#' Create a set of multiple-selection variables
#' 
#' @param d           dataset; contains labels and probabilities
#' @param count       integer; number of responses (rows)
#' @param summary_var boolean; should a summary variable be calculated?
#' @param force_max   boolean; should all responses select the maximum allowed
#'                    number of options?
#' 
#' @examples
#' d <- data.frame(variable = "my_letters", type = "select-many", miss_pct = 10,
#'                 options = letters[1:5], labels = letters[1:5], max_opts = 3,
#'                 probability_1 = 9:5, probability_2 = 1:5)
#' 
#' select_many_set(d, count = 10, force_max = TRUE)
#' 
#' @export
#' 
#' 

# update to read force_max and summary_var from settings?
select_many_set <- function(d, count = 100, summary_var = TRUE, 
                            force_max = FALSE) {
  dt <- unique(d$variable[d$type == "select-many"])
  
  if (length(dt) > 0) {
    l <- list()
    for (i in dt) {
      l[[i]] <- sample_many(var = i, d = d, count = count, 
                            summary_var = summary_var)
    }
    t <- purrr::reduce(l, dplyr::left_join, by = "id")
  } else t <- NULL
  
  return(t)
}

