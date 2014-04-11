Homework [#]: [HOMEWORK NAME]
==============================

| **Name**  | [YOUR NAME]  |
|----------:|:-------------|
| Spencer Boucher| spencer.g.boucher@gmail.com |

## Instructions ##

App can be run at [justmytwospence.shinyapps.io/homework3](http://justmytwospence.shinyapps.io/homework3) 

## Discussion ##

For this assignment I opted to use D3.js. In the case of the parallel coordinates plot and the scatterplot matrix, javascript was used directly via custom Shiny bindings. For the choropleth map, D3 was used indirectly via the rMaps package. The learning curve for these techniques was and continues to be very steep, so althought it has been a great learning experience, the visualizations are not quite as polished as I would like them to be. I will likely continue to tweak these plots in the future as I learn more about D3 and some of the more advanced Shiny internals for incorporating Javasript elements. For example, I am on my way toward using hover events in the choropleth map to change input parameters to other plots.

### Parallel coordinates

 - Parallel coordinates make it very easy to identify groups of states that score similarly across many different measures.
 - I included only numeric variables for this visualization, because categorical variables (eg region) do not bundle as well obstruct the bundling effect.
 - Color is used to highlight states or bundles of states that have been selected. A more subtle gray color makes these blue highlights stand out well.
 - Users can rearrange axes if there are two particular measures that they wish to compare more directly.
 - I make sure to provide brief instructions so that users are aware of the interactive capabilities.
 - One conclusion that can be seen is that states with low graduation rates also have higher illiteracy rates, higher murder rates, lower income, and lower life expectency.

### Choropleth
 - My heatmap implementation is geographic in nature, ie a choropleth map
 - I chose this technique because one of the most important choices when designing a regular heatmap is the ordering of the axes, but I was particularly interested in the geographical distribution of various attributes, which is hard to capture in this way.
 - 