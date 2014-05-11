library(shiny)
library(ggplot2)

shinyUI(navbarPage(theme = 'superhero.css',
                   title = img(src = 'reddit.png', height = 50, width = 50),
                   tabPanel('About',
                            includeCSS('www/about.css'),
                            fluidRow(
                              column(width = 5, offset = 1,
                                br(),
                                p('Reddit /ˈrɛdɪt/ is an entertainment, social networking service and news website where registered community members can submit content, such as text posts or direct links. Only registered users can then vote submissions "up" or "down" to organize the posts and determine their position on the site\'s pages. Content entries are organized by areas of interest called "subreddits".'),
                                br(),
                                p('This dataset is a collection of 132,308 reddit.com submissions between July 2008 and January 2013. Each submission is of an image, which has been submitted to reddit multiple times. The dataset was collated by H. Lakkaraju, J. J. McAuley, and J. Leskovec.'),
                                br(),
                                HTML('<div style="text-align: center; margin-top: 20px">
                                      <a href="http://spencerboucher.com" type="button" class="btn btn-lg btn-primary">My Blog</a>
                                      <a href="http://snap.stanford.edu/data/web-Reddit.html" type="button" class="btn btn-lg btn-primary">The Data</a>
                                      </div>')
                              ),
                              column(width = 5,
                                h4('Still confused? Watch this before you dive in:'),
                                div(class = "video-container",
                                    HTML('<iframe width="560" height="315" src="//www.youtube.com/embed/tlI022aUWQQ" frameborder="0" allowfullscreen></iframe>'))
                                )
                              )
                            ),
                   
                   tabPanel('By subreddit',
                            includeCSS('www/votes.css'),
                            fluidRow(
                              column(width = 10, offset = 1,
                                     uiOutput('subset2'))),
                            showOutput('votePlot', 'nvd3')
                   ),
                   
                   tabPanel('By time',
                            fluidRow(
                              column(width = 7, offset = 1,
                                     uiOutput('subset')),
                              column(width = 3, 
                                     selectInput('type',
                                                  '',
                                                  choices = c('Total_votes', 'Upvotes', 'Downvotes', 'Score')))),
                            fluidRow(
                              column(width = 10, offset = 1,
                                     plotOutput('timePlot',
                                                width = '100%',
                                                height = 600)))
                            ),
                   
                   tabPanel('Network graph', height = 1000,
                            includeCSS('www/graph.css'),
                            includeHTML('force.html')
                            ),
                   
                   tabPanel('Flow', height=1000,
                            includeCSS('www/janky.css'),
                            tags$head(
                              tags$script(src = 'http://d3js.org/d3.v3.min.js')
                            ),
                            fluidRow(
                              column(width = 8, offset = 2,
                                     p('Where do images first appear, and then where do they end up?'))),
                            fluidRow(
                              column(width = 8, offset = 2,
                                     htmlOutput('sankeyPlot')))
                            ),
                   
                   tabPanel('networkPlot',
                            htmlOutput('networkPlot')
                            ),
                   
                   tabPanel('Raw data',
                            dataTableOutput('datatable'))
))