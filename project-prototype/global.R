library(ggplot2)
library(scales)
library(grid)
library(plyr)
library(reshape2)
library(rCharts)
library(RCurl)
library(d3Network)

d <- read.csv('redditSubmissions_out.csv')
d$unixtime <- as.POSIXlt(d$unixtime,
                         origin = "1970-01-01",
                         tz = "GMT")
d$hour <- d$unixtime$hour
names(d) <- c('Image_ID', 'Time', 'Rawtime', 'Title', 'Total_votes', 'Reddit_ID', 'Upvotes', 'Subreddit', 'Downvotes', 'Local_time', 'Score', 'Comments', 'Username', 'Hour')

popular <- by(d, d$Subreddit, nrow)
popular <- names(popular)[popular > 100]
popular <- subset(d, Subreddit %in% popular)
popular$Subreddit <- droplevels(popular$Subreddit)
#save(d, file = 'data.Rdata')
#d <- load('data.Rdata')

nodes <- JSONtoDF(file = 'sankey.json', array = 'nodes')
links <- JSONtoDF(file = 'sankey.json', array = 'links')
#index <- as.numeric(row.names(nodes)[nodes$id == '0pics']) - 1
#links <- subset(links, source == index & weight > 1)
#nodes <- data.frame(id = c(nodes[unique(links$target) + 1, ]

custom <- theme(text = element_text(size = 16, colour = "#ece9d7"), 
                axis.text.x = element_text(colour = "#ece9d7"), 
                axis.text.y = element_text(colour = "#ece9d7"),
                axis.ticks = element_line(colour = '#ece9d7'),
                
                title = element_text(vjust = 2),
                axis.title.x = element_text(vjust = -1.25), 
                axis.title.y = element_text(vjust = -0.1),
                
                plot.background = element_blank(),
                plot.margin = unit(c(1, 1, 1, 1), "cm"),
                
                panel.background = element_blank(),
                panel.grid.minor.x = element_blank(),
                panel.grid = element_line(size=.1),
                
                line = element_line(colour = '#ece9d7'),
                axis.line = element_line(colour = '#ece9d7'),
                
                legend.position = 'top',
                legend.direction = 'horizontal',
                legend.title = element_blank(),
                legend.background = element_blank(),
                legend.key = element_blank())

plotTime <- function(dataset, type) {
  stderror <- function(x) { sd(x, na.rm = TRUE) / length(x) }
  dd <- cbind(aggregate(as.formula(paste(type, ' ~ Subreddit + Hour')), data = dataset, mean),
              sd = aggregate(as.formula(paste(type, ' ~ Subreddit + Hour')), data = dataset, stderror)[,3])
  ggplot(data = dd,
         aes_string(x = 'Hour',
                    y = type,
                    group = 'Subreddit')) +
    geom_line(aes(colour = Subreddit)) +
    geom_ribbon(aes_string(ymin = paste(type, ' - sd'),
                           ymax = paste(type, ' + sd'),
                           fill = 'Subreddit'),
                alpha = .5) +
    xlab('Time') +
    scale_x_continuous(expand = c(0,0),
                       breaks = 0:23,
                       labels = c('12 am',
                                  paste(seq(1, 11),'am'),
                                  '12 pm',
                                  paste(seq(1, 11),'pm'))) +
    ylab('Average Score') +
    scale_y_continuous(expand = c(0,0)) +
    custom
}

plotVotes <- function(dataset) {
  dd <- melt(cbind(aggregate(Downvotes ~ Subreddit, data = dataset, mean),
                   aggregate(Upvotes ~ Subreddit, data = dataset, mean)[,-3],
                   aggregate(Comments ~ Subreddit, data = dataset, mean)))
  n <- nPlot(value ~ Subreddit,
             data = dd,
             group = 'variable',
             type = 'multiBarChart',
             dom = 'votePlot',
             width = 1200,
             height = 600)
}