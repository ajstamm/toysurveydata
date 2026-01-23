# create simulated data

# set up ----
# load data settings
data_path <- "archive/AoS_conference_files" # or whatever your path is
report_count <- 200

# read probabilities and functions ----
vars <- readr::read_csv(paste(data_path, "cha_probabilities.csv", sep = "/"))

# change "R" below to your local path
f <- list.files("R", full.names = TRUE)
for (i in f) source(i)

# create toy data ----
l <- list()

  # single column categorical ----
metro <- c("Hennepin", "Ramsey", "Dakota", "Anoka", "Scott", "Carver", "Chisago")
l$select_one <- select_categorical_set(d = vars, count = report_count)

# deliberately add more error
l$select_one <- l$select_one |>
  dplyr::mutate(
    reg_check = sample(0:2, prob = c(50, 10, 1), replace = TRUE, report_count),
    res_region = ifelse(res_county %in% metro, "Urban", "Rural"),
    res_region = dplyr::case_when(is.na(res_county) ~ NA,
                                  reg_check == 0 ~ res_region,
                                  reg_check == 1 ~ "I don't know",
                                  res_region == "Urban" ~ "Rural",
                                  .default = "Urban"),
    res_county = sampling_error(res_county, type = "character")
  ) |> dplyr::select(-reg_check)
  
  
  
  # numeric, IP, and dates ----
c <- select_continuous_set(d = vars, count = report_count) |>
  dplyr::mutate(birth_year = round(birth_year), 
                birth_date = paste0(birth_year, "-01-01"))
d <- select_dates_set(d = vars, count = report_count) 

l$continuous <- dplyr::full_join(c, d, by = "id") |>
  dplyr::mutate(age = sample_age(start_date = c$birth_date, error = TRUE, 
                                 end_date = d$survey_date)) |>
  dplyr::select(-birth_date)

l$ip <- sample_ip(report_count)


  # multi-column categorical ----
l$select_many <- select_many_set(d = vars, count = report_count)

  # text responses ----
hp <- readr::read_csv(paste(data_path, "health_priority_options.csv", 
                            sep = "/")) |> janitor::clean_names()

l$text <- data.frame(id = 1:report_count,
                     temp = sample(1:nrow(hp), size = report_count)) |>
  dplyr::mutate(health_need = hp$health_priority[temp]) |>
  dplyr::select(id, health_need)


# combine everything ----
# purrr::reduce(l, dplyr::bind_cols)
data <- purrr::reduce(l, dplyr::left_join, by = "id") |> 
  dplyr::arrange(id)

# add a duplicate record
t <- data[sample(1:report_count, size = 1),] |>
  dplyr::mutate(id = max(data$id) + 1)

data <- dplyr::bind_rows(data, t) |>
  dplyr::rename(`Response ID` = id, `IP Address` = ip_address,
                `Date Submitted` = survey_date,
                `Doctor's office:care` = care_doc,
                `Emergency room:care` = care_emerg,
                `Other - Write In (Required):care` = care_other,
                `Outpatient clinic:care` = care_clinic,
                `Telehealth:care` = care_tele,
                `Urgent care clinic:care` = care_urgent,
                `American Indian or Alaska Native:race` = race_aian,
                `Asian or Asian American:race` = race_asian,
                `Black or African or African American:race` = race_black,
                `Native Hawaiian or Pacific Islander:race` = race_hawaii,
                `Other - Write In (Required):race` = race_other,
                `Prefer not to say:race` = race_refuse,
                `White:race` = race_white)

# save dataset ----
write.csv(data, paste0(data_path,  "/mock_cha_", Sys.Date(), ".csv"), 
          row.names = FALSE, na = "")

