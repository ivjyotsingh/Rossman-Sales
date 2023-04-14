box::use(
  app/view/Controls/StoreSelector,
  app/view/Controls/YearSelector,
  app/view/Controls/MonthSelector
)

box::use(
  app/logic/data
)

box::use(
  shiny[NS,tabPanel,fluidRow,column,uiOutput,moduleServer,renderUI,
        reactive,selectInput],
  bslib[card,card_header,card_body_fill,navs_tab_card,nav,card_title],
  dplyr[filter,select,pull],
  echarts4r[e_charts,e_calendar,e_heatmap,e_visual_map,echarts4rOutput,
            renderEcharts4r,e_theme,e_tooltip,e_show_loading,e_toolbox_feature]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  
  tabPanel("Promo Effect",
           fluidRow(
             column(3,
                    card(
                      height = 500,
                      card_header("Controls"),
                      card_body_fill(StoreSelector$storeselector(ns("store_select")),
                                     YearSelector$yearselector(ns("year_select")),
                                     MonthSelector$monthselector(ns("month_select")))
                    )
                 ),
             column(4,
                    navs_tab_card(
                      height = 500,full_screen = TRUE,
                      title = "Independent Variables",
                      nav(
                        "Promo",
                        card_title("Days with Promo applied"),
                        card_body_fill(echarts4rOutput(ns("PromoCal")))
                      ),
                      nav(
                        "School Holidays",
                        card_title("Days with School Holidays"),
                        card_body_fill(echarts4rOutput(ns("SchoolCal")))
                      )
                    )
                  ),
             column(4,
                    navs_tab_card(
                      height = 500,full_screen = TRUE,
                      title = "Dependent Variables",
                      nav(
                        "Sales",
                        card_title("Total Sales"),
                        card_body_fill(echarts4rOutput(ns("SalesCal")))
                      ),
                      nav(
                        "Customers",
                        card_title("Footfall in the store"),
                        card_body_fill(echarts4rOutput(ns("CustCal")))
                      )
                    )
                  )
              )
           )
  
  
}


#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
  
    
    selection <- reactive({
    
    data$fetch_train() |>
    filter(Store == input$store_select &
           Year == input$year_select &
           Month == input$month_select) 
      
    })
      
    rangeval <- reactive({
      
      paste(input$year_select,input$month_select,sep = "-")
      
    })
    
    maxSval <- reactive({
      
      selection() |>
      select(Sales) |>
      max()
      
    })
    
    maxCval <- reactive({
      
        selection() |>
        select(Customers) |>
        max()
      
    })
    
       
    output$SalesCal <-  renderEcharts4r({
      
      selection() |>
      select(Date,Sales) |>
      e_charts(Date) |>
      e_calendar(range = rangeval(),
                 cellSize = 35,
                 orient = "vertical",
                 yearLabel = list(
                   margin = 40
                 ),
                 dayLabel = list(
                   fontSize = 12,
                   color = "white"
                 ),
                 monthLabel = list(
                   color = "white"
                 )) |>
        e_heatmap(Sales,coord_system = "calendar")|> 
        e_visual_map(max = maxSval()
                    )|>
        e_theme("westeros") |>
        e_tooltip(trigger = "item") |>
        e_show_loading()|>
        e_toolbox_feature(
          feature = "saveAsImage"
        )
      
      
    })
       
    
    output$CustCal <-  renderEcharts4r({
      
      selection() |>
        select(Date,Customers) |>
        e_charts(Date) |>
        e_calendar(range = rangeval(),
                   cellSize = 35,
                   orient = "vertical",
                   yearLabel = list(
                     margin = 40
                   ),
                   dayLabel = list(
                     fontSize = 12,
                     color = "white"
                   ),
                   monthLabel = list(
                     color = "white"
                   )) |>
        e_heatmap(Customers,coord_system = "calendar")|> 
        e_visual_map(max = maxCval()
                     )|>
        e_theme("westeros")|>
        e_tooltip(trigger = "item")|>
        e_show_loading()|>
        e_toolbox_feature(
          feature = "saveAsImage"
        )
      
      
    })
    
    output$PromoCal <-  renderEcharts4r({
      
      selection() |>
        select(Date,Promo) |>
        e_charts(Date) |>
        e_calendar(range = rangeval(),
                   cellSize = 35,
                   orient = "vertical",
                   yearLabel = list(
                     margin = 40
                   ),
                   dayLabel = list(
                     fontSize = 12,
                     color = "white"
                   ),
                   monthLabel = list(
                     color = "white"
                   )) |>
        e_heatmap(Promo,coord_system = "calendar")|> 
        e_visual_map(max = 1
                     )|>
        e_theme("westeros")|>
        e_tooltip(trigger = "item")|>
        e_show_loading()|>
        e_toolbox_feature(
          feature = "saveAsImage"
        )
      
      
    })
    
    output$SchoolCal <-  renderEcharts4r({
      
      selection() |>
        select(Date,SchoolHoliday) |>
        e_charts(Date) |>
        e_calendar(range = rangeval(),
                   cellSize = 35,
                   orient = "vertical",
                   yearLabel = list(
                     margin = 40
                   ),
                   dayLabel = list(
                     fontSize = 12,
                     color = "white"
                   ),
                   monthLabel = list(
                     color = "white"
                   )) |>
        e_heatmap(SchoolHoliday,coord_system = "calendar")|> 
        e_visual_map(max = 1
                     )|>
        e_theme("westeros")|>
        e_tooltip(trigger = "item")|>
        e_show_loading()|>
        e_toolbox_feature(
          feature = "saveAsImage"
        )
      
      
    })
    
    
    
    })
    
    
    
    
  
}