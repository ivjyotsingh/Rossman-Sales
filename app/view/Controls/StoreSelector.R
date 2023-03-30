box::use(
  shiny[numericInput]
)

#' @export
storeselector <- function(storeargument){
  
  numericInput(inputId = storeargument,
               "Select a Store",
               value = 1,
               min = 1,
               max = 1115
  )
  
}