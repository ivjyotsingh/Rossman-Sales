box::use(
  shiny[selectInput]
)

#' @export
monthselector <- function(monthargument){
  
  selectInput(inputId = monthargument,
              "Select a Month",
              choices = c(1,2,3,4,5,
                          6,7,8,9,10,
                          11,12),
              selected = 1
  )
  
}

