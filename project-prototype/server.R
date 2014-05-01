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
  
  get_data <- reactive({
    return(subset(d, subreddit %in% input$subset))
  })
  
  output$datatable <- renderDataTable({
    dat <- get_data()
    dat[, !(names(dat) %in% c('unixtime', 'localtime', 'reddit_id'))]
  })

  output$timePlot <- renderPlot({
    dat <- get_data()
    print(plotTime(dat))
  })

  output$overviewPlot <- renderPlot({
    print(qplot(c(1,2,3)))
  }, width = 'auto')

})
