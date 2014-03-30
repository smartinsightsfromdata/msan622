library(shiny)
library(ggplot2)
library(scales)
library(grid)

# Munging
data(movies)
movies <- subset(movies, budget > 0)
genre <- rep(NA, nrow(movies))
count <- rowSums(movies[, 18:24])
genre[which(count > 1)] = "Mixed"
genre[which(count < 1)] = "None"
genre[which(count == 1 & movies$Action == 1)] = "Action"
genre[which(count == 1 & movies$Animation == 1)] = "Animation"
genre[which(count == 1 & movies$Comedy == 1)] = "Comedy"
genre[which(count == 1 & movies$Drama == 1)] = "Drama"
genre[which(count == 1 & movies$Documentary == 1)] = "Documentary"
genre[which(count == 1 & movies$Romance == 1)] = "Romance"
genre[which(count == 1 & movies$Short == 1)] = "Short"
movies$genre <- factor(genre)

# Themeing  
logspace <- function( d1, d2, n) exp(log(10)*seq(d1, d2, length.out=n))
support <- logspace(0,8,9)
custom <- theme(text = element_text(size = 16, colour = "gray"), 
                axis.text.x = element_text(colour = "gray"), 
                axis.text.y = element_text(colour = "gray"),
                
                title = element_text(vjust = 2),
                axis.title.x = element_text(vjust = -1.25), 
                axis.title.y = element_text(vjust = -0.1),
                
                plot.background = element_blank(),
                plot.margin = unit(c(1, 1, 1, 1), "cm"),
                
                panel.background = element_blank(),
                panel.grid = element_blank(),
                
                line = element_line(colour = 'gray'),
                axis.line = element_line(colour = 'gray'),
                legend.position = 'none')

shinyServer(function(input, output) {
  
  output$mpaa <- renderUI({
    mpaas <- levels(movies$mpaa)[levels(movies$mpaa) != '']
    radioButtons('mpaa', 'MPAA Rating',
                 choices = c('All', mpaas),
                 selected = 'All')
  })
  
  output$genres <- renderUI({
    genres <- levels(movies$genre)
    checkboxGroupInput('genres', 'Genres', 
                       choices  = genres)
  })
  
  output$plot <- renderPlot({
    
    if(is.null(input$mpaa)) {
      return()
    }  
    
    if (input$mpaa != 'All' & length(input$genres) != 0) {
      dataset <- subset(movies,
                        mpaa == input$mpaa & genre %in% input$genres)
    } else if (input$mpaa != 'All') {
      dataset <- subset(movies,
                        mpaa == input$mpaa)
    } else if (length(input$genres) != 0) {
      dataset <- subset(movies, 
                        genre %in% input$genres)
    } else {
      dataset <- movies
    }

    p <- ggplot(data = dataset, 
                aes(x = budget,
                    y = rating,
                    colour = genre)) +
      geom_point(#colour = 'gray',
        alpha = input$dot_alpha,
        size = 1 + (input$dot_size / 3)) +
      scale_x_log10(breaks=support,
                    labels=paste0(dollar(support/1000), 'k'),
                    limits=c(min(movies$budget, na.rm = T),
                             max(movies$budget, na.rm = T))) +
      scale_y_continuous(breaks=0:10,
                         expand=c(0,0),
                         limits=c(0,10.5)) +
      annotation_logticks(sides='b',
                          colour = 'gray') +
      ggtitle('Overall relationship between budget and rating') +
      xlab('Budget in thousands') + ylab('Average Rating') +
      custom
    print(p)
    
  }, bg = 'transparent')
  
})