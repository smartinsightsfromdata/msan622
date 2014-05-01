Project Prototype
==============================

For this assignment, you must:

- **Produce one static visualization prototype.** You will receive detailed feedback from your classmates on this prototype, so choose wisely.

- **Develop a `shiny` interface prototype for your desired interaction.** The controls do not need to actually work yet, just focus on which UI elements you want to use.

Ideally, these would be based on your project sketch. 

## Discussion ################

This dataset is a collection of 132,308 reddit.com submissions. Each submission is of an image, which has been submitted to reddit multiple times. For each submission, features include the number of ratings (positive/negative), the submission title, and the number of comments it received.

|Number of submissions | 132,308 |
|Number of unique images | 16,736 |
|Average number of times an image is resubmitted | 7.9 |
|Timespan | July 2008 - Jan 2013 |

|Variable|Description|
|---|---|
|image_id| id of the image, submissions with the same id are of the same image|
|unixtime| time of the submission (unix time)|
|rawtime| raw text of the time|
|title| submission title|
|total_votes| number of upvotes + number of downvotes|
|reddit_id| id of the submission on reddit, e.g. reddit.com/14c3ls|
|number_of_upvotes| number of upvotes|
|subreddit| subreddit, e.g. reddit.com/r/pics/|
|number_of_downvotes| number of downvotes|
|localtime| local time of the submission (unix time)|
|score| number of upvotes - number of downvotes|
|number_of_comments| number of comments the submission received|
|username| name of the user who submitted the image e.g. www.reddit.com/user/thatseffedup|

After some minor data cleanup with the `csvclean` utility, I used the `networkx` python module to generate the graph structure and export it to a D3-friendly JSON format.

## Submission ################

Submit your R source code (and any required images) in a `project-prototype` directory within your `msan622` repository on GitHub. Make sure to include a `README.md` file with your name, email, and discussion.

After all of the necessary files are pushed to your repository, submit a link to your `project-prototype` directory on Canvas.

## Exercise ##################

We will have small-group exercises to evaluate your prototypes during class. Please check the announcements for details.
