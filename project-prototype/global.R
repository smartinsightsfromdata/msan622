library(ggplot2)
library(scales)
library(grid)
library(plyr)
library(reshape2)
library(rCharts)

x <- data.frame(USPersonalExpenditure)
colnames(x) <- substr(colnames(x), 2, 5)
a <- rCharts:::Highcharts$new()
a$chart(type = "column")
a$title(text = "US Personal Expenditure")
a$xAxis(categories = rownames(x))
a$yAxis(title = list(text = "Billions of dollars"))
a$data(x)
print(a)

data(economics, package = "ggplot2")
econ <- transform(economics, date = as.character(date))
m1 <- mPlot(x = "date", y = c("psavert", "uempmed"), type = "Line", data = econ)
m1$set(pointSize = 0, lineWidth = 1)
print(m1)

d <- read.csv('redditSubmissions_out.csv')
names(d)[7] <- 'upvotes'
names(d)[9] <- 'downvotes'
names(d)[12] <- 'comments'

d$unixtime <- as.POSIXlt(d$unixtime,
                         origin = "1970-01-01",
                         tz = "GMT")
d$hour <- d$unixtime$hour
#save(d, file = 'data.Rdata')
#d <- load('data.Rdata')

custom <- theme(text = element_text(size = 16, colour = "gray"), 
                axis.text.x = element_text(colour = "gray"), 
                axis.text.y = element_text(colour = "gray"),
                axis.ticks = element_line(colour = 'gray'),
                
                title = element_text(vjust = 2),
                axis.title.x = element_text(vjust = -1.25), 
                axis.title.y = element_text(vjust = -0.1),
                
                plot.background = element_blank(),
                plot.margin = unit(c(1, 1, 1, 1), "cm"),
                
                panel.background = element_blank(),
                panel.grid = element_blank(),
                
                line = element_line(colour = 'gray'),
                axis.line = element_line(colour = 'gray'),
                legend.position = 'right',
                legend.title = element_blank(),
                legend.background = element_blank(),
                legend.key = element_blank())

plotTime <- function(dataset) {
  dd <- aggregate(score ~ subreddit + hour, data = dataset, mean)
  ggplot(data = dd,
         aes(x = hour,
             y = score,
             group = subreddit,
             colour = subreddit)) +
    geom_line() +
    xlab('Time') +
    scale_x_continuous(expand = c(0,0),
                       breaks = seq(0:23),
                       labels = c(paste(seq(1,12),'am'),
                                  paste(seq(1,12),'pm'))) +
    ylab('Average Score') +
    custom
}

plotVotes <- function(dataset) {
  dd <- melt(cbind(aggregate(downvotes ~ subreddit, data = dataset, mean),
                   aggregate(upvotes ~ subreddit, data = dataset, mean))[,-3])
  n <- nPlot(value ~ subreddit,
             data = dd,
             group = 'variable',
             type = 'multiBarChart',
             dom = 'votePlot',
             width = 1000,
             height = 600)
}