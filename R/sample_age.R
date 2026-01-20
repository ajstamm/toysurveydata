# hacky workaround for false positive notes
utils::globalVariables(c("start", "end", "id", "age"))


#' Create fictional ages based on birth date and survey date
#'
#' @param start_date date or vector of dates; birth date or other origin date
#' @param end_date   dateor vector of dates; survey date or other completion date
#' @param error      boolean; should errors be included in the ages?
#'
#' @examples
#' sample_age(start_date = "1900-01-01", end_date = "1960-07-31", error = FALSE)
#'
#' @export

sample_age <- function(start_date, end_date = Sys.Date(), error = TRUE) {
  # in R, date origin = "1970-01-01"
  d <- data.frame(start = as.Date(start_date), end = as.Date(end_date))
  d <- dplyr::mutate(d, id = 1:nrow(d),
                     age = lubridate::year(lubridate::as.period(
                           lubridate::interval(start, end))))
  if (error) {
    d <- dplyr::mutate(d,
      diff = sample(c(-1, 0, 1, 5, 10, 100), prob = c(5, 100, 5, 1, 5, .2), 
                    size = nrow(d), replace = TRUE),
      age = ifelse(age < 100, age + diff, age),
      age = ifelse(diff == 10, round(age / 10) * 10, age)) 
  }
  return(d$age)
}
