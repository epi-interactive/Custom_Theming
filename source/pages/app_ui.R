##################################
# Created by EPI-interactive
# 17 May 2019
# https://www.epi-interactive.com
##################################

pageAppUI <- function(id) {
  ns <- NS(id)

  div(class="app",
      HTML('<div id="snowflakeContainer">
        <p class="snowflake">*</p>
        </div>'),
      div(class="header",
          tags$img(class="left", src="img/christmas_left_corner.png"),
          tags$img(class="logo", src="img/logo.png"),
          tags$img(class="right", src="img/christmas_right_corner.png")
        ),
      div(class="body",
          fluidRow(
            # Output Start
            div(class="outputs col-lg-7 col-sm-12 col-lg-push-5",
                fluidRow(
                  div(class="introduction col-lg-12",
                      tags$h1("How does it work?"),
                      tags$p("Don't worry, it's simple!"),
                      tags$p("Use the sliders to measure your energy input and output. The Cookie Explorer then provides feedback where things are at - there might be a need to up that exercise level or green light for some more of those cookies. You won't know until you try! ")
                  )
                ),
                fluidRow(
                  div(
                    div(class="col-sm-9", style="background: white",
                        plotlyOutput(ns("caloriesComparison"))
                    ),
                    div(class="col-sm-3",
                        uiOutput(ns("chartMsg"))
                    )
                  )
                )
            ),
            # Output end
            # Sliders start
            div(class="sliders col-lg-5 col-sm-12 col-lg-pull-7",
                div(class="sliders-panel",class="col-lg-10 col-sm-12",
                             createFilterPanel(ns("treats-panel"), "Pick your Christmas treats and the amount:",
                               div(class="treats",
                                   fluidRow(
                                     uiOutput(ns("cookiesSlider")),
                                     uiOutput(ns("cookiesDisplay"))
                                   ),
                                   fluidRow(
                                     uiOutput(ns("piesSlider")),
                                     uiOutput(ns("piesDisplay"))
                                   ),
                                   fluidRow(
                                     uiOutput(ns("breadSlider")),
                                     uiOutput(ns("breadDisplay"))
                                   ),
                                   fluidRow(
                                     uiOutput(ns("calendarSlider")),
                                     uiOutput(ns("calendarDisplay"))
                                   ),
                                   fluidRow(
                                     uiOutput(ns("pavlovaSlider")),
                                     uiOutput(ns("pavlovaDisplay"))
                                   ),
                                   fluidRow(
                                     uiOutput(ns("newTreat"))

                                   ),
                                   fluidRow(
                                     uiOutput(ns("customTreatError"))
                                   )
                               )
                             )
                )
            )
            # Sliders end
          ),
          fluidRow(
            div(class="sliders col-lg-5 col-sm-12",
                div(class="sliders-panel",class="col-lg-10 col-sm-12",
                    createFilterPanel(ns("exercise-panel"), "Pick your exercise:<br/><br/>",
                                      div(class="exercise",
                                          fluidRow(
                                            uiOutput(ns("presentsSlider")),
                                            uiOutput(ns("presentsDisplay"))
                                          ),
                                          fluidRow(
                                            uiOutput(ns("familySlider")),
                                            uiOutput(ns("familyDisplay"))
                                          ),
                                          fluidRow(
                                            uiOutput(ns("couchSlider")),
                                            uiOutput(ns("couchDisplay"))
                                          ),
                                          fluidRow(
                                            uiOutput(ns("shoppingSlider")),
                                            uiOutput(ns("shoppingDisplay"))
                                          ),
                                          fluidRow(
                                            uiOutput(ns("chimneySlider")),
                                            uiOutput(ns("chimneyDisplay"))
                                          ),
                                          fluidRow(
                                            uiOutput(ns("newExercise"))

                                          ),
                                          fluidRow(
                                            uiOutput(ns("customExerciseError"))
                                          )
                                      )
                    )
                )
              ),
            div(class="treat-exercise-outputs col-lg-7 col-sm-12 ",
                fluidRow(
                  div(class="col-sm-6 treats-output",
                      tags$h2("Treats"),
                      uiOutput(ns("allTreatsImageOutput"))
                  ),
                  div(class="col-sm-6 exercise-output",
                      tags$h2("Exercise"),
                      uiOutput(ns("allExerciseImageOutput"))
                  )
                )
            )
          )
      ),
      div(class="footer row",
          tags$img(class="left", src="img/christmas_doggos.png"),
          tags$a(href="https://www.epi-interactive.com/", target="_blank", tags$img(class="right", src="img/merry_christmas_epi.png"))
      )
    )
}
