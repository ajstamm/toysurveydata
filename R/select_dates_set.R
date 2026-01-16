#' Create a set of single-selection date variables
#' 
#' @param d     dataset containing variable details
#' @param count integer; number of responses (rows)
#' 
#' @examples
#' d <- data.frame(variable = "my_dates", type = "date", miss_pct = 10,
#'                 min_val = "6/1/2025",	max_val = "8/31/2025")
#' 
#' select_dates_set(d, count = 10)
#' 
#' @export


select_dates_set <- function(d, count) {
  dt <- unique(d$variable[which(d$type == "date")])
  
  if (length(dt) > 0) {
    l <- data.frame(id = 1:count)
    
    for (i in dt) {
      t <- dplyr::filter(d, variable == i)
      dates <- as.Date(t$min_val, format = "%m/%d/%Y"):
        as.Date(t$max_val, format = "%m/%d/%Y")
      l$temp <- sample(dates, size = count, replace = TRUE)
      l$temp <- as.Date(l$temp, format = "%Y-%m-%d", origin = "1970-01-01")
      
      miss_pct = max(t$miss_pct, na.rm = TRUE)
      if (!is.finite(miss_pct) | miss_pct < 0 | miss_pct > 100) miss_pct <- 0
      if (miss_pct > 0) {
        missings <- round(count * miss_pct / 100)
        x <- sample(c(l$id, rep(NA, missings)), size = missings)
        l$temp[x[!is.na(x)]] <- NA
      }
      
      l <- dplyr::rename(l, !!dplyr::sym(i) := temp)
    }
  } else l <- NULL
  
  return(l)
}
