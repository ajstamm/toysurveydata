
utils::globalVariables(c("report_count"))


#' Add sampling data errors
#' 
#' @param var   vector of values to be modified
#' @param type  type of data in the vector: accepts "character" or "numeric" 
#' @param error numeric; amount of error to include, from 0 (none) to 100
#'              (full dataset)
#' 
#' 
#' @examples
#' d <- data.frame(x = signif(rnorm(10, mean = 0, sd = 100), digits = 4))
#' d$y <- sampling_error(d$x, error = 50)
#' 
#' @export

sampling_error <- function(var, type = "numeric", error = 5) {
  d <- data.frame(var = var)
  if (type == "numeric") {
    diffs <- c( -1, 0, 1, 5, 10, 100)
    # make error probabilities add up to 1 so total adds up to 100
    probs <- c(.2 * error, 100 - error, .2 * error, .1 * error, 
               .4 * error, .1 * error)
    d <- d |> 
      dplyr::mutate(
        diff = sample(diffs, prob = probs, size = nrow(d), replace = TRUE),
        # change to case/when
        var = dplyr::case_when(
          diff == 0 ~ var,             # keep the same
          abs(diff) == 1 ~ var + diff, # add or subtract 1
          diff %in% c(5, 10) ~ dplyr::case_when(
            # round to nearest 5 or 10
            abs(var) > 1 ~ round(var / diff) * diff,
            # round last significant digit to nearest 5 or 10
            .default = round(var / diff, digits = nchar(gsub("[-0]+\\.", "", 
                                                             var))) * diff),
          diff == 100 ~ dplyr::case_when( # round to 2 significant digits
            abs(var) > 100 ~ signif(var, digits = 2),
            .default = dplyr::case_when(
              var <= -1 ~ as.numeric(paste0("-", 1, round(abs(var), digits = 1))),
              var >= 1 ~ as.numeric(paste0(1, round(abs(var), digits = 1))),
              var < 0 ~ 10^round(log10(abs(var))+1)*(-1) + var,
              var > 0 ~ 10^round(log10(abs(var))) + var,
              .default = 0)),
          .default = 0))
  } else if (type == "character") {
    diffs <- c(0:2)
    probs <- c(100, 10, 10)
    d <- d |> 
      dplyr::mutate(
        diff = sample(diffs, prob = probs, replace = TRUE, report_count),
        var = dplyr::case_when(diff == 0 ~ var,
                               diff == 1 ~ toupper(var),
                               diff == 2 ~ tolower(var),
                               .default = NA)
      )
  }
  # testing: list(var = d$var, diff = d$diff)
  return(d$var)
}
