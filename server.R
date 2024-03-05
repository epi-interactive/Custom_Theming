##################################
# Created by EPI-interactive
# 17 May 2019
# https://www.epi-interactive.com
##################################

routes <- c(
  route("/home", pageSplashUI("splash")),
  route("/app", pageAppUI("app"))
)

shinyServer(function(input, output, session) {
  router <- make_router(
    routes
  )

  callModule(pageApp, "app")
  
  router(input, output)
  
})
