##################################
# Created by EPI-interactive
# 17 May 2019
# https://www.epi-interactive.com
##################################

pageSplashUI <- function(id) {
 div(class="main",
     div(class="splash-container", 
       div(class="splash-text",
           tags$h1("Too many"),
           tags$h1("Christmas treats?"),
           tags$h1("Wondering how to work them off?")
           ),
         div(class="launch", tags$a(href="#!/app", tags$h1("Enter here to find out!")))
     ),
     div(class="footer",
         tags$img(class="right", src="img/merry_christmas_epi.png")
     )
 )
}
