require(rMaps)
require(RJSONIO)

shinyServer(function(input, output, session) {
  
  states <- state.x77
  
  output$d3io <- reactive(function() {    
    states
  })
  
  output$myplot = rCharts::renderChart2({ichoropleth(
    Crime ~ State, 
    data = subset(violent_crime, Year == 2010)
  )})

})