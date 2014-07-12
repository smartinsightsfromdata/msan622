library(rCharts)
# library(rMaps)
# require(rCharts)

# d3IO <- function(inputoutputID) {
#   div(id=inputoutputID,
#       class=inputoutputID,
#       tag('svg', ''));
# }

shinyUI(navbarPage(inverse = TRUE,
                   title = 'Know Your States',
                   # tabPanel('Parallel Coordinates',
                   #          div(class = 'alert alert-dismissable alert-info',
                   #              'How do states tend to cluster around certain attributes pertaining to health and well being?\n Click and drag axes to highlight a subset or rearrange the axes.'),
                   #          includeHTML('parallel.html'),
                   #          d3IO('parallel')),
                   tabPanel('Choropleth',
                            fluidRow(
                              column(10,
                                # div(class = 'alert alert-dismissable alert-info',
                                #     'Explore geographical patterns as well.'),
                                rCharts::chartOutput('choropleth', 'datamaps')),
                              column(2,
                                  radioButtons("variable", "Select District:",
                                              selChoices))
                            ))
                   # ,
                   # tabPanel('Scatterplot Matrix',
                   #          div(class = 'alert alert-dismissable alert-info',
                   #              'Search for pairwise correlations.'),
                   #              includeHTML('scatter.html'),
                   #          d3IO('scatter'))
))