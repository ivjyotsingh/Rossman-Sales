box::use(
  shiny[navbarPage,moduleServer,NS],
  bslib[bs_theme,bs_themer],
  thematic[thematic_shiny]
)

box::use(
  app/view/StoreProfile/spTab
)


#' @export
ui <- function(id) {
  thematic::thematic_shiny()
  ns <- NS(id)
    navbarPage(
    "Rossman",
    theme = bs_theme(bootswatch = "zephyr"),
    spTab$ui(ns("sptab"))
    )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    spTab$server("sptab")
  })
}
