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
                                HTML('<a style="text-decoration: none" href="http://spencerboucher.com"><h4>My Blog</h4></a>
                                      <a style="text-decoration: none" ref="http://snap.stanford.edu/data/web-Reddit.html"><h4>The Data</h4></a>')
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

                   tabPanel('Network graph',
                            includeCSS('www/graph.css'),
                            fluidRow(
                              column(width = 10, offset = 1,
                                     gsub("label class=\"radio\"", "label class=\"radio inline\"",radioButtons('threshold',
                                                 'How many cross-posts necessary to link two subreddit nodes?',
                                                 choices = c('50', '100', '1000'))))),
                            fluidRow(
                              column(width = 10, offset = 1,
                                     htmlOutput('networkPlot')))
                            ),

                   tabPanel('Flow', height=1000,
                            fluidRow(column(width = 8, offset = 2,
                                            p('Images are originally submitted to the subreddits on the left. With each subsequent submission, the "flow" to the right.'))),
                            fluidRow(column(width = 8, offset = 2,
                                            HTML('<iframe src="sankey.html" height=642 width=824 frameBorder="0"></iframe>'),
                                            tags$iframe(src = 'sankey.html',
                                                        scrolling = 'no',
                                                        seamless = NA,
                                                        height=642,
                                                        width=824)))
                            ),

                   tabPanel('Raw data',
                            dataTableOutput('datatable'))
))
