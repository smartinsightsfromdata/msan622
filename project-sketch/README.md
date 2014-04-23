Project Sketch
==============================

Planned Tools
------------------------------

I am planning on using D3.js most of the visualization. Mike Bostock and others have beautiful examples of the types of network graphics I would like to create that will serve as a good starting point. I *might* wrap D3 in the Shiny framework to use some of the Shiny UI components, ie buttons and sliders, but I think this will end up being easier to implement in pure HTML/Javascript, based on previous experience trying to shim D3 into Shiny for Homework #3.

Planned Techniques
------------------------------

I plan on visualizing the PubMed papers by looking at two networks, the co-occurence of key words in the titles and the co-occurence of authors. For the author co-occurence network, I plan on using a hierarchical edge binding layout like the one implemented here:

[http://mbostock.github.io/d3/talk/20111116/bundle.html](http://mbostock.github.io/d3/talk/20111116/bundle.html)

There are many many authors that have published in the PubMed archives, so I will likely need to threshold the authors that I choose to include in the visualization according to their prolificness. Additionally, the time frame that is visualized at any moment will be Nfilterable, making it somewhat of a time series visualization as well, and I might implement a limit on the total number of years that can be selected at once to further prevent overplotting.  

The co-occurency of title keywords will be visualized using a hive plot, which collects nodes along particular categorical axes before creating the edges and allows those edges to affect the layout of the axes. This layout has also been implemented in D3:

[http://bost.ocks.org/mike/hive/](http://bost.ocks.org/mike/hive/)

Time filtering will be similarly incorporated. I will use field of study as the axes of the hive plot.

Planned Interaction
------------------------------

Network edges in both plots will be highlightable on hover events. A tooltip might also be included for hover events presenting the full title of the article. UI components will include a time filter / animation slider and a keyword filter text box for the hierarchical edge plot.

Planned Interface
------------------------------

![sketch](https://github.com/justmytwospence/msan622/blob/master/project-sketch/sketch.png?raw=true)
