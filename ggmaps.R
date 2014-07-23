## ggmap package has wrappers for accessing google maps' API

library(ggmap)
library(ggplot2)

## need a 2x2 matrix defining   min(lon), max(lon)
##                              min(lat), max(lat)

## eg

box <- matrix(c(-2, -1, 52, 53), byrow = TRUE, nrow = 2)


map <- ggmap(get_map(location = box))

plot(map)


## so we can find a box for the twitter data (for example)

twitter <- xap.read_table("twitter_feed")

twitter_box <- matrix(c(min(twitter$coordinates_coordinates_0), max(twitter$coordinates_coordinates_0), min(twitter$coordinates_coordinates_1), max(twitter$coordinates_coordinates_1)), byrow = TRUE, nrow = 2)


twitter_map <- ggmap(get_map(location = twitter_box))


## use ggplot to add data from the twitter dataset to the base layer (this is just a random 1000 tweet locations



twitter_sample <- twitter[sample(1:nrow(twitter), 1000), ]

twitter_plot <- twitter_map + geom_point(data = twitter_sample, aes(x = coordinates_coordinates_0, y = coordinates_coordinates_1), cex = 1)


plot(twitter_plot)


## ?get_map to see more options for google api (note only google api works) 
