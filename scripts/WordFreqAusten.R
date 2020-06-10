# Libraries for Silge & Robinson Chapter 1 ----

library(gutenbergr)
library(tidyverse)
library(tidytext)

# Import Austen books ----

ja_books <- gutenberg_download(c(161,1342,141,158,121,105))

# Tidy Austen books ----

ja_tidy <- ja_books %>%
  unnest_tokens(word,text)

# Get word frequencies for Austen books ----

ja_word_freq <- ja_tidy %>%
  count(word,sort=TRUE)

# It might be interesting to see What happens 
# if you set sort=FALSE (or just delete "sort=TRUE")
# above.  
