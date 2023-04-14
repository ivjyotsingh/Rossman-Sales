box::use(
  app/view/Overview/Cards,
  app/view/Overview/StoreModelDonut,
  app/view/Overview/AssortmentLevelDonut,
  app/view/Overview/Interaction
)

box::use(
  shiny[NS,moduleServer,tabPanel,fluidRow,column],
  bslib[card,card_header,card_body_fill]
)




#' @export
ui <- function(id) {
  ns <- NS(id)
 
  tabPanel("Overview",
           fluidRow(
                    column(3,
                           Cards$card1()),
                    column(3,
                           Cards$card2()),
                    column(3,
                           Cards$card3()),
                    column(3,
                           Cards$card4())
           ),
           fluidRow(
                    column(3,
                           card(
                             height = 480,
                             full_screen = TRUE,
                             card_header("Store Models"),
                             card_body_fill(StoreModelDonut$ui(ns("smd")))
                           )),
                    column(3,
                           card(
                             height = 480,
                             full_screen = TRUE,
                             card_header("Assortment Levels"),
                             card_body_fill(AssortmentLevelDonut$ui(ns("ald")))
                           )),
                    column(6,
                           card(
                           height = 480,
                           full_screen = TRUE,
                           card_header("Interaction between Store Models and Assortment Levels"),
                           card_body_fill(Interaction$ui(ns("int")))
                           ))
           )
  )
   
}


#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
  
    StoreModelDonut$server("smd")
    AssortmentLevelDonut$server("ald")
    Interaction$server("int")
  })
}