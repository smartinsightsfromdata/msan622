shinyUI(fluidPage(theme = 'bootstrap.min.css',
  br(),
  sidebarPanel(width = 3,
               wellPanel(
               p('Area chart controls'),
               sliderInput('slider', 'Time window',
                           min = 1969, max = 1985,
                           value = c(1969, 1972), step = 1/12,
                           round = FALSE, ticks = TRUE,
                           format = "####.##")),
               br(),
               hr(),
               wellPanel(
               p('Heat map controls'),
               checkboxInput('type', 'Radial display?', 
                             value=FALSE))
  ),
  
  mainPanel(width = 9,
            tabsetPanel(
              tabPanel('Area chart',
                br(),
                plotOutput(outputId = 'mainPlot', 
                           width = '100%', height = '400px'),
                plotOutput(outputId = 'overviewPlot',
                           width = '100%', height = '200px')
              ),
              tabPanel('Heat map',
                plotOutput(outputId = 'heatmapPlot',
                           width = '100%', height = '700px')
              )
            )
  )
))