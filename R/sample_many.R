# hacky workaround for false positive notes
utils::globalVariables(c("v1", "variable", "temp", "delete"))



#' Calculate multiple booleans
#' 
#' This function provides up to the maximum allowed number of responses. Some 
#' responses will have less and if your "miss_pct" is greater than zero, some 
#' responses will have no selections.
#' 
#' @param var      string; variable name
#' @param d        dataset; contains labels and probabilities
#' @param count    integer; number of responses (rows)
#' 
#' 
#' @examples
#' d <- data.frame(variable = "my_letters", type = "select-many", miss_pct = 10,
#'                 options = letters[1:5], labels = letters[1:5], max_opts = 3,
#'                 probability_1 = 9:5, probability_2 = 1:5)
#' 
#' sample_many(var = "my_letters", d = d, count = 10)
#' 
#' @export

sample_many <- function(var, d, count = 100) {
  d <- dplyr::filter(d, variable == var)
  # if there are issues with percent missingness, assume 0%
  miss_pct = max(d$miss_pct, na.rm = TRUE)
  if (!is.finite(miss_pct) | miss_pct < 0 | miss_pct > 100) miss_pct <- 0
  # if there are issues with max_opts, assume single-selection or "choose all"
  max_opts = max(d$max_opts, na.rm = TRUE)
  if (!is.finite(max_opts) | max_opts < 1) max_opts <- 1
  if (max_opts > nrow(d)) max_opts <- nrow(d)
  # percent missingness is defined only by the first column of selections
  # add missingness row
  t <- data.frame(options = "delete", labels = "", probability_2 = 0,
                  probability_1 = sum(d$probability_1) * miss_pct / 100)
  d <- dplyr::bind_rows(d, t)
  
  t <- data.frame(id = 1:count,
                  v1 = sample_one(d$options, d$probability_1, count)) |>
    dplyr::mutate(v1 = ifelse(is.na(v1) | v1 == "", "delete", v1))
  
  if (max_opts > 1) {
    for (i in 2:max_opts) {
      excludes <- "refuse|other|none|^$"
      t <- dplyr::mutate(t, temp = sample_one(d$options, d$probability_2, count),
                         temp = ifelse(grepl(excludes, v1) | v1 == temp |  
                                         grepl(excludes, temp) | is.na(temp), 
                                       "delete", temp),
                         !!dplyr::sym(paste0("v", i)) := temp)
    }
  }
  
  calc_lbl <- function(v1, v2) {
    var <- ifelse(!is.na(v2) & !v2 == "", v2, v1)
    return(var)
  }
  
  lbl <- data.frame(var = d$options, lbl = d$labels)
  tt <- dplyr::select(t, id, var = v1) |> dplyr::left_join(lbl, by = "var") |>
    dplyr::mutate(lbl = ifelse(is.na(lbl) | lbl == "", "delete", lbl))
  tp <- tidyr::pivot_wider(tt, names_from = "var", values_from = "lbl") 
  
  if ("delete" %in% names(tp)) tp <- dplyr::select(tp, -delete)
  
  if (max_opts > 1) {
    for (i in 2:max_opts) {
      var_name <- paste0("v", i)
      tt <- dplyr::select(t, id, var = !!dplyr::sym(var_name)) |> 
        dplyr::left_join(lbl, by = "var") |>
        dplyr::mutate(lbl = ifelse(is.na(lbl) | lbl == "", "delete", lbl))
      tp_t <- tidyr::pivot_wider(tt, names_from = "var", values_from = "lbl") |>
        dplyr::select(-dplyr::contains("delete"))
      
      tp <- dplyr::full_join(tp, tp_t, by = "id") 
      
      vars <- names(tp)
      vars <- vars[grepl(".x", vars)]
      vars <- gsub(".x", "", vars)
      
      for (i in vars) {
        tp <- dplyr::mutate(tp, !!dplyr::sym(i) := 
                              calc_lbl(!!dplyr::sym(paste0(i, ".x")), 
                                       !!dplyr::sym(paste0(i, ".y"))))
      }
      
      tp <- dplyr::select(tp, -dplyr::ends_with(".x"), -dplyr::ends_with(".y"))
    }
  }
  
  return(tp)
}
