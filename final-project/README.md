Final Project
==============================

*Spencer Boucher*

## Discussion ##

This dataset is a collection of 132,308 reddit.com submissions. Each submission is of an image, which has been submitted to reddit multiple times. Each submission includes features such as the number of ratings (positive/negative), the submission title, and the number of comments it received. The splash page of my visualization links to the original data (via Stanford University), as well as a short informative video that explains Reddit to users who may be unfamiliar. The full data set can be browsed interactively in the final page of my visualization (Raw Data).

|Dataset statistics |  |
|-------------------|------------|
|Number of submissions | 132,308|
|Number of unique images | 16,736|
|Average number of times an image is resubmitted | 7.9|
|Timespan | July 2008 -- January 2013|

|Variables |   |
|---------|----|
|image_id | id of the image, submissions with the same id are of the same image |
|unixtime | time of the submission (unix time) |
|rawtime  | raw text of the time |
|title    | submission title |
|total_votes | number of upvotes + number of downvotes |
|reddit_id | id of the submission on reddit, e.g. reddit.com/14c3ls |
|number_of_upvotes | number of upvotes |
|subreddit | subreddit, e.g. reddit.com/r/pics/ |
|number_of_downvotes | number of downvotes |
|localtime | local time of the submission (unix time) |
|score | number of upvotes - number of downvotes |
|number_of_comments | number of comments the submission received |
|username | name of the user who submitted the image e.g. www.reddit.com/user/thatseffedup |

The dataset was cleaned of a few syntax/encoding errors using the `csvclean` command line utility.The data was then munged and visualized using a combination of `R`, `shiny`, `ggplot`, `Python`, `Pandas`, `NetworkX`, and (indirectly) `D3.js`.

The full, interactive visualization is theoretically available at [https://justmytwospence.shinyapps.io/final-project](https://justmytwospence.shinyapps.io/finalproject). If any issues are encountered, it can be run locally like so:
```r
library(shiny)
runGitHub('msan622', 'justmytwospence', subdir='final-project')
```
Some packages may be necessary to install, act upon corresponding error messages.

### Techniques ###

#### Grouped bar chart ####

The first thing that I wanted to look at was the simple number of interactions that submissions get in different subreddits. The three main types of interactions that a submission can get are an upvote, a downvote, and a comment, so I created a barch chart that displays the respective means of all three of these, grouped by subreddit. Each type of interaction gets its own color, and I made sure to make the color for comments substantially different than that of upvotes or downvotes, because is it a different beast entirely. The user can choose to stack the bars or to lay them out side by side. The stacked view is great for getting an overall sense of which subreddits receive the most interactions, while the unstacked view is great for comparing the *ratio* of upvotes and downvotes within a particular subreddit. The tradeoff here is that it is slightly more difficult to compare ratios *between* subreddits than if I were to explicitly map the ratio itself to an aesthetic.

There is a bit of lie factor in this chart, but it is a lie of omission, rather than a distortion. The height of the bars is mapped to an average measure for each type of interaction. These averages are calculated with different (sometimes substantially different) sample sizes. Therefore, not every pair of subreddits is truly comparable. One way to partially account for this would be to include standard error bars. While this was simple to implement in a static `ggplot2` chart, implementing error bars in an interactive chart proved to be much trickier, so they are not included although they would be in my ideal visualization.

#### Grouped line chart ####

Next, I wanted to see if there was any clear trend in how submissions tend to fare based upon their time of submission. To accomplish this, I extracted the hour from each submission's Unix time stamp and, for each subreddit, aggregated all submissions by hour (ie, 24 bins). Note that although submissions originate from a wide range of time zones, using a single time zone (UTC) can be justified by the fact that Reddit is a global phenomenon and submissions therefore have a global audience immediately regardless of the local time when a submission is made.

The lie factor that was an issue with the grouped bar chart is addressed here. By calculating the aggregated standard error in addition to the aggregated mean, our line chart can be augmented witha ribbon reflecting the standard error at any given hour (ie, our confdence in the aggregated mean). New issues are introduced however. Some subreddits do not have a sufficient number of submissions to aggregate or even plot effectively after binning into 24 hours. I therefore limit the number of subreddits that I allow the user to inspect in this chart, introducing a threshold for the number of submissions that a subreddit must contain.

#### Force layout ####

Now for some network stuff. We can use a physics simulation to see which subreddits tend to cluster together (also known as a force layout). I present the user with four different force layouts, the only difference being the number of cross-posted submissions that two subreddit must share before they become linked by an edge in the simulation. After manually inspecting lots of different force layouts and tweaking this parameter (among others), I settled upon thresholds of 50, 100, and 1000. This visualization technique is actually much more insteresting that I was expecting. Honestly, I thought a hairball was in store, but there is obvious structure in the result. There are two clear groups in the graph: those subreddits that cross-post with the "pics" subreddit, and those that cross-post with the "funny" subreddit. This is what we would expect to see if these two subreddits either reposts from many different *other* subreddits, or alternatively if their submissions are subsequently reposted in many other subreddits. Indeed, we will see shortly in the upcoming Sankey diagram that the latter is the case. I find it very interesting to browse which subreddits are linked to "funny," which are linked to "pics," and which are linked to *both*.

Obviously I could have chosen to weight the width of the edges according to the number of cross-posted submissions between two nodes, but this needlessly complicated the network, and I rather prefer the simple message outlined above.

#### Sankey diagram ####

This is my favorite visualization, and gets at what I cared about most in the first place: how do image submissions *"flow"* through different subreddits? Which subreddits usually the first to have original content? Which other subreddits does a particular subreddit get its content from? For the sake of visualization, I make the rather large but not entirely unreasonable assumption that if a submission appears in one subreddit *after* it already appeared in a previous subreddit, the second subreddit "received" that content from the original subreddit. The munging necessary to convert the tabular, time-stamped data into a directed graph was an interesting task; this code can be found in the ipython notebook `graph.json`, suffice to say it involved Pandas, itertools, and NetworkX.

Once the data was in the right format, I used the D3 wrapper package `d3Network` to create the Sankey diagram. My sankey diagram is slightly unconventional in that it is "tiered," meaning that a node can appear multiple times -- for example it might have a node on the far left representing all the submissions that *originated* there, and again in the second tier when it is the *second* subreddit to feature a particular piece of content. I make sure to map each subreddits node color to its identity in an effort to make sure this property of the diagram is not lost on the user; I believe it to be fairly effective in this regard.

The only lie factor in this diagram is a consequence of the fact that I "trimmed" the underlying ddirected graph to remove very small edges. Therefore the entire graph is not represented, but the most important pieces are. There is quite a bit of information in this visualization and it is pretty good at conveying a sense of the *overall* submission flow, but one limitation is that the path of individual submissions cannot be traced. Additionally, it cannot be determined *which* of a node's input edges corresponds to which of that node's output edges.

- How you encoded the data (i.e. mapping between columns and preattentive attributes)

- An evaluation of its lie factor, data density, and data to ink ratio

- What you think the visualization excels at (e.g. showing an overview of the dataset, identifying outliers, identifying patterns or trends, identifying clusters, comparison, etc.)

- What _you_ learned about the dataset from the visualization

This discussion should be approximately 2 to 5 paragraphs for each visualization, and this will heavily influence your score for this visualization.

### Interactivity ###

It is my personal perspective that a visualization should not provide interactivity without a particular reason for doing so. I therefore avoided willy nilly zooming, subsetting, and especially aesthetic interactivity. Rather, I curated the particular things that I found to be the most interesting/important. There are two key interactive components here. First is the ability for the user to select and inspect the particular subreddits that they are interested in, which is available in both the grouped bar chart and the grouped line chart. The second is the ability to select the metric(s) of interest, also available in both the grouped bar chart and the grouped line chart.

Please include an "Interactivity" section where you discuss the interactivity implemented in your project. Please discuss the following:

- The type(s) of interactivity you implemented

- How the interactivity enhances your visualization(s)

For example, interactivity can help provide focus or context, help overcome overplotting issues, decrease or increase data density, and so on. This discussion should be approximately 2 to 5 paragraphs, depending on the amount of interactivity you implemented.

### Prototype Feedback ###

The original prototype that I demonstrated included only a less sophisticated grouped line chart, and several of my experimentations with various network visualizations. The most important feedback I received was confirmation that an inclusion of standard error in my aggregations was necessary. Additionally, it was great to talk through different ways of visualizing the "flow" piece of the equation. The idea for the Sankey diagram did not come up during the review, but our conversation got my gears spinning and encouraged me to keep thinking outside of the box. 

### Challenges ###

My biggest challenges were learning to use several pacakges that were new to me, including `Rcharts` and `d3Sankey`. `d3Sankey`, in particular, assigns its data objects to the same Javascript variables every time a new plot is instantiated. Lacking the time to dig into the code and fix this, I sidestepped the issue by using one of the plots within an `iframe` (although I might still fix the issue and create a pull request for the package). Data quality was also an issue until I resolved it using the `csvkit` suite of command line utilities.
