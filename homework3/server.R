require(rMaps)
require(rCharts)
options(RCHART_WIDTH = 910,
        RCHART_HEIGHT = 420)

shinyServer(function(input, output, session) {
  
  states <- state.x77
  states_df <- data.frame(state.x77,
                          Abbrev = state.abb,
                          Region = state.region,
                          Division = state.division)
  states_df$State <- unique(violent_crime$State)
  states <- cbind(states,
                  'State' = rownames(states),
                  'Region' = state.region)
  
  output$parallel <- reactive(function() {    
    states[, input$variables]
  })
  
  output$scatter <- reactive(function() {
    states[, c(input$variables2, 'Region')]
  })
  
  output$choropleth = rCharts::renderChart2({
    ichoropleth(
      as.formula(paste(input$variable, ' ~ State')), 
      data = states_df[,-7:-11],
      geographyConfig = list(
        popupTemplate = paste0("#! function(geography, data){
        Shiny.onInputChange('state', geography.properties.name)
        return '<div class=hoverinfo><strong>' + geography.properties.name + '<br>' + data.", input$variable, "+ '</strong></div>';
      } !#")
      ),
      legend=TRUE
    )
  })

  
})