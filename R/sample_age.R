sample_age <- function(start_date, end_date = Sys.Date(), error = TRUE) {
  # in R, date origin = "1970-01-01"
  d <- data.frame(id = 1:length(start_date),
                  start = as.Date(start_date), 
                  end = as.Date(end_date)) |>
    dplyr::mutate(age = lubridate::year(lubridate::as.period(
      lubridate::interval(start, end))))
  if (error) {
    d <- d |> dplyr::mutate(
      diff = sample(c(-1, 0, 1, 5, 10, 100), prob = c(5, 100, 5, 1, 5, .2), 
                    size = length(start_date), replace = TRUE),
      age = ifelse(age < 100, age + diff, age),
      age = ifelse(diff == 10, round(age / 10) * 10, age)) 
    
  }
  return(d$age)
}
