box::use(
  utils[read.csv]
)

box::use(
  here
)


#' @export
fetch_train <- function(){
  read.csv(here::here("data","train.csv"))
}

#' @export
fetch_test <- function(){
  read.csv(here::here("data","test.csv"))
}

#' @export
fetch_sample <- function(){
  read.csv(here::here("data","sample.csv"))
}

#' @export
fetch_store <- function(){
  read.csv(here::here("data","store.csv"))
}

