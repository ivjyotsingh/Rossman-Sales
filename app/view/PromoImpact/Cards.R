box::use(
  bslib[card,card_header,card_body,card_body_fill]
)



#' @export
card1 <- function(headerArg,storeargument){
  
  card(
    height = 350,
    card_header(""),
    card_body_fill()
  )
}

