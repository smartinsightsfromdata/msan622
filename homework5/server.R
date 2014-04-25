shinyServer(function(input, output) {
  
  output$start <- renderUI({
    
    if (is.null(input$num)) { return() }
    
    sliderInput("start", "Starting Point:",
                min = 1974, max = 1980 - (input$num / 12) - (1/12),
                value = 1974, step = 1 / 12,
                round = FALSE, ticks = TRUE,
                format = "####.##",
                animate = animationOptions(
                  interval = 800, loop = TRUE))
  })
  
  output$mainPlot <- renderPlot({
    if (is.null(input$start)) { return() }
    print(plotArea(input$start, input$num))
  })
  
  output$overviewPlot <- renderPlot({
    if (is.null(input$start)) { return() }
    print(plotOverview(input$start, input$num))
  })
    
})