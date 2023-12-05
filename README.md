# Palmer Penguins App

[Link to new version of the app for assignment B4](https://christinec.shinyapps.io/shinyappB4/)  


[Link to old version of the app](https://christinec.shinyapps.io/palmerpenguinsapp/)
## Overview

The Palmer Penguin App can be used as an exploratory tool or for research purposes that involve looking at penguins that live on the islands Biscoe, Dream, and Torgensen within the Palmer Archipelago of Antarctica between the years 2007 to 2009. The penguin species include Adelie, Chinstrap, and Gentoo. Users can view results based on selected species, islands, various ranges for bill depth, bill length, and flipper length. It also helps visualize the data in a histogram corresponding to the body mass of the penguins and a scatter plot for penguin bill size. Users can also interact with the results table below the graph and download the table in a csv file for further analysis. 

### App Features

1. **Bill depth and Flipper length range selection**: Users can select the desired range for penguin bill depth and flipper length measured in mm.

2. **Bill length range input selection**: Users can input the desired numeric range for penguin bill length with a minimum and maximum length measured in mm.

3. **Species selection**: Users can select to view measurement results of their desired penguin species. 

4. **Island selection**: Users have the option to filter results by islands or have a broad overview by selecting the "all islands" option.

5. **Display of total number of penguins**: At the top of the graph, users are shown the total number of penguins that match their search criteria. Will display 0 if there are no results found. 

6. **Graph of filtered penguins by body mass**: A histogram that shows the distribution of body mass in grams of the filtered penguins searched.

7. **Graph of filtered penguins by bill size**: A scatter plot that shows the bill size of penguins by their bill length and depth. 

8. **Graphs organized under tabs**: Graphs generated from the filtered search are organized under their respective tabs that users can select to view. 

9. **Interactive table of results**: At the bottom of the graph, there is an interactive table that shows the all the results including more information on each individual penguin. 

10. **Downloadable results**: Users can download their search results in a csv file to do more analysis on their own. The downloaded table contains additional information related to the sex of the penguin and the year the data was collected. Users can choose to keep or delete the additional information or include them in their analysis.  


## Data Source

The dataset used in this app is from the [palmerpenguins R package](https://github.com/allisonhorst/palmerpenguins) developed by Allison Horst, Alison Hill, and Kristen Gorman.

[More information on Palmerpenguins here](https://allisonhorst.github.io/palmerpenguins/)

The dataset is publicly available and meant to allow for data exploration and visualization. You can install the `palmerpenguins` package in R and access the data with install.packages("palmerpenguins").

## Acknowledgements 

Shiny app tutorial: Dean Attali [Shiny app tutorial](https://deanattali.com/blog/building-shiny-apps-tutorial/)

Artwork by @allison_horst
