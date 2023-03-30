box::use(
  shiny[navbarPage,moduleServer,NS],
  bslib[bs_theme,bs_themer],
  thematic[thematic_shiny]
)

box::use(
  app/view/StoreProfile/spTab,
  app/view/Overview/oTab,
  app/view/PromoImpact/piTab
)


#' @export
ui <- function(id) {
  thematic::thematic_shiny()
  ns <- NS(id)
    navbarPage(
    "Rossman",
    theme = bs_theme(bootswatch = "zephyr"),
    oTab$ui(ns("otab")),
    spTab$ui(ns("sptab")),
    piTab$ui(ns("pitab"))
    )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    spTab$server("sptab")
    oTab$server("otab")
    piTab$server("pitab")
  })
}
