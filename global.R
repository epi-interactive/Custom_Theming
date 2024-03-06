##################################
# Created by EPI-interactive
# 17 May 2019
# https://www.epi-interactive.com
##################################

library(shiny)
library(shiny.router)
library(stringr)
library(plotly)
library(shiny)
library(shinyBS)

source("source/pages/app_ui.R")
source("source/pages/app_server.R")
source("source/pages/splash.R")

lightboxBtn <- function(id, item){
  htmltools::tagAppendAttributes(item,
                                 'data-toggle'="modal",
                                 'data-target'=paste0("#",id))
}

lightboxBody <- function(id, title,svgName, description, calories){
  div(class="modal fade", id=id, tabindex="-1", role="dialog",
      div(class="modal-dialog modal-lg", role="document",
          div(class="modal-content",
              div(class="modal-header",
                  HTML('<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"> &#x2715;</span></button>')
              ),
              div(class="topic-overview-binding modal-body row",
                  tags$h2(title), 
                  tags$img(class="col-sm-3", src=paste0("img/Icons/",svgName,".svg")),
                  div(class="col-sm-9",
                      tags$p(description),
                      tags$p(class="col-sm-12", tags$strong(calories))
                  ) 
              ),
              div(class="modal-footer")
          )
      )
  )
}

createFilterPanel <- function(id, title, ...){
    div(class="panel filter-panel sidebar-underline", id=paste0("sub-filter-area-",id),
        div(class="filter-title",
            'data-toggle'="collapse", 'data-target'=paste0("#", id),  'href'=paste0("#", id), 
            div(class="col-sm-offset-1", HTML(title))
        ),
        div(class="col-sm-offset-1 filter-body collapse in", id=id,
            tagList(...)
        )
    )
}

routes <- c(
    route("", pageSplashUI("splash")),
    route("app", pageAppUI("app"))
)
router <- make_router(routes)

G_cookiesLB <-  lightboxBody("cookies",
                             title="Chocolate chip cookie",
                             svgName="Treat_cookies", 
                             description="The chocolate chip cookie is a treat that is baked and enjoyed throughout the world. Originating in the United States in 1938, this treat now has many variations and unique recipes that make every chocolate chip cookie a little bit different.",
                             calories="Calories per cookie: 75"
                             )
  
G_piesLB <-     lightboxBody("pies",
                             title="Mince pies",
                             svgName="Treat_pies", 
                             description="The original mince pies were created when Middle Eastern methods of cooking were brought back to Britain. The original mice pies contained a mixture of minced meat, suet, a range of fruits, and spices such as cinnamon, cloves and nutmeg. Modern mince pies rarely contain meat and are enjoyed by much of the English-speaking world.",
                             calories="Calories per pie: 350")

G_breadLB <-    lightboxBody("bread",
                             title="Gingerbread",
                             svgName="Treat_bread", 
                             description="The term 'Gingerbread' can cover a large range of baked goods, from cakes to crunchy biscuits. Gingerbread has been used as a building block of baking, from creating little gingerbread men, to designing elaborate gingerbread houses.",
                             calories="Calories per piece: 160")

G_calendarLB <- lightboxBody("calendar",
                             title="Advent calendar chocolates",
                             svgName="Treat_calendar", 
                             description="The advent calendar was first used in the 19th century when German's made chalk marks on doors or lit candles to count down to Christmas. Modern advent calendars tend to be a bit tastier, with a piece of chocolate hiding behind 24 cardboard doors in the lead up to Christmas.",
                             calories="Calories per piece: 15")
  
G_pavlovaLB <-  lightboxBody("pavlova",
                             title="Pavlova",
                             svgName="Treat_pavlova", 
                             description="Pavlova is thought to be created in honour of ballerina Anna Pavlova, when she toured Australia and New Zealand in the 1920's. It has been hotly debated for years as to whether the dish originated in Australia or New Zealand. Regardless, the meringue-based dish is now a staple Christmas food in both countries.",
                             calories="Calories per cookie: 100")
 
G_presentsLB <- lightboxBody("presents",
                             title="Unwrapping presents",
                             svgName="Exercise_presents", 
                             description="Make sure to be up nice and early on Christmas morning for this exercise. Unwrapping presents can include many tasks; from speed tearing the paper to lifting that heavy present out from under the Christmas tree.",
                             calories="Calories burned per minute: 40")

G_familyLB <-   lightboxBody("family",
                             title="Arguing with family",
                             svgName="Exercise_family", 
                             description="We all have that family member who has strong opinions that you disagree with. Arguing your point can take a lot of time and energy, especially if you go for the win! Take this exercise to the next level by making wild hand gestures and slamming the door on your way out.",
                             calories="Calories burned per minute: 36")

G_couchLB <-    lightboxBody("couch",
                             title="Couch surfing",
                             svgName="Exercise_couch", 
                             description="Christmas time can include a lot of travel to see friends and family. Ride those waves right into your friends lounge this Christmas and settle down for the night. Couch surfing might not be the most intense exercise but stick to it for the long run to burn those calories!",
                             calories="Calories burned per hour: 300")

G_shoppingLB <- lightboxBody("shopping",
                             title="Last minute shopping",
                             svgName="Exercise_shopping", 
                             description="Get in before the stores close and make sure you haven’t forgotten last-minute gifts for those relatives you only see once a year. Battle the crowds and don’t forget to make it out of the store before the doors shut on Christmas Eve.",
                             calories="Calories burned per hour: 100")

G_chimneyLB <-  lightboxBody("chimney",
                             title="Climbing down the chimney",
                             svgName="Exercise_chimney", 
                             description="Take a leaf out of Santa's book and add the extreme sport of chimney climbing to your Christmas to-do list. Once you have made it down, be sure to treat yourself to a snooze on the couch.",
                             calories="Calories burned per minute: 30")
