library(shiny)
library(ggplot2)

schemes <- c("Default", "Accent", "Set1", "Set2", "Set3", "Dark2", "Pastel1", "Pastel2")

shinyUI(fluidPage(theme='bootstrap.slate.min.css',
  
  titlePanel("IMDB Movie Rating vs Budgets"),
                  
  sidebarLayout(
    
    sidebarPanel(
      fluidRow(
        column(6, uiOutput('mpaa')),
        column(6, uiOutput('genres'))
      ),
      sliderInput('dot_size', 'Dot Size', 
                  min=1, max=10, value=5),
      br(),
      sliderInput('dot_alpha', 'Dot Alpha', 
                  min=0, max=1, value=.5, step=.1),
      br(),
      selectInput('color_scheme', 'Color Scheme', 
                  choices = schemes,
                  selected = 'Default')
    ),
    
    mainPanel(
      plotOutput('plot',
                 height = '600px')
    )
    
  )
))