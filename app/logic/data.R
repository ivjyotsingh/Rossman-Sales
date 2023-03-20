box::use(
  utils[read.csv],
  here,
  dplyr[mutate],
  lubridate[year,wday]
)



#' @export
fetch_train <- function(){
  train <- read.csv(here::here("data","train.csv"))
  train <- train[order(as.Date(train$Date, format="%Y-%m-%d")),]
  train |>
    mutate(Year = year(Date)) |>
    mutate(Day = wday(Date,label = TRUE,abbr = TRUE)) -> train
  train
}

#' @export
fetch_test <- function(){
  test <- read.csv(here::here("data","test.csv"))
  test <- test[order(as.Date(test$Date, format="%Y-%m-%d")),]
  test
}

#' @export
fetch_sample <- function(){
  read.csv(here::here("data","sample.csv"))
}

#' @export
fetch_store <- function(){
  read.csv(here::here("data","store.csv"))
}

