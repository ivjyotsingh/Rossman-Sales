box::use(
  bslib[value_box],
  bsicons[bs_icon]
)

#' @export
card1 <- function(){
  
  value_box(
    title = "Store Models",
    value = "4",
    showcase = bs_icon("shop")
  )
  
}

#' @export
card2 <- function(){
  
  value_box(
    title = "Assortment Levels",
    value = "3",
    showcase = bs_icon("shop")
  )
  
}

#' @export
card3 <- function(){
  
  
  value_box(
    title = "Total Stores",
    value = "1115",
    showcase = bs_icon("globe-europe-africa")
  )
} 

#' @export
card4 <- function(){
  
  
  value_box(
    title = "Stores with Promo",
    value = "571",
    showcase = bs_icon("globe-europe-africa")
  )
} 
