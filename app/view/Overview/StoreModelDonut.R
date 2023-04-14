box::use(
  app/logic/data
)

box::use(
  shiny[NS,moduleServer],
  dplyr[select,group_by,summarise,n],
  echarts4r[e_charts,e_pie,e_tooltip,e_title,echarts4rOutput,renderEcharts4r,
            e_theme,e_group,e_connect_group,e_toolbox_feature]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  
  echarts4rOutput(ns("smd"))
  
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$smd <- renderEcharts4r({
    
      data$fetch_store() |>
      select(Store_Model) |>
      dplyr::group_by(Store_Model) |>
      summarise(Stores = n()) |>
      e_charts(Store_Model) |>
      e_pie(Stores,
            radius = c("20%","50%")) |>
      e_tooltip(trigger = "item") |>
      e_theme("westeros") |>
      e_group("grp") |>
      e_connect_group("grp") |>
      e_toolbox_feature(
        feature = "saveAsImage"
      )
    
      })
  })
}