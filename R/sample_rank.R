# hacky workaround for false positive notes
# check rank, opt, id
utils::globalVariables(c("rank_1", "variable", "temp", "delete"))

#' Calculate multiple booleans
#' 
#' This function provides up to the maximum allowed number of responses. Some 
#' responses will have less and if your "miss_pct" is greater than zero, some 
#' responses will have no selections.
#' 
#' @param var      string; variable name
#' @param d        dataset; contains labels and probabilities
#' @param count    integer; number of responses (rows)
#' @param rank_as  string; whether rank is the variable name ("variable") 
#'                 or value ("value")
#' 
#' 
#' @examples
#' d <- data.frame(variable = "my_letters", type = "select-many", miss_pct = 10,
#'                 options = letters[1:5], labels = letters[1:5], max_opts = 3,
#'                 probability_1 = 9:5, probability_2 = 1:5)
# d <- data.frame(variable = "my_letters", type = "select-many", miss_pct = 10,
#                 options = c("a; b; c", "d; e", "g"), max_opts = 3,
#                 labels = c("aa; bb; cc", "dd; ee", "gg"),
#                 probability_1 = 9:7, probability_2 = 3:5)
#' sample_rank(var = "my_letters", d = d, count = 10, rank_as = "value")
#' sample_rank(var = "my_letters", d = d, count = 10, rank_as = "variable")
#' 
#' @export

sample_rank <- function(var, d, count = 100, rank_as = "value") {
  d <- dplyr::filter(d, variable == var)
  # if there are issues with percent missingness, assume 0%
  # percent missingness is defined only by the first column of selections
  # add missingness row
  miss_pct = max(d$miss_pct, na.rm = TRUE)
  if (!is.finite(miss_pct) | miss_pct < 0 | miss_pct > 100) miss_pct <- 0
  # if there are issues with max_opts, assume single-selection or "choose all"
  max_opts = max(d$max_opts, na.rm = TRUE)
  if (!is.finite(max_opts) | max_opts < 1) max_opts <- 1
  if (max_opts > nrow(d)) max_opts <- nrow(d)

  if(!"labels" %in% names(d)) d$labels <- NA
  d <- d |>
    dplyr::mutate(labels = ifelse(is.na(labels), options, labels),
                  options = strsplit(options, ";"),
                  labels = strsplit(as.character(labels), ";")) |>
    tidyr::unnest(c(options, labels)) |>
    dplyr::mutate(options = trimws(options), 
                  labels = trimws(labels))
  
  t <- data.frame(options = NA, labels = "", probability_2 = 0,
                  probability_1 = sum(d$probability_1) * miss_pct / 100)
  dt <- dplyr::bind_rows(d, t)
  
  # rank as variable name or as value?
  # if as variable name (rank_1), use label
  # if as value (1), use option
  if (rank_as == "value") {
    dr <- data.frame(id = 1:count,
                     rank_1 = sample_one(dt$options, dt$probability_1, count,
                                         miss_pct)) 
    if (max_opts > 1) {
      for (i in 2:max_opts) {
        excludes <- "refuse|other|none|^$"
        ranks <- names(dr)[grepl("rank_", names(dr))]
        dr <- dplyr::rowwise(dr) |>
          dplyr::mutate(remove = paste(dplyr::across(all_of(ranks)), 
                                       collapse = "|")) 
        dr <- dr |>
          dplyr::mutate(
            temp = sample_one(dt$options[!grepl(remove, dt$options)], 
                              dt$probability_2[!grepl(remove, dt$options)],
                              count = 1, miss_pct = 0),
            temp = ifelse(grepl(excludes, rank_1) | is.na(rank_1), NA, temp),
            !!dplyr::sym(paste0("rank_", i)) := temp)
      }
      dr <- dplyr::select(dr, -remove, -temp)
    }
    dr <- tidyr::pivot_longer(dr, -id, names_to = "rank", values_to = "opt") |>
      dplyr::mutate(rank = ifelse(is.na(opt), NA, gsub("rank_", "", rank))) |>
      unique() |> 
      tidyr::pivot_wider(names_from = "opt", values_from = "rank")
    if ("`NA`" %in% names(dr)) dr <- dplyr::select(dr, -`NA`)
  } else {
    dr <- data.frame(id = 1:count,
                     rank_1 = sample_one(dt$labels, dt$probability_1, count,
                                         miss_pct)) 
    if (max_opts > 1) {
      for (i in 2:max_opts) {
        excludes <- "refuse|other|none|^$"
        ranks <- names(dr)[grepl("rank_", names(dr))]
        dr <- dplyr::rowwise(dr) |>
          dplyr::mutate(remove = paste(dplyr::across(all_of(ranks)), 
                                       collapse = "|")) 
        dr <- dr |>
          dplyr::mutate(
            temp = sample_one(dt$labels[!grepl(remove, dt$labels)], 
                              dt$probability_2[!grepl(remove, dt$labels)],
                              count = 1, miss_pct = 0),
            temp = ifelse(grepl(excludes, rank_1) | is.na(rank_1), NA, temp),
            !!dplyr::sym(paste0("rank_", i)) := temp)
      }
      dr <- dplyr::select(dr, -remove, -temp)
    }
  }
  return(dr)
}
