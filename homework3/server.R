# require(rMaps)
require(rCharts)
#


shinyServer(function(input, output, session) {
  

  # output$parallel <- reactive(function() {    
  #   states[,1:6]
  # })
  
  # output$scatter <- reactive(function() {
  #   states[,c(2:6,10)]
  # })
  
  output$choropleth <- rCharts::renderChart2({
    if (is.null(input$variable)) {
      return()
    }
    
    rMaps::ichoropleth(
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