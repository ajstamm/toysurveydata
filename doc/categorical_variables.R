## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", 
                      message = FALSE, warning = FALSE)
devtools::load_all("../R")

## ----table_function, include=FALSE--------------------------------------------
plot_table <- function(df, caption = "") {
  if (nrow(df) < 6) {
    base_options <- list(dom = 't', ordering = FALSE)
  } else {
    base_options <- list(ordering = TRUE, scrollX = TRUE, searching = TRUE, 
                         pageLength = 5, paging = TRUE, 
                         lengthMenu = list(c(5, 10, 25, 50, -1), 
                                           c('5', '10', '25', '50', 'All')))
  }
  dt <- DT::datatable(df, selection = "none", class = 'cell-border stripe',
                      escape = FALSE, rownames = FALSE, options = base_options,
                      caption = caption)
  return(dt)
}

## ----set_categorical_one------------------------------------------------------
gender_opts <- data.frame(
  variable = "gender", 
  type = "select-one", 
  options = c("Female", "Male", "Other", "Prefer not to say"),
  probability_1 = c(50, 50, 5, 5),
  miss_pct = 10 
)

## ----make_categorical_one-----------------------------------------------------
gender_resp <- select_categorical_set(d = gender_opts, count = 20)

## ----set_categorical_many-----------------------------------------------------
seek_care_opts <- data.frame(
  variable = "seek_care", 
  type = "select-many", 
  options = c("care_doc", "care_clinic", "care_emerg", 
              "care_tele", "care_urgent", "care_other", "care_none"), 
  labels = c("Doctor's office", "Outpatient clinic", "Emergency room", 
             "Telehealth", "Urgent care clinic", "Other", "Do not seek care"),
  probability_1 = c(90, 5, 1, 2, 3, 1, 1), 
  probability_2 = c( 0, 5, 1, 2, 3, 1, 0), 
  max_opts = 3, 
  miss_pct = 0
)

## ----make_categorical_many----------------------------------------------------
seek_care_resp <- select_many_set(d = seek_care_opts, count = 20)

## ----combine_data-------------------------------------------------------------
resps <- list(gender_resp, seek_care_resp)
full_data <- purrr::reduce(resps, dplyr::left_join, by = "id") |> 
  dplyr::arrange(id)

