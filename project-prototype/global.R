library(ggplot2)
library(plyr)

d <- read.csv('redditSubmissions_out.csv')
d$unixtime <- as.POSIXlt(d$unixtime, origin = "1970-01-01", tz = "GMT")
d$hour <- d$unixtime$hour

ggplot(data = d,
       aes(x = number_of_downvotes,
           y = number_of_upvotes)) +
  geom_point()

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
    theme_bw()
}

qplot(tapply(d$score, d$subreddit, mean), geom='density')
