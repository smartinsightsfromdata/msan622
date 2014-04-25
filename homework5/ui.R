shinyUI(fluidPage(theme = 'bootstrap.min.css',
  headerPanel('Seatbelt deaths'),
  
  sidebarPanel(width = 3,
               sliderInput('slider', 'Time window',
                           min = 1969, max = 1985,
                           value = c(1969, 1970), step = 1/12,
                           round = FALSE, ticks = TRUE,
                           format = "####.##")
  ),
  
  mainPanel(width = 9,
            plotOutput(outputId = "mainPlot", 
                       width = "100%", height = "400px"),
            plotOutput(outputId = "overviewPlot",
                       width = "100%", height = "200px")
  )
))