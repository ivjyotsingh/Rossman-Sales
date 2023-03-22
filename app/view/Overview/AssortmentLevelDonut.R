box::use(
  app/logic/data
)

box::use(
  shiny[NS,moduleServer],
  dplyr[select,group_by,summarise,n],
  echarts4r[e_charts,e_pie,e_tooltip,e_title,echarts4rOutput,renderEcharts4r]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  
  echarts4rOutput(ns("ald"))
  
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$ald <- renderEcharts4r({
      
        data$fetch_store() |>
        select(Assortment_Level) |>
        dplyr::group_by(Assortment_Level) |>
        summarise(Stores = n()) |>
        e_charts(Assortment_Level) |>
        e_pie(Stores,
              radius = c("20%","50%"),
              startAngle = 180) |>
        e_tooltip() 
      
    })
  })
}