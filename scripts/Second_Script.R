library(datasets)
library(tidyverse)
ggplot(data = mtcars, mapping = aes(x = disp, y = mpg)) + 
  geom_point(mapping = aes(color = cyl)) + 
  xlab("disp") +
  ylab("mpg") + 
  labs(color = "cyl")