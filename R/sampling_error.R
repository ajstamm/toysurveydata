
utils::globalVariables(c("report_count"))


#' Add sampling data errors
#' 
#' @param var  Vector of values to be modified
#' @param type Type of data in the vector: accepts "character" or "numeric" 
#' 
#' 
#' @examples
#' d <- data.frame(x = signif(rnorm(10000, mean = 0, sd = 100), digits = 4))
#' d$y <- sampling_error(d$x)
#' 
#' @export

sampling_error <- function(var, type = "numeric") {
  d <- data.frame(var = var)
  if (type == "numeric") {
    diffs <- c(-1,   0, 1, 5, 10, 100, 1000)
    probs <- c( 5, 100, 5, 1, 10,  .5,   .1)
    d <- d |> 
      dplyr::mutate(
        diff = sample(diffs, prob = probs, size = nrow(d), replace = TRUE),
        # change to case/when
        var = dplyr::case_when(diff == 0 ~ var, # keep the same
                               # add or subtract 1
                               abs(diff) == 1 ~ var + diff,
                               diff %in% c(5, 10) ~ dplyr::case_when(
                                 # round whole number to nearest 5 or 10
                                 abs(var) > 100 ~ round(var / diff) * diff,
                                 # round first decimal to nearest 5 or 10
                                 abs(var) > 1 ~ round(var / diff, digits = 1) * diff,
                                 # round last significant digit to nearest 5 or 10
                                 .default = round(var / diff, digits = 
                                            nchar(gsub("[-0]+\\.", "", var))) * diff),
                               # round to 2 significant digits
                               diff == 100 ~ signif(var, digits = 2), 
                               # add an extra 1 at the beginning
                               diff == 1000 ~ dplyr::case_when(
                                 var <= -1 ~ as.numeric(paste0("-", 1, round(abs(var), digits = 1))),
                                 var >= 1 ~ as.numeric(paste0(1, round(abs(var), digits = 1))),
                                 var < 0 ~ 10^round(log10(abs(var))+1)*(-1) + var,
                                 var > 0 ~ 10^round(log10(var)) + var,
                                 .default = 0),
                               .default = NA)
      )
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
