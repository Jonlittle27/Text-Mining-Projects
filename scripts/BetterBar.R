##Libraries 

library(gutenbergr)
library(tidyverse)
library(tidytext)

##Import Austen Books

ja_books <- gutenberg_download(c(161,1342,141,158,121,105))

##Import Wells Books

hgw_books <- gutenberg_download(c(35,36,159,5230))

##Import Bronte Books

bs_books <- gutenberg_download(c(767,768,969,1260,9182))


##Tidy Austen/Wells/Bronte Sisters No Stop Words

ja_tidy_no_stop <- ja_books %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words)

hgw_tidy_no_stop <- hgw_books%>%
  unnest_tokens(word,text)%>%
  anti_join(stop_words)

bs_tidy_no_stop <- bs_books%>%
  unnest_tokens(word,text)%>%
  anti_join(stop_words)

##Word Freq No Stop Austen/Wells/Bronte Sisters - Top 13 Meaningful words

ja_word_freq_no_stop_13 <- ja_tidy_no_stop %>%
  count(word,sort=TRUE)%>%
  top_n(13)%>%
  mutate(word = reorder(word,n))

hgw_word_freq_no_stop_13 <- hgw_tidy_no_stop%>%
  count(word,sort=TRUE)%>%
  top_n(13)%>%
  mutate(word = reorder(word,n))

bs_word_freq_no_stop_13 <- bs_tidy_no_stop%>%
  count(word,sort=TRUE)%>%
  top_n(13)%>%
  mutate(word= reorder(word,n))

##Better Bar Plot Austen
ggplot(ja_word_freq_no_stop_13, aes(word,n)) +
  geom_col(fill="blue")+
  coord_flip()

##Better Bar Plot Wells
ggplot(hgw_word_freq_no_stop_13, aes(word,n)) +
  geom_col(fill="purple3")+
  coord_flip()

##Better Bar Plot Bronte
ggplot(bs_word_freq_no_stop_13, aes(word,n)) +
  geom_col(fill = "gold")+
  coord_flip()