shinyServer(function(input, output) {
  
  output$mainPlot <- renderPlot({
    if (is.null(input$slider)) { return() }
    print(plotArea(input$slider))
  }, bg = 'transparent')
  
  output$overviewPlot <- renderPlot({
    if (is.null(input$slider)) { return() }
    print(plotOverview(input$slider))
  }, bg = 'transparent')
    
})