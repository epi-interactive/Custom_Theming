##################################
# Created by EPI-interactive
# 17 May 2019
# https://www.epi-interactive.com
##################################

shinyUI(
  tagList(
    bootstrapPage(NULL, theme = "css/bootstrap.min.css"),#forces BS theme and BS JS libraries to lazy load
    icon(NULL, class = NULL, lib = "font-awesome"),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "css/font-awesome.min.css"),
      tags$link(rel = "stylesheet", type = "text/css", href = "css/custom.css"),
      tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css?family=Lato")
    ),
    tags$script(src="js/util.js"),
    tags$script(src='js/fallingsnow_v6.js'),
    div(id="loadingOverlay",
        HTML('<img id="loadingSpinner" src="img/Text_Start.svg"/>')
    ),
    div(id="snowflakeContainer", HTML('<p class="snowflake">*</p>')),
    router_ui(),
    G_cookiesLB,
    G_piesLB,
    G_breadLB,
    G_calendarLB,
    G_pavlovaLB,
    G_presentsLB,
    G_familyLB,
    G_couchLB,
    G_shoppingLB,
    G_chimneyLB
  )
)
