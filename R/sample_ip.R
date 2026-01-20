# hacky workaround for false positive notes
utils::globalVariables(c("x1", "x2", "x3", "x4", "id", "ip_address"))


#' Create fictional IP addresses
#' 
#' @param count integer; number of responses
#' 
#' @examples
#' sample_ip(count = 5)
#' 
#' @export

sample_ip <- function(count) {
  x1 = sample(1:255, size = count, replace = TRUE)
  x2 = sample(0:255, size = count, replace = TRUE)
  x3 = sample(0:255, size = count, replace = TRUE)
  x4 = sample(0:255, size = count, replace = TRUE)
  
  t <- data.frame(id = 1:count, x1 = x1, x2 = x2, x3 = x3, x4 = x4)
  t <- dplyr::mutate(t, ip_address = paste(x1, x2, x3, x4, sep = "."))
  t <- dplyr::select(t, id, ip_address)

  return(t)
}
