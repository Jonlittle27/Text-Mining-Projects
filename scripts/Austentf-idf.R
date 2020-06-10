# Answer Key for Jane Austen tf-idf Chapter 3 ----

library(gutenbergr)
library(tidyverse)
library(tidytext)

# If you still have your ja_tidy data frame you can skip
# to the "Get Word Frequencies" part.

# Import Austen books ----

ja_books <- gutenberg_download(c(161,1342,141,158,121,105))

# Tidy Austen books ----

ja_tidy <- ja_books %>%
  unnest_tokens(word,text)

# Get word frequencies for individual Austen books ----

ja_word_freq_by_book <- ja_tidy %>%
  group_by(gutenberg_id) %>%
  count(word,sort=TRUE)

# Add tf_idf column with bind_tf_idf (and arrange big to small)

ja_tf_idf <- ja_word_freq_by_book %>%
  bind_tf_idf(word,gutenberg_id,n) %>%
  arrange(desc(tf_idf))

# Replacing the gutenberg IDs with the titles
# and column heading by "book".

ja_tf_idf <- ja_tf_idf %>%
  ungroup()  %>%
  mutate(gutenberg_id = replace(gutenberg_id, 
    gutenberg_id == '1342', 'Pride & Prejudice')) %>%
  mutate(gutenberg_id = replace(gutenberg_id, 
    gutenberg_id == '141', 'Mansfield Park')) %>%
  mutate(gutenberg_id = replace(gutenberg_id, 
    gutenberg_id == '161', 'Sense & Sensibility')) %>%
  mutate(gutenberg_id = replace(gutenberg_id, 
    gutenberg_id == '105', 'Persuasion')) %>%
  mutate(gutenberg_id = replace(gutenberg_id, 
    gutenberg_id == '121', 'Northanger Abbey')) %>%
  mutate(gutenberg_id = replace(gutenberg_id, 
    gutenberg_id == '158', 'Emma')) %>%
  rename(book = gutenberg_id)

#  Regroup and sort out top 10. 

ja_tf_idf_top10 <- ja_tf_idf %>%
  group_by(book) %>%
  top_n(10) 

# Shamelessly stealing plot code from the book

ja_tf_idf_top10 %>%
  ggplot(aes(reorder(word,tf_idf), tf_idf, fill = book)) +
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "tf-idf") +
  facet_wrap(~book, ncol = 2, scales = "free") +
  coord_flip()
