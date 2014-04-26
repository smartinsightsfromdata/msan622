require(ggplot2)
require(shiny)
require(reshape2)
require(scales)
require(grid)

dataset <- data.frame(Seatbelts)
dataset$total <- dataset$front + dataset$rear + dataset$drivers
dataset$time <- as.numeric(time(Seatbelts))
dataset$year <- floor(dataset$time)
dataset$month <- round(12 * (dataset$time - floor(dataset$time)) +1)
dataset <- melt(dataset,
                id.vars = c('time', 'year', 'month'),
                value.name = 'Deaths')

grey <- "#465A61"

plotOverview <- function(start = c(1969, 1971)) {  
  datas <- subset(dataset, variable == 'total')
  
  xmin <- start[[1]]
  xmax <- start[[2]]
  
  ymin <- 1000
  ymax <- 5000
  
  p <- ggplot(datas, aes(x = time, y = value))
  
  p <- p + geom_rect(xmin = xmin, xmax = xmax,
                     ymin = ymin, ymax = ymax,
                     fill = grey)
  
  p <- p + geom_line(colour = 'darkgray')
  
  p <- p + scale_x_continuous(limits = range(dataset$time),
                              expand = c(0, 0),
                              breaks = seq(1969, 1985, by = 1))
  
  p <- p + scale_y_continuous(limits = c(ymin, ymax),
                              expand = c(0, 0),
                              breaks = seq(ymin, ymax, length.out = 3))
  
  p <- p + ylab('Total deaths/injuries')
  
  p <- p + theme(panel.border = element_rect(fill = NA, colour = grey),
                 axis.title = element_blank(),
                 panel.grid = element_blank(),
                 panel.background = element_blank(),
                 text = element_text(size = 16, colour = "gray"), 
                 axis.text.x = element_text(colour = "gray"), 
                 axis.text.y = element_text(colour = "gray"),
                 axis.ticks = element_line(colour = 'gray'),
                 title = element_text(vjust = 2),
                 axis.title.x = element_text(vjust = -1.25), 
                 axis.title.y = element_text(vjust = -0.1),
                 plot.background = element_blank(),
                 panel.background = element_blank(),
                 panel.grid = element_blank(),
                 line = element_line(colour = 'gray'),
                 axis.line = element_line(colour = 'gray'),
                 legend.title = element_blank(),
                 legend.background = element_blank(),
                 legend.key = element_blank())
    
  return(p)
}

plotArea <- function(start = c(1974, 1980)) {
  
  datas <- subset(dataset, 
                  variable %in% c('front', 'rear', 'drivers'))
  
  xmin <- start[[1]]
  xmax <- start[[2]]
  
  ymin <- 0
  ymax <- 5000
  
  p <- ggplot(datas,
              aes(x = time,
                  y = value, 
                  group = variable,
                  fill = variable))
  
  p <- p + geom_area(alpha = .5)
  
  p <- p + ggtitle('Breakdown of UK vehicular deaths/injuries by year')
  
  minor_breaks <- seq(floor(xmin), 
                      ceiling(xmax), 
                      by = 1/ 12)
  
  p <- p + scale_x_continuous(limits = c(xmin, xmax),
                              expand = c(0, 0),
                              oob = rescale_none,
                              breaks = seq(floor(xmin), ceiling(xmax), by = 1),
                              minor_breaks = minor_breaks)
  
  p <- p + scale_y_continuous(limits = c(ymin, ymax),
                              expand = c(0, 0),
                              breaks = seq(ymin, ymax, length.out = 5))
  
  p <- p + ylab('Deaths/Injuries')
  
  p <- p + theme(axis.title = element_blank(),
                 panel.grid.minor = element_blank(),
                 legend.title = element_blank(),
                 legend.background = element_blank(),
                 legend.direction = "horizontal",
                 legend.position = c(0, .88),
                 legend.justification = c(0, 0),
                 legend.key = element_rect(fill = NA, color = NA, size = 1),
                 text = element_text(size = 16, colour = "gray"), 
                 axis.text.x = element_text(colour = "gray"), 
                 axis.text.y = element_text(colour = "gray"),
                 axis.ticks = element_line(colour = 'gray'),
                 title = element_text(vjust = 2),
                 axis.title.x = element_text(vjust = -1.25), 
                 axis.title.y = element_text(vjust = -0.1),
                 plot.background = element_blank(),
                 panel.background = element_blank(),
                 panel.grid = element_line(size=.1),
                 line = element_line(colour = 'gray'),
                 axis.line = element_line(colour = 'gray'),
                 legend.title = element_blank(),
                 legend.background = element_blank(),
                 legend.key = element_blank())
    
  return(p)
}

plotHeat <- function(type) {
  
  datas <- subset(dataset, variable == 'total')
  
  p <- ggplot(datas, aes(x = month,
                         y = year,
                         fill = value)) +
    geom_tile() +
    ggtitle('Monthly cycle of vehicular deaths/injuries by year') +
    scale_fill_gradient(name = 'Deaths/\nInjuries',
                        low = 'white', 
                        high = 'steelblue') +
    scale_x_discrete(breaks = c(1:12),
                     labels = month.abb,
                     limits = c(1:12),
                     expand = c(0,0)) +
    scale_y_continuous(expand = c(0,0),
                       breaks = seq(1969, max(datas$year), 1)) +
    theme(panel.background = element_blank(),
          plot.background = element_blank(),
          panel.grid = element_blank(),
          axis.title = element_blank(),
          legend.background = element_blank(),
          text = element_text(size = 20, colour = "gray"),
          axis.ticks = element_blank())
  
    if (type == TRUE) {
      p <- p + coord_polar() +
        annotate('text',
                 x = rep(1, 8),
                 y = seq(1970, 1985, 2), 
                 label = seq(1970, 1985, 2)) + 
        scale_y_continuous(limits = c(1960, max(datas$year) + 1),
                           breaks = seq(1969, 1984, 2)) +
        theme(legend.position = c(.5,.5),
              axis.text.y = element_blank())
    }
  return(p)
}