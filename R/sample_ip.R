#' Create fictional IP addresses
#' 
#' @param count integer; number of responses


sample_ip <- function(count) {
  t <- data.frame(id = 1:count,
                  x1 = sample(1:255, size = count, replace = TRUE), 
                  x2 = sample(0:255, size = count, replace = TRUE),
                  x3 = sample(0:255, size = count, replace = TRUE), 
                  x4 = sample(0:255, size = count, replace = TRUE)) |>
    dplyr::mutate(ip_address = paste(x1, x2, x3, x4, sep = ".")) |>
    dplyr::select(id, ip_address)
  return(t)
}
