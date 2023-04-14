box::use(
  app/logic/data
)

box::use(
  app/view/StoreProfile/Cards
)

box::use(
  shiny[NS,tabPanel,fluidRow,moduleServer,column,textOutput,renderPrint,
        reactive],
  dplyr[filter,select,pull],
  echarts4r[renderEcharts4r,echarts4rOutput,group_by,e_charts,e_line,e_tooltip,
            e_show_loading,e_axis_labels,e_legend,e_theme,e_toolbox_feature]
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
             ),
             column(3,
                    Cards$card2("Competition Info.",
                                textOutput(ns("compinfo")))
                    ),
             column(3,
                    Cards$card2("Promo Info.",
                                textOutput(ns("promoinfo")))
                    )
           ),
           fluidRow(
             column(12,
             Cards$card3("Sales and Customers",
                         echarts4rOutput(ns("salcust")))
             )
           )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    info <- reactive({
      
      data$fetch_store() |>
      filter(Store == input$store_select)
    
    })
      
    output$storeinfo <- renderPrint({
      
        info() |>
        select(StoreType) |>
        pull() -> type
      
        info() |>
        select(Assortment) |>
        pull() -> assort
      
      cat("The Store Model is",type,"and Assortment Level is",assort)
      
    })
    
    output$compinfo <- renderPrint({
      
        info() |>
        select(CompetitionDistance) |>
        pull() -> cdist
      
        info() |>
        select(CompetitionOpenSinceMonth) |>
        pull() -> cmonth
        
        info() |>
        select(CompetitionOpenSinceYear) |>
        pull() -> cyear
      
        cat("Nearest competing store is",cdist," metres away. It opened in the", cmonth,"th month of",cyear,".")

    })
    
    output$promoinfo <- renderPrint({
      
        info() |>
        select(Promo2) |>
        pull() |>
        as.numeric() -> promo
      
        info() |>
        select(Promo2SinceWeek) |>
        pull() -> pweek
      
        info() |>
        select(Promo2SinceYear) |>
        pull() -> pyear
      
        info() |>
        select(PromoInterval) |>
        pull() -> pint
      
      if(promo == 0){
        
        cat("Second Promo is not applied to this store.")
        
      }
  
      if(promo == 1) {
        
        cat("Second Promo started in",pweek,"th week of",pyear,". It is applied only in",pint,".")
        
      }
      
    })
    
    output$salcust <- renderEcharts4r ({
      
        data$fetch_SalCust() |>
        filter(Store == input$store_select) |>
        echarts4r::group_by(Year) |>
        e_charts(Date,timeline = TRUE) |>
        e_line(Sales,
               symbol = "circle") |>
        e_line(Customers,
               y_index = 1,
               symbol = "circle") |>
        e_show_loading() |>
        e_tooltip(trigger = "axis") |>
        e_legend(left = 0) |>
        e_theme("westeros")|>
        e_toolbox_feature(
          feature = c("saveAsImage",
                      "dataZoom")
        )
    })
    
  })
}
