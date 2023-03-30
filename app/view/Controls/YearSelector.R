box::use(
  shiny[selectInput]
)

#' @export
yearselector <- function(yearargument){
  
  selectInput(inputId = yearargument,
              "Select a Year",
              choices = c(2013,2014,2015),
              selected = 1
              )
  
}

