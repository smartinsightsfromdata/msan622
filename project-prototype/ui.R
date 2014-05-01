library(shiny)
library(ggplot2)

shinyUI(navbarPage('Secrets of Reddit', inverse = TRUE,
                   
                   tabPanel('About',
                            fluidRow(
                              column(width = 5, offset = 1,
                                p('Reddit /ˈrɛdɪt/, stylized as reddit, is an entertainment, social networking service and news website where registered community members can submit content, such as text posts or direct links. Only registered users can then vote submissions "up" or "down" to organize the posts and determine their position on the site\'s pages. Content entries are organized by areas of interest called "subreddits".')
                              ),
                              column(width = 4,
                                div(HTML('<iframe width="560" height="315" src="//www.youtube.com/embed/tlI022aUWQQ" frameborder="0" allowfullscreen></iframe>'))
                              )
                            )),
                   
                   tabPanel('By time',
                            sidebarLayout(
                              
                              sidebarPanel(width = 2,
                                           uiOutput('subset')),
                              
                              mainPanel(width = 10,
                                titlePanel('Effect of submission time on score'),
                                plotOutput('timePlot'))
                                
                            )),
                   
                   tabPanel('By subreddit'),
                   
                   tabPanel('Network graph',
                            includeHTML('curved.html'),
                            div('curved',
                                class='curved',
                                tag('svg', ''))
                            ),
                   
                   tabPanel('Repost co-occurency'),
                   
                   tabPanel('Raw data',
                            dataTableOutput('datatable'))
))