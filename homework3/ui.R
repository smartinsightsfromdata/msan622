d3IO <- function(inputoutputID) {
  div(id=inputoutputID,
      class=inputoutputID,
      tag('svg', ''));
}

shinyUI(navbarPage(inverse = TRUE,
                   title = 'Know Your States',
                   tabPanel('Parallel Coordinates',
                            fluidRow(
                              column(6,
                                includeHTML('index.html'),
                                d3IO("d3io")),
                              column(6,
                                rCharts::chartOutput('myplot', 'datamaps'),
                                uiOutput('mystate'))
                            ))
))