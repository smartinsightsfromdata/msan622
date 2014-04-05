Homework 2: Interactivity
=========================
**Spencer Boucher - sboucher@usfca.edu**

This app can be accessed at [justmytwospence.shinyapps.io/homework2](https://justmytwospence.shinyapps.io/homework2).

Design notes:
- I decided to use a darker UI because (besides being a personal preference), it is easier on the eyes for extended periods of time.
- I removed the grid lines because the intended purpose here is not to look up the locations of particular data points, merely to identify patterns.
- A log scale makes it easier to see patterns on the lower end of the budget range, where there is otherwise a great deal of overplotting.
- Care was taken to ensure that colors and axes ranges remain static when changing views on the data, to avoid jarring or confusing movement/visual discrepancies.
- With that said, the legend still changes when the view on the data changes. Ideally, I would color the UI elements themselves (ie, the genre names next to the checkboxes), but I felt this tweak fell on the wrong side of the [80/20 rule](https://en.wikipedia.org/wiki/Pareto_principle) for this assignment.
- I default the dot size and dot alpha sliders to values that make sense to me.
- A tabbed view allows me to display the underlying data, which is always best to do whenever possible. 
- The data tables in this tab display only the subset of data that has been selected in the UI; this is about as close to the "global/detail" paradigm as I can get in this context without mouseovers and or brushing, which together would have been my first choices.
