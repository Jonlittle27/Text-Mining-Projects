#Libraries
library(gutenbergr)
library(tidytext)
library(tidyverse)

#Importing books
##Import Austen Books

ja_books <- gutenberg_download(c(161,1342,141,158,121,105))

hgw_books <- gutenberg_download(c(35,36,159,5230))

bs_books <- gutenberg_download(c(767,768,969,1260,9182))



#Word Frequencies grouped by Gutenberg ID
ja_word_freq <- ja_books%>% 
  unnest_tokens(word,text)%>%
  group_by(gutenberg_id)%>%
  count(word,sort=TRUE)

hgw_word_freq <- hgw_books%>%
  unnest_tokens(word,text)%>%
  group_by(gutenberg_id)%>%
  count(word,sort=TRUE)

bs_word_freq <- bs_books%>%
  unnest_tokens(word,text)%>%
  group_by(gutenberg_id)%>%
  count(word,sort=TRUE)

#Adding tf-idf columns and values
ja_tf_idf <- ja_word_freq %>%
  bind_tf_idf(word,gutenberg_id,n) %>%
  arrange(desc(tf_idf))

hgw_tf_idf <- hgw_word_freq %>%
  bind_tf_idf(word,gutenberg_id,n) %>%
  arrange(desc(tf_idf))

bs_tf_idf <- bs_word_freq %>%
  bind_tf_idf(word,gutenberg_id,n) %>%
  arrange(desc(tf_idf))

#Replacing gutenberg IDs with book titles and renaming the column head
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

hgw_tf_idf <- hgw_tf_idf %>%
  ungroup()  %>%
  mutate(gutenberg_id = replace(gutenberg_id, 
                                gutenberg_id == '35', 'The Time Machine,')) %>%
  mutate(gutenberg_id = replace(gutenberg_id, 
                                gutenberg_id == '36', 'The War of the Worlds')) %>%
  mutate(gutenberg_id = replace(gutenberg_id, 
                                gutenberg_id == '159', 'The Islan of Doctor Moreau')) %>%
  mutate(gutenberg_id = replace(gutenberg_id, 
                                gutenberg_id == '5230', 'The Invisibile Man')) %>%
  rename(book = gutenberg_id)

bs_tf_idf <- bs_tf_idf %>%
  ungroup()  %>%
  mutate(gutenberg_id = replace(gutenberg_id, 
                                gutenberg_id == '767', 'Agnes Grey')) %>%
  mutate(gutenberg_id = replace(gutenberg_id, 
                                gutenberg_id == '768', 'Wuthering Heights')) %>%
  mutate(gutenberg_id = replace(gutenberg_id, 
                                gutenberg_id == '969', 'The Tennant of Wildfell Hall')) %>%
  mutate(gutenberg_id = replace(gutenberg_id, 
                                gutenberg_id == '1260', 'Jane Eyre')) %>%
  mutate(gutenberg_id = replace(gutenberg_id, 
                                gutenberg_id == '9182', 'Villette')) %>%
  rename(book = gutenberg_id)

#Regroup and sorting top tens

ja_tf_idf_top10 <- ja_tf_idf %>%
  group_by(book) %>%
  top_n(10) 

hgw_tf_idf_top10 <- hgw_tf_idf %>%
  group_by(book) %>%
  top_n(10) 

bs_tf_idf_top10 <- bs_tf_idf %>%
  group_by(book) %>%
  top_n(10) 

#Plots for Austen
ja_tf_idf_top10 %>%
  ggplot(aes(reorder(word,tf_idf), tf_idf, fill = book)) +
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "tf-idf") +
  facet_wrap(~book, ncol = 2, scales = "free") +
  coord_flip()

#Plots for Wells
hgw_tf_idf_top10 %>%
  ggplot(aes(reorder(word,tf_idf), tf_idf, fill = book)) +
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "tf-idf") +
  facet_wrap(~book, ncol = 2, scales = "free") +
  coord_flip()

#Plots for Brone Sisters
bs_tf_idf_top10 %>%
  ggplot(aes(reorder(word,tf_idf), tf_idf, fill = book)) +
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "tf-idf") +
  facet_wrap(~book, ncol = 2, scales = "free") +
  coord_flip()