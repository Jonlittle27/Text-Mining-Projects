# Libraries 

library(tidyverse)
library(tidytext)
library(gutenbergr)
library(wordcloud)


# Import book and create tidy, stopword-removed text ----

The_Republic_no_stop <- gutenberg_download(150) %>%
  unnest_tokens(word,text) %>% 
  anti_join(stop_words)

#text file

write.table(The_Republic_no_stop$word,"the_republic.txt",
            sep=" ", row.names = FALSE, quote = FALSE)

