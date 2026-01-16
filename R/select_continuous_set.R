#' Create a set of single-selection continuous variables
#' 
#' @param d     dataset containing variable details
#' @param count integer; number of responses (rows)
#' 
#' @examples
#' d <- data.frame(type = "normal", variable = "my_numbers", miss_pct = 10,
#'                 min_val = 0,	max_val = 100, mean_val = 75,	sd_val = 10)
#' 
#' select_continuous_set(d, count = 10)
#' 
#' @export

select_continuous_set <- function(d, count) {
  dt <- unique(d$variable[which(d$type == "normal")])
  
  if (length(dt) > 0) {
    l <- data.frame(id = 1:count)
    
    for (i in dt) {
      t <- dplyr::filter(d, variable == i)
      l$temp <- round(truncnorm::rtruncnorm(n = count, 
                                            a = t$min_val, b = t$max_val, 
                                            sd = t$sd_val, mean = t$mean_val),
                      digits = 2)
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
