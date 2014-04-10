d3IO <- function(inputoutputID) {
  div(id=inputoutputID,
      class=inputoutputID,
      tag('svg', ''));
}

shinyUI(navbarPage(inverse = TRUE,
                   title = 'Know Your States',
                   tabPanel('Parallel Coordinates',
                            includeHTML('index.html'),
                            d3IO("d3io")),
                   tabPanel('Map',
                            rCharts::chartOutput('myplot', 'datamaps'))
))