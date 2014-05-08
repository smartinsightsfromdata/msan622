library(reshape)
library(ggplot2)
library(scales)
library(GGally)
library(shiny)
library(plyr)

shinyServer(function(input, output) {
  
  cat("Press \"ESC\" to exit...\n")
  
  output$subset <- renderUI({
    selectizeInput('subset',
                   'Subreddits:',
                   choices = levels(d$subreddit),
                   selected = c('gifs'),
                   multiple = TRUE)
  })
  
  output$subset2 <- renderUI({
    selectizeInput('subset2',
                   'Subreddits:',
                   choices = levels(d$subreddit),
                   selected = c('gifs'),
                   multiple = TRUE)
  })
  
  get_data <- reactive({
    subset(d, subreddit %in% input$subset)
  })
  
  get_data2 <- reactive({
    subset(d, subreddit %in% input$subset2)
  })
  
  output$datatable <- renderDataTable({
    d[, !(names(d) %in% c('hour', 'X.image_id', 'unixtime', 'localtime', 'reddit_id'))]
  })

  output$timePlot <- renderPlot({
    dat <- get_data()
    if (nrow(dat) == 0) { return() }
    print(plotTime(dat))
  }, bg = 'transparent')

  output$votePlot <- renderChart({
    dat <- get_data2()
    if (nrow(dat) == 0) { return() }    
    plotVotes(dat)
  })

})
