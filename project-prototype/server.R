library(reshape)
library(ggplot2)
library(scales)
library(shiny)
library(plyr)

shinyServer(function(input, output) {
  
  cat("Press \"ESC\" to exit...\n")
  
  output$subset <- renderUI({
    selectizeInput('subset',
                   '',
                   choices = levels(popular$Subreddit),
                   selected = c('aww', 'atheism', 'woahdude', 'reactiongifs'),
                   multiple = TRUE)
  })
  
  output$subset2 <- renderUI({
    selectizeInput('subset2',
                   '',
                   choices = levels(d$Subreddit),
                   selected = c('gifs', 'gif', 'mildlyinteresting', 'pics', 'funny', 'AMA', 'todayilearned'),
                   multiple = TRUE)
  })
  
  output$sankey <- renderUI({
    selectInput('sankey',
                '',
                choices = levels(d$Subreddit))
  })
  
  get_data <- reactive({
    subset(popular, Subreddit %in% input$subset)
  })
  
  get_data2 <- reactive({
    subset(d, Subreddit %in% input$subset2)
  })
  
  output$datatable <- renderDataTable({
    d[, !(names(d) %in% c('Hour', 'Image_ID', 'Time', 'Local_time', 'Reddit_ID'))]
  })

  output$timePlot <- renderPlot({
    dat <- get_data()
    if (nrow(dat) == 0) { return() }
    print(plotTime(dat, input$type))
  }, bg = 'transparent')

  output$votePlot <- renderChart({
    dat <- get_data2()
    if (nrow(dat) == 0) { return() }
    plotVotes(dat)
  })

  output$sankeyPlot <- renderPrint({
    nodes <- JSONtoDF(file = paste0('sankey.json'), array = 'nodes')
    nodes$id <- substring(nodes$id, 2)
    links <- JSONtoDF(file = paste0('sankey.json'), array = 'links')
    d3Sankey(Nodes = nodes, Links = links, Source = 'source',
             Target = 'target', Value = 'weight', NodeID = 'id', 
             width = 800, height = 600, standAlone = FALSE,
             fontsize = 12, parentElement = "#sankeyPlot")
  })
  
  output$networkPlot <- renderPrint({
    URL <- "https://raw.githubusercontent.com/christophergandrud/d3Network/master/JSONdata/miserables.json"
    MisJson <- getURL(URL, ssl.verifypeer = FALSE)
    MisLinks <- JSONtoDF(jsonStr = MisJson, array = "links")
    MisNodes <- JSONtoDF(jsonStr = MisJson, array = "nodes")
    MisNodes$ID <- 1:nrow(MisNodes)
    
    d3ForceNetwork(Nodes = MisNodes, Links = MisLinks, Source = "source", 
                   Target = "target", Value = "value", NodeID = "name", Group = "group", 
                   width = 300, height = 600, standAlone = FALSE, 
                   parentElement = "#networkPlot")
  })
  
})
