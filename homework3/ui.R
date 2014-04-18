library(rCharts)
library(rMaps)

d3IO <- function(inputoutputID) {
  div(id=inputoutputID,
      class=inputoutputID,
      tag('svg', ''));
}

shinyUI(fluidPage(
  
  titlePanel("Know your states"),
  
  sidebarLayout(
    
    sidebarPanel(
      width = 2,
      checkboxGroupInput('variables',
                         'Parallel Coordinate variables',
                         choices = c("Income", "Illiteracy", "Life Exp", "Murder", "HS Grad"),
                         selected = c("Income", "Illiteracy", "Life Exp", "Murder", "HS Grad")),
      radioButtons('variable',
                   'Choropleth variable',
                   choices = c("Income", "Illiteracy", "Life.Exp", "Murder", "HS.Grad"),
                   selected = c("Income")),
      checkboxGroupInput('variables2',
                         'Scatterplot matrix variables',
                         choices = c("Income", "Illiteracy", "Life Exp", "Murder", "HS Grad"),
                         selected = c("Income", "Illiteracy", "Life Exp", "Murder", "HS Grad"))
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel('Parallel Coordinates',
                 div(class = 'alert alert-info', 'How do states tend to cluster around certain attributes pertaining to health and well being? Click and drag axes to highlight a subset or rearrange the axes.'),
                 includeHTML('parallel.html'),
                 d3IO('parallel')), 
        tabPanel('Choropleth',
                 div(class = 'alert alert-info', 'Explore geographical patterns as well. Hover for tooltips.'),
                 rCharts::chartOutput('choropleth', 'datamaps')),
        tabPanel('Scatterplot Matrix',
                 div(class = 'alert alert-info', 'Search for pairwise correlations. Click and drag to highlight a subset of states.'),
                 includeHTML('scatter.html'),
                 d3IO('scatter'))
      )
    )
  )
))