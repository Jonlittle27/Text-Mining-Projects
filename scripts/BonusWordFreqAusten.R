##Libraries

library(gutenbergr)
library(tidyverse)
library(tidytext)

##Word Frequency Austen Books

ja2_word_freq <- gutenberg_download(c(161,1342,141,158,121,105))%>%
  unnest_tokens(word,text) %>%
    count(word,sort=TRUE)


