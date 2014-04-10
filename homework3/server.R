require(rMaps)
require(RJSONIO)

shinyServer(function(input, output, session) {
  
  states <- state.x77
  states_df <- data.frame(states) 
  states_df$State <- unique(violent_crime$State)
  
  output$d3io <- reactive(function() {    
    states
  })
  
  output$myplot <- rCharts::renderChart2({ichoropleth(
    Income ~ State, 
    data = states_df,
    geographyConfig = list(
      popupTemplate = "#! function(geography, data){
        Shiny.onInputChange('state', geography.properties.name)
        return '<div class=hoverinfo><strong>' + geography.properties.name + '</strong></div>';
      } !#"
    )
  )})
  
  output$mystate <- renderText({
    input$state
  })

})