library(reshape2)
library(ggplot2)
library(scales)
library(shiny)
library(plyr)

shinyServer(function(input, output) {

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

  # Generates the sankey.html iframe
  #     d3Sankey(Nodes = nodes, Links = links, Source = 'source',
  #              Target = 'target', Value = 'weight', NodeID = 'id',
  #              width = 800, height = 600, standAlone = TRUE,
  #              fontsize = 12, parentElement = "#sankeyPlot",
  #              iframe = TRUE, file = 'sankey.html')

  output$networkPlot <- renderPrint({
    links2 <- JSONtoDF(file = paste0(as.character(input$threshold), 'graph.json'), array = "links")
    nodes2 <- JSONtoDF(file = paste0(as.character(input$threshold), 'graph.json'), array = "nodes")
    links2$weight <- rescale(links2$weight, to = c(1,100))
    d3ForceNetwork(Nodes = nodes2, Links = links2, Source = "source",
                   Target = "target", Value = "weight", NodeID = "id",
                   width = 800, height = 700, standAlone = FALSE, 
                   parentElement = "#networkPlot", charge = -100, opacity = .8,
                   linkDistance = 200)
  })

})
