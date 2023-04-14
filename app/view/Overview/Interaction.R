box::use(
  app/logic/data
)

box::use(
  shiny[NS,moduleServer],
  dplyr[select,group_by,summarise,n],
  echarts4r[group_by,e_charts,e_bar,e_facet,e_tooltip,
            echarts4rOutput,renderEcharts4r,e_theme,
            e_group,e_connect_group,e_toolbox_feature]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  
  echarts4rOutput(ns("int"))
  
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$int <- renderEcharts4r({
      
        data$fetch_store() |>
        select(Assortment_Level,Store_Model) |>
        dplyr::group_by(Assortment_Level,Store_Model) |>
        summarise(Stores = n(),.groups = "drop") |>
        echarts4r::group_by(Store_Model) |>
        e_charts(Assortment_Level) |>
        e_bar(Stores) |>
        e_facet(rows = 2,cols = 2,legend_pos = "top") |>
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