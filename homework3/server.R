require(rMaps)
require(rCharts)

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
  
  output$checkboxes <- renderUI({
    radioButtons('variable',  
                 'Measure of interest',
                 choices = names(states_df)[-7:-12],
                 selected = 'Population')
  })
  
  output$parallel <- reactive(function() {    
    states[,1:6]
  })
  
  output$scatter <- reactive(function() {
    states[,c(2:6,10)]
  })
  
  output$choropleth <- rCharts::renderChart2({
    if (is.null(input$variable)) {
      return()
    }
    
    ichoropleth(
      as.formula(paste(input$variable, ' ~ State')), 
      data = states_df[,-7:-11],
      geographyConfig = list(
      popupTemplate = "#! function(geography, data){
        Shiny.onInputChange('state', geography.properties.name)
        return '<div class=hoverinfo><strong>' + geography.properties.name + '</strong></div>';
      } !#"))
  })
  
  #output$parallel <- rCharts::renderChart2({
  #  parallel <- rCharts$new()
  #  parallel$field('lib', 'parcoords') 
  #  parallel$set(padding = list(top = 25, left = 5, bottom = 10, right = 0), 
  #               width=800, height=400) 
  #  parallel$set(data = toJSONArray(states_df, json = FALSE),
  #               colorby = 'Region', 
  #               #range = range(meanvars$Total.Revenue), 
  #               colors = c('red','blue')) 
  #  parallel$setLib("parcoords")
  #  return(parallel)
  #})
  
})