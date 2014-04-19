Homework 4: Text
==============================

| **Name**  | Spencer Boucher  |
|----------:|:-------------|
| **Email** | spencer.g.boucher@gmail.com |

## Discussion ##

First I wrote a script `scrape-sotu.py` that programmatically extracts the content of each SOTU address and saves them to the data directory `sotu`. I was interested in seeing how the most frequent keywords in the SOTU have changed over the past 200 years. After the scraping procedure, I loaded the resulting 233 text documents into a corpus using the `tm` package. I used a fairly standard preprocessing pipeline, including the removal of punctuation/stop words and stemming. I spent some time attempting to implement a lemmatizer rather than a stemming algorithm, but the only R implementation that I could find is contained within the `wordnet` package, which I had difficulty incorporating because it uses its own data structure distinct from the corpora in the `tm` package.

### Outliers ###

Because I was interested in the SOTU corpus *changes* over time, I coerced the term document matrix into a dataframe and melted it down to a longer format to appease `ggplot2`. For each word in the term document matrix, I calculated a crude but effective index of "outlieriness" by subtracting the word's mean frequency from its maximum frequency. I then plotted a multiple line chart for the words that ranked highest according to this measure. To improve the data-to-ink ratio, I removed unnecessary vertical grid lines, leaving only the major horizontal gridlines and tick marks. I only label the time axis every decade, as opposed to every year. I opted to remove the title of the x axis entirely, because I feel context is sufficient to immediately assume that the numbers are dates. The most interesting design choice that I made was to completely remove the legend. Because the entire point of the visualization is to look at the *outliers*, I simply annotated the outlying point for each word. This reduces the eye movement necessary to consume the plot and frees up more space for the actual line chart, not to mention the fact that the colors would have been hard to use on their own anyways. Lastly, this chart is best viewed with a slightly higher aspect ratio than most plots that I usually generate.

![Outliers](https://github.com/justmytwospence/msan622/blob/master/homework4/outliers.png?raw=true)

I belive that this plot has a very apparent and interesting interpetation. Essentially every frequency outlier can be associated with a particular American war, whether it be the Mexican War, World War I, World War II, or the Cold War. The particular words associated with each ware are also telling. For example, the frequency outliers of World War II are "dollar" and "war", whereas for the Cold War, we see "nation", "congress", and especially "program". There is a clear story to be found here, and ideally the plot would accompany an article or short text blurb that makes this point.

### Wordcloud ###

Rather than creating a single wordcloud, I used a comparison wordcloud to create an alternative view of the SOTU over time theme of the previous plot. One could make the argument that a wordcloud complements the multiple line graph nicely because the wordcloud has a higher resolution for any one SOTU (it can include more words than I would feel comfortable plotting together as lines for any one year), but it's resolution in the time domain is much lower (I'm much more limited in the number of years that I can actually compare clouds of side by side). I decided to include **four** SOTU speeches to compare in the wordcloud(s), equally spaced from George Washington's first in 1790 through Barack Obama's in 2014.
