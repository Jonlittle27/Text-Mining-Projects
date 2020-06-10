# Libraries for Silge & Robinson Chapter 1 ----

library(tidyverse)
library(tidytext)
library(gutenbergr)
library(wordcloud)

# Import book and create tidy, stopword-removed text ----

invman_tidy_no_stop <- gutenberg_download(5230) %>%
  unnest_tokens(word,text) %>% 
  anti_join(stop_words)

# Create word frequency table 
# (for wordcloud R package, don't need this for 
#   wordcloud.com)

invman_freq <- invman_tidy_no_stop %>%
  count(word,sort=TRUE)

# Create (very) basic wordcloud using the wordcloud package ----

invman_freq %>%
  with(wordcloud(word, n, max.words = 100))

# Create text file for wordcloud.com ----

write.table(invman_tidy_no_stop$word,"invisible_man.txt",
            sep=" ", row.names = FALSE, quote = FALSE)

# FYI, the last line ensures that in the txt file
# (1) words are separated with spaces
# (2) row names are not included with the words, and  
# (3) there are no quotes around the words.