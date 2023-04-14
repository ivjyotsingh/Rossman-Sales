box::use(
  bslib[card,card_header,card_body,card_body_fill]
)

box::use(
  app/view/Controls/StoreSelector
)


#' @export
card1 <- function(storeargument){
  
  card(
    height = 180,
    card_header("Control"),
    card_body_fill(StoreSelector$storeselector(storeargument))
  )
}


#' @export
card2 <- function(titleArg,textArg){
  
  card(
    height = 180,
    card_header(titleArg),
    card_body(textArg)
  )
}

#' @export
card3 <- function(titleArg,plotArg){
  
  card(
    height = 400,
    full_screen = TRUE,
    card_header(titleArg),
    card_body_fill(plotArg)
  )
}

