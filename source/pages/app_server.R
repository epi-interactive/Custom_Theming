##################################
# Created by EPI-interactive
# 17 May 2019
# https://www.epi-interactive.com
##################################

# Backend for Cookie Explorer
pageApp <- function(input, output, session) {
  
  ns <- session$ns
  
  # ==== State values ==== #
  
  # Calories in and out for Chart
  calories <- reactiveValues(
    totalIn = 0,
    totalOut = 0
  )
  
  # Control for Custom Treats
  showCustomTreatSlider <- reactiveVal(value = F)
  showCustomTreatInputError <- reactiveVal(value = F)
  customTreatCalories <- reactiveVal(value = 0)
  customTreatQuantity <- reactiveVal(value = 0)
  
  # Control for Custom Exercises
  showCustomExerciseSlider <- reactiveVal(value = F)
  showCustomExerciseInputError <- reactiveVal(value = F)
  customExerciseCalories <- reactiveVal(value = 0)
  customExerciseQuantity <- reactiveVal(value = 0)

  
  # ==== Output the sliders ==== # 
  # ========= Treats =========== #
  
  # Chocolate chip cookies
  output$cookiesSlider <- renderUI({
    div(class="col-sm-8", renderSlider("cookies", "Chocolate chip cookies", 0, 30))
  }) 
  
  # Mince pies
  output$piesSlider <- renderUI({
    div(class="col-sm-8", renderSlider("pies", "Mince pies", 0, 10))
  }) 
  
  # Gingerbread
  output$breadSlider <- renderUI({
    div(class="col-sm-8", renderSlider("bread", "Gingerbread", 0, 20))
  }) 
  
  # Advent calendar chocolates
  output$calendarSlider <- renderUI({
    div(class="col-sm-8", renderSlider("calendar", "Advent calendar chocolates", 0, 24))
  }) 
  
  # Pavlova
  output$pavlovaSlider <- renderUI({
    div(class="col-sm-8", renderSlider("pavlova", "Pavlova", 0, 12))
  }) 
  
  
  # ========= Exercises =========== #
  
  # Unwrapping Presents
  output$presentsSlider <- renderUI({
    div(class="col-sm-8", renderSlider("presents", "Unwrapping presents", max=60))
  }) 
  
  # Arguing with family
  output$familySlider <- renderUI({
    div(class="col-sm-8", renderSlider("family", "Arguing with family", max=60))
  }) 
  
  # Couch surfing
  output$couchSlider <- renderUI({
    div(class="col-sm-8", renderSlider("couch", "Couch surfing", max=6))
  }) 
  
  # Last minute shopping
  output$shoppingSlider <- renderUI({
    div(class="col-sm-8", renderSlider("shopping", "Last minute shopping", max=6))
  })
  
  # Climbing down the chimney
  output$chimneySlider <- renderUI({
      div(class="col-sm-8", renderSlider("chimney", "Climbing down the chimney", max=60))
  }) 
  
  # ====== Custom sliders ====== #
  # Custom Treats
  output$customTreatSlider <- renderUI({
    div(class="col-sm-8 custom-slider", renderSlider(id = "customTreat", label = input$customTreatInputName, init = customTreatQuantity(), showLB = F))
    })
  
  # Custom Exercises
  output$customExerciseSlider <- renderUI({
    div(class="col-sm-8 custom-slider", renderSlider("customExercise", input$customExerciseInputName, customExerciseQuantity(), max = 60, showLB = F))
  })
  
  
  # ====== Utility functions ====== #
  
  # Generates a Slider with a label and lightbox button
  renderSlider <- function(id, label, init=0, max=12, showLB=T) {
    if(showLB){ 
      btn <- lightboxBtn(id, tags$img(src="img/Info_btn.svg", class="info-button")) 
    }
    else { 
      if(id == "customExercise"){
        btn <- actionButton(ns("removeExercise"), label = "remove", class="info-button")
      }else {
        btn <- actionButton(ns("removeTreat"), label = "remove", class="info-button")
      }
    }
    
      div(class="slide-input-wrapper",
           btn
        ,sliderInput(inputId = ns(paste0(id, "Slider")), label,
                min = 0, max = max, step = 1,
                value=init
        )
      )
  }
  
  calcCalories <- function(data) {
    lapply(1:nrow(data), function(x){
           data[x, ]$values * data[x, ]$calories
      }) %>% unlist() %>% sum()
  }
  
  # Get Calories in and out
  getCalorieData <- function() {
    req(input$cookiesSlider, input$piesSlider, input$breadSlider, input$calendarSlider, input$pavlovaSlider)
    req(input$presentsSlider, input$familySlider, input$couchSlider, input$shoppingSlider, input$chimneySlider)
    
    c_in <- calcCalories(getTreatsData())
    c_out <- calcCalories(getExerciseData())
    
    if(showCustomTreatSlider()){
      req(input$customTreatSlider)
      c_in <- c_in + (customTreatCalories() * input$customTreatSlider)
    }
    if(showCustomExerciseSlider()){
      req(input$customExerciseSlider)
      c_out <- c_out + (customExerciseCalories() * input$customExerciseSlider)
    }
    calories$totalIn <- c_in
    calories$totalOut <- c_out
    categories <- c("Exercise ", "Treats ")
    values <- c(c_out, c_in)
    
    return( data.frame(categories, values) )
  }
  
  
  # ====== Display Slider Values ======== #
  # (the little box next the the sliders) #
  
  # Chocolate chip cookies
  output$cookiesDisplay <- renderUI({
    req(input$cookiesSlider)
    createDisplayBox(input$cookiesSlider, "cookie")
  })
  
  # Mince pies
  output$piesDisplay <- renderUI({
    req(input$piesSlider)
    createDisplayBox(input$piesSlider, "pie")
  })
  
  # Gingerbread
  output$breadDisplay <- renderUI({
    req(input$breadSlider)
    createDisplayBox(input$breadSlider, "piece")
  })
  
  # Advent calendar chocolates
  output$calendarDisplay <- renderUI({
    req(input$calendarSlider)
    createDisplayBox(input$calendarSlider, "piece")
  })
  
  # Pavlova
  output$pavlovaDisplay <- renderUI({
    req(input$pavlovaSlider)
    createDisplayBox(input$pavlovaSlider, "slice")
  })
  
  # Custom treat display
  output$customTreatDisplay <- renderUI({
    req(input$customTreatSlider)
    createDisplayBox(input$customTreatSlider, "piece")
  })
  
  # Custom exercise display
  output$customExerciseDisplay <- renderUI({
    req(input$customExerciseSlider)
    createDisplayBox(input$customExerciseSlider)
  })
  
  # Unwrapping presents
  output$presentsDisplay <- renderUI({
    req(input$presentsSlider)
    createDisplayBox(input$presentsSlider)
  })
  
  # Arguing with family
  output$familyDisplay <- renderUI({
    req(input$familySlider)
    createDisplayBox(input$familySlider)
  })
  
  # Couch surfing
  output$couchDisplay <- renderUI({
    req(input$couchSlider)
    createDisplayBox(input$couchSlider, "hour")
  })
  
  # Last minute shopping
  output$shoppingDisplay <- renderUI({
    req(input$shoppingSlider)
    createDisplayBox(input$shoppingSlider, "hour")
  })
  
  # Climbing down the chimney
  output$chimneyDisplay <- renderUI({
    req(input$chimneySlider)
    createDisplayBox(input$chimneySlider)
  })
  
  
  createDisplayBox <- function(value, suffix="min"){
    suffix <- if(value == 1) suffix else paste0(suffix,"s")
    div(class="input-display col-sm-3 col-sm-offset-1", paste(value, suffix))
  }
  
  # ====== Create the Chart ======#
  
  output$caloriesComparison <- renderPlotly({
    # Axis properties - a = x-axis, b = y-axis
    a <- list(visible=T, showgrid=F, showticklabels = F, 
              showline=T, title=" ", mirror=F, zeroline=F, linecolor="#14505E", linewidth=2, rangemode = "nonnegative", range=c(0, 10000))
    b <- list( showticklabels=T,
              showgrid=F, gridcolor="#bbb",  showline=T, linecolor="#14505E",  title=" ",linewidth=2, zeroline=F, mirror=F, tickfont=list(size=15, color="#14505E"))
    
    # define margin
    m = list(
      l = 100,
      r = 20,
      b = 60,
      t = 30,
      pad = 0
    )
    
    initScale <- F
    if(calories$totalIn == 0 & calories$totalOut == 0){
      initScale <- T
    }
    
    # Get the data for the Chart
    chartData <- getCalorieData()
    
    # Plot the Chart
    chart <- plot_ly(
      data = chartData,
      marker = list(color = c('rgba(144, 208, 56, 1)', 'rgba(209, 46, 18, 1)')),
      #text = c(paste0(calories$totalOut, " calories burned"), paste0(calories$totalIn, " calories in")),
      hoverinfo = 'none',
      #hoverlabel = list(font=list(size= 16)),
      type = "bar"
    ) %>%
      add_bars(
      x= ~values,
      y= ~categories,
      width = 0.4
    )
    chart %>% layout(
      bargap = 0.01,
      margin = m,
      showlegend = F,
      xaxis =a,
      yaxis = b
      
    ) %>%
      hide_colorbar()%>%
      config(displayModeBar = FALSE,
             staticPlot= T) 
  })
  
  # Renders all the Treats images
  output$allTreatsImageOutput <- renderUI({
    req(input$cookiesSlider, input$piesSlider, input$breadSlider, input$calendarSlider, input$pavlovaSlider)
    if(showCustomTreatSlider()){
      req(input$customTreatSlider)
    }
    renderImages(T)
  })
  
  # Renders all the Exercise images 
  output$allExerciseImageOutput <- renderUI({
    req(input$presentsSlider, input$familySlider, input$couchSlider, input$shoppingSlider, input$chimneySlider)
    if(showCustomExerciseSlider()){
      req(input$customExerciseSlider)
    }
    renderImages(F)
  })
  
  # Returns a dataframe with all the details for Treats
  getTreatsData <- function() {
    names <- c("Chocolate chip cookies", "Mince pies", "Gingerbread", "Advent calendar chocolates", "Pavlova")
    keys <- c("cookies", "pies", "bread", "calendar", "pavlova")
    values <- c(input$cookiesSlider, input$piesSlider, input$breadSlider, input$calendarSlider, input$pavlovaSlider)
    calories <- c(75, 350, 160, 15, 100)
    step <- c(1,1,1,1,1)
    unit <- c("cookie", "pie", "piece", "piece","slice")
    treats <- data.frame(names, keys, values, calories, step, unit, stringsAsFactors = F)
    
  }
  
  # Returns a dataframe with all the details for Exercises
  getExerciseData <- function() {
    names <- c("Unwrapping presents", "Arguing with family", "Couch surfing", "Last minute shopping", "Climbing down the chimney")
    keys <- c("presents", "family", "couch", "shopping", "chimney")
    values <- c(input$presentsSlider, input$familySlider, input$couchSlider, input$shoppingSlider, input$chimneySlider)
    calories <- c(40, 36, 300, 100, 30)
    step <- c(5,5,0.5,0.5,5)
    unit <- c("min", "min", "hour", "hour","min")
    exercises <- data.frame(names, keys, values, calories, step, unit, stringsAsFactors = F)
  }
  
  # Main function for rendering the images. Creates the correct images and adds the popover for when they're hovered over.
  renderImages <- function(isTreats) {
    
    # Get the right data
    if(isTreats){ 
      data <- getTreatsData()
      if(showCustomTreatSlider()){
        data <- rbind(data, c(input$customTreatInputName, "custom_t", input$customTreatSlider, input$customTreatInputValue, 1))
      }
      prefix <- "Treat_"
    } else { 
      data <- getExerciseData() 
      if(showCustomExerciseSlider()){
        data <- rbind(data, c(input$customExerciseInputName, "custom_e", input$customExerciseSlider, input$customExerciseInputValue, 5))
      }
      prefix <- "Exercise_"
    }
    
    if(all(data$values == 0)){
      return(
        div(class="no-items", paste0("Use the controls to add some ", if(isTreats){ "treats" } else { "exercise" }, "!"))
      )
    }
    
    # For type of treat/exercise...
    images <- lapply(1:nrow(data), function(x){
      row <- data[x, ]
      row$values <- as.numeric(row$values)
      row$step <- as.numeric(row$step)
      
      # Loop over each item in that treat/exercise and make an image element
      items <- tagList()
      if(row$values > 0){
        items <- lapply(1:ceiling(row$values/row$step), function(y){
          
          img <- tags$img(src=paste0("img/Icons/", prefix, row$keys, ".svg"),  class="col-lg-4 col-sm-2 item-image", id=paste0(row$keys, "-", y))
          popoverContent <- getPopoverContent(row, isTreats, prefix)
          
          # Return each actual image wrapped in a popover
          popify(img, row$names, popoverContent, "top", "hover", list(container = "body"))
          
        })
        color <- if(row$keys == "custom_t"){ "#d12e12" } else if(row$keys == "custom_e") { "#90d038" } else { "#14505E" }
        # Then put each group of images in a container
        div(class="item-container col-lg-6", 
            div(class="row",
                div(class="item-title col-sm-12", style=paste0("font-style: italic; color: ", color), row$name),
                div(class="items col-lg-12 col-sm-12", items))
            
            )
            
      }
    })
    
    # Then return all the groups of contained images 
    images
  }
  
  getPopoverContent <- function(row, isTreats, prefix) {
    unit <- row$unit
    if(isTreats){
      perCal <- ""
      totalCal <- "added"
    }else{
      perCal <- " burned"
      totalCal <- "burnt"
    }
    

    paste0(
      '<div class="popover-body row">', 
          '<img class="col-sm-3" src="img/Icons/', prefix, row$keys, '.svg"/>',
          '<div class="popover-text col-sm-9">', 
              '<div class="popover-heading">',
                  'Calories',perCal,' per ', unit ,': <span><strong><i>', row$calories,'</i></strong></span>',
              '</div>',
              '<div class="popover-details">',
                  'Total calories ',totalCal,': <span><strong><i>', as.numeric(row$calories) * as.numeric(row$values), '</i></strong></span>',
              '</div>',
          '</div>')
  }
  
  
  # Annotation for the chart
  output$chartMsg <- renderUI({
    if(calories$totalOut == 0 & calories$totalIn ==  0){
      div(class="calories-text clear", div(class="message-init", 
                                           div(class="starting-message", "Start by picking your treats and exercises!"),
                                           tags$img(src="img/Text_Start.svg")))
      
    } else if((calories$totalOut < calories$totalIn*1.05) & (calories$totalOut > calories$totalIn*0.95)){
      div(class="calories-text", tags$p("The perfect balance!"),
          tags$img(src="img/Text_Balance.svg", style=""))
      
    } else if(calories$totalOut > calories$totalIn) {
      div(class="calories-text", tags$p("All good, keep on indulging..."), 
          tags$img(src="img/text_treats.svg"))
    }  
    else {
      div(class="calories-text", tags$p("Oh no - time to get some exercise going"),
          tags$img(src="img/text_exercise.svg"))
    }
  })
  

  # Handle whether to show the custom treat slider or an error
  observeEvent(input$addTreat, {
    if(input$customTreatInputName != "" & input$customTreatInputValue != ""){
      # If input values are valid show the slider
      customTreatCalories(as.numeric(input$customTreatInputValue))
      customTreatQuantity(input$customTreatInputQuantity)
      showCustomTreatSlider(T)
      showCustomTreatInputError(F)
    }else{
      # If not then show the error
      showCustomTreatInputError(T)
    }
  })
  
  observeEvent(input$removeTreat, {
    showCustomTreatInputError(F)
    showCustomTreatSlider(F)
    customTreatQuantity(0)
  })
  
  observeEvent(input$removeExercise, {
    showCustomExerciseInputError(F)
    showCustomExerciseSlider(F)
    customExerciseQuantity(0)
  })
  
  # Handle whether to show the custom exercise slider or an error
  observeEvent(input$addExercise, {
    if(input$customExerciseInputName != "" & input$customExerciseInputValue != ""){
      # If input values are valid show the slider
      customExerciseCalories(as.numeric(input$customExerciseInputValue))
      customExerciseQuantity(input$customExerciseInputQuantity)
      showCustomExerciseSlider(T)
      showCustomExerciseInputError(F)
    }else{
      # If not then show the error
      showCustomExerciseInputError(T)
    }
  })
  
  # The error for an invalid Treat
  output$customTreatError <- renderUI({
    if(showCustomTreatInputError()){
      div(class="alert alert-danger", role="alert", "That treat doesn't sound too good - try something else.")
    }
  })
  
  # The error for an invalid Exercise
  output$customExerciseError <- renderUI({
    if(showCustomExerciseInputError()){
      div(class="alert alert-danger", role="alert", "That exercise doesn't sound too good - try something else.")
    }
  })
  
  # Form for a new treat
  output$newTreat <- renderUI({
    if(!showCustomTreatSlider()){
      div(class="col-sm-12 col-md-12",
          tags$p(class="custom-treat", "Custom treat: "),
          div(
            tags$span(class="col-sm-3 mobile-enhance-span", "Treat name: "),
            div(class="col-sm-9 custom-input-wrap -mt", textInput(ns("customTreatInputName"), label = ""))
          ),
          div(
            tags$span(class="col-sm-3 mobile-enhance-span","Calories per piece: "),
            div(class="col-sm-3 custom-input-wrap -mt", selectInput(ns("customTreatInputValue"), label = "", choices = seq(20, 200, by=20), selected = 20, multiple = F, selectize = F)),
            
            tags$span(class="col-sm-3 mobile-enhance-span", style="text-align:center","Number of pieces: "),
            div(class="col-sm-3 custom-input-wrap -mt", selectInput(ns("customTreatInputQuantity"), label = "",  choices = c(1:12), selected = 1, multiple = F, selectize = F))
          ),
          div(
            div(class="col-sm-12 custom-input-wrap", actionButton(ns("addTreat"), "Add treat"))
          )
      )
    } else {
      # If state reads to show the slider, show that instead of the form.
      tagList(
        uiOutput(ns("customTreatSlider")),
        uiOutput(ns("customTreatDisplay"))
      )
    }
  })
  
  # Form for a new Exercise
  output$newExercise <- renderUI({
    if(!showCustomExerciseSlider()){
      div(class="col-sm-12 col-md-12",
          tags$p(class="custom-treat", "Custom exercise: "),
          div(
            tags$span(class="col-sm-3 mobile-enhance-span", "Exercise name: "),
            div(class="col-sm-9 custom-input-wrap -mt", textInput(ns("customExerciseInputName"), label = ""))
          ),
          div(
            tags$span(class="col-sm-3 mobile-enhance-span","Calories burned per minute: "),
            div(class="col-sm-3 custom-input-wrap -mt", selectInput(ns("customExerciseInputValue"), label = "", choices = seq(5, 40, by=5), selected = 5, multiple = F, selectize = F)),
            
            tags$span(class="col-sm-3 mobile-enhance-span", style="text-align: center;","Number of minutes: "),
            div(class="col-sm-3 custom-input-wrap -mt", selectInput(ns("customExerciseInputQuantity"), label = "", choices = 1:60, selected = 1, multiple = F, selectize = F))
            
          ),
          div(
            div(class="col-sm-12 custom-input-wrap", actionButton(ns("addExercise"), "Add exercise"))
          )
      )
    } else {
      # If state reads to show the slider, show that instead of the form.
      tagList(
        uiOutput(ns("customExerciseSlider")),
        uiOutput(ns("customExerciseDisplay"))
      )
    }
  })
  
  
  
  
}
