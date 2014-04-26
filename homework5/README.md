Homework [#]: [HOMEWORK NAME]
==============================

| **Name**  | Spencer Boucher  |
|----------:|:-------------|
| **Email** | sboucher@dons.usfca.edu |

## Instructions ##

[The app can be run live at here.](http://justmytwospence.shinyapps.io/homework5)

## Discussion ##

I chose to use a stacked area plot and a heatmap.

#### Area plot ####
I really like the overview-detail features of the area chart starter code, so I used it 
as a starting point. I do not, however, particularly care for the "animations" that 
Shiny produces; I find them a little janky and distracting. Therefore, I removed the 
animation option and instead provide a double ended time range slider bar. This actually
provides the user with **more** flexibility about how they want to view the data. Then I
moved the legend so that it no longer overlays the chart itself.

On the overview, I display total deaths only, while displaying the full breakdown in the 
detail view. A key feature that I did not have time to implement would be a rectangular 
annotation in either the overview or the overview and detail views that marked the period
of time after 1983 when the seatbelt law had been enacted.

#### Heat map ####

I provide an interactive option to view the heatmap in a rectangular layout **or** in 
a radial layout. I present the rectangular layout first, because it can be intuitively
understood more quickly and easily, but the radial layout communes with the cyclical 
nature of the data in a way that the rectangular layout does not. The default y-axis 
for the radial layout is terribly confusing, so I removed it and annotated over the 
plot itself instead. Areas aren't being compared in this type of visualization, but the
area distortion is still needlessly distracting because viewers might **think** that it
is important. Therefore, I limit the distortion by cutting a chunk out of the middle. I
eventually decided to put the legend in that negative space for mazimum efficiency, but
this placement runs the risk of feeling gimmicky.
