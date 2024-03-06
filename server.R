##################################
# Created by EPI-interactive
# 17 May 2019
# https://www.epi-interactive.com
##################################

shinyServer(function(input, output, session) {
    callModule(pageApp, "app")
  
    router$server(input, output, session)
  
})
