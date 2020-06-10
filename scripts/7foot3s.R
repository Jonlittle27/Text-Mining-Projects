#NBA Three Point Shooting Percentages

# Load ggplot
library(tidyverse)

# Load data set
mydata <- read.csv("Data Sets/nbastats2018-2019.csv")

# Filter data to include only players 7' tall and above who sank at least one 3point shot 
# and drop Thomash Welsh (who didn't have an NBA contract)
mydata1 <- filter(mydata, Height >= "84" & FG3. > ".3" & FG3A > "2.5" & !Name == "Thomas Welsh")

# Join the Name and Team variables together and order the names by FG3.
mydata2 <- mutate(mydata1, Name = glue::glue("{ Name } ({ Team })"), Name = fct_reorder(Name, FG3.))

#fill
fill <- c("black","gold","black","gold","black","black","black","black","black","black","black","lawngreen","black")

# Create graph
ggplot(mydata2, aes(FG3., Name, size=FG3A)) + geom_point(shape=21, colour= "black", fill=fill) +
  labs(x = "Three Point Shot Percentage",
       y = element_blank(),
       size = "Average Attempts per Game",
       title = "NBA 7' Players 3pFG% Min. 2.5 3pFGA (2018-19)",
       subtitle = element_blank())+ theme_bw()  


