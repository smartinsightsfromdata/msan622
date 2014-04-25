shinyUI(pageWithSidebar(
  headerPanel('Seatbelt deaths'),
  
  sidebarPanel(width = 3,
               sliderInput('num', 'Months:', 
                           min = 4, max = 24,
                           value = 12, step = 1),
               uiOutput('start')
  ),
  
  mainPanel(width = 9,
            textOutput('test'),
            plotOutput(outputId = "mainPlot", 
                       width = "100%", height = "400px"),
            plotOutput(outputId = "overviewPlot",
                       width = "100%", height = "200px")
  )
))