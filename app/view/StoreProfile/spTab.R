box::use(
  app/logic/data
)

box::use(
  app/view/StoreProfile/Cards
)

box::use(
  shiny[NS,tabPanel,fluidRow,moduleServer,column,textOutput,renderPrint],
  dplyr[filter,select,pull]
)


#' @export
ui <- function(id) {
  ns <- NS(id)
  
  tabPanel("Store Profile",
           fluidRow(
             column(3,
                    Cards$card1(ns("store_select"))
             ),
             column(3,
                    Cards$card2("Store Info.",
                                textOutput(ns("storeinfo")))
             )
           )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$storeinfo <- renderPrint({
      
      data$fetch_store() |>
        filter(Store == input$store_select) |>
        select(StoreType) |>
        pull() -> type
      
      data$fetch_store() |>
        filter(Store == input$store_select) |>
        select(Assortment) |>
        pull() -> assort
      
      cat("StoreType:",type,"\n Assortment:",assort)
      
      
    })
    
    
  })
}
