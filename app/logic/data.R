box::use(
  readr[read_csv],
  here,
  dplyr[mutate],
  lubridate[year,wday]
)

#' @export
fetch_train <- function(){
  train <- read_csv(here::here("data","train.csv"),show_col_types = FALSE,progress = FALSE)
  train <- train[order(as.Date(train$Date, format="%Y-%m-%d")),]
  train |>
    mutate(Year = year(Date)) |>
    mutate(Day = wday(Date,label = TRUE,abbr = TRUE)) -> train
  train
}

#' @export
fetch_test <- function(){
  test <- read_csv(here::here("data","test.csv"),show_col_types = FALSE,progress = FALSE)
  test <- test[order(as.Date(test$Date, format="%Y-%m-%d")),]
  test
}

#' @export
fetch_sample <- function(){
  read_csv(here::here("data","sample.csv"),show_col_types = FALSE,progress = FALSE)
}

#' @export
fetch_store <- function(){
  read_csv(here::here("data","store.csv"),show_col_types = FALSE,progress = FALSE)
}

