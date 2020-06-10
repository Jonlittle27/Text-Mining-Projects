# Libraries for Silge & Robinson Chapter 1 ----

library(gutenbergr)
library(tidyverse)
library(tidytext)
 
# Import Austen books ----

ja_books <- gutenberg_download(c(161,1342,141,158,121,105))

# Tidy Austen books ----

ja_tidy_no_stop <- ja_books %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words)

# Get word frequencies for Austen books ----

ja_word_freq_no_stop <- ja_tidy_no_stop %>%
  count(word,sort=TRUE)

# Create basic barplot for no-stopwords Austen books ----

barplot(top_n(ja_word_freq_no_stop,10)$n,names=top_n(ja_word_freq_no_stop,10)$word)

# Of course if you want to see more words just change
# the "10" above, or take a look at the 
# ja_word_freq_no_stop table.