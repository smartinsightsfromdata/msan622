library(shiny)
library(ggplot2)

shinyUI(navbarPage(theme = 'superhero.css',
                   title = 'Secrets of Reddit',
                   tabPanel('About',
                            includeCSS('www/about.css'),
                            fluidRow(
                              column(width = 5, offset = 1,
                                br(),
                                p('Reddit /ˈrɛdɪt/ is an entertainment, social networking service and news website where registered community members can submit content, such as text posts or direct links. Only registered users can then vote submissions "up" or "down" to organize the posts and determine their position on the site\'s pages. Content entries are organized by areas of interest called "subreddits".'),
                                br(),
                                p('This dataset is a collection of 132,308 reddit.com submissions between July 2008 and January 2013. Each submission is of an image, which has been submitted to reddit multiple times. The dataset was collated by H. Lakkaraju, J. J. McAuley, and J. Leskovec.')
                              ),
                              column(width = 5,
                                h4('Still confused? Watch this before you dive in:'),
                                div(class = "video-container",
                                    HTML('<iframe width="560" height="315" src="//www.youtube.com/embed/tlI022aUWQQ" frameborder="0" allowfullscreen></iframe>'))
                                )
                              )
                            ),
                   
                   tabPanel('By time',
                            sidebarLayout(
                              
                              sidebarPanel(width = 2,
                                           uiOutput('subset')),
                              
                              mainPanel(width = 10,
                                        titlePanel('Effect of submission time on score'),
                                        plotOutput('timePlot', height = 600))
                                
                            )),
                   
                   tabPanel('By subreddit',
                            includeCSS('www/votes.css'),
                            sidebarLayout(
                              
                              sidebarPanel(width = 2,
                                           uiOutput('subset2')),
                              
                              mainPanel(width = 10,
                                        titlePanel('Activity by subreddit'),
                                        showOutput('votePlot', 'nvd3'))
                              
                              )),
                   
                   tabPanel('Network graph',
                            includeCSS('www/graph.css'),
                            includeHTML('index.html')
                            ),
                   
                   tabPanel('Repost co-occurency'),
                   
                   tabPanel('Raw data',
                            dataTableOutput('datatable'))
))