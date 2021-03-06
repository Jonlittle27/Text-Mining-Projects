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

## Filtering Jane Austen Book Titles
filter(ja_books, gutenberg_id == 105)
filter(ja_books, gutenberg_id == 121)
filter(ja_books, gutenberg_id == 141)
filter(ja_books, gutenberg_id == 158)
filter(ja_books, gutenberg_id == 161)
filter(ja_books, gutenberg_id == 1342)

##Jane Austen Title Results:
## Persuasion - ID 105
## Northanger Abbey - ID 121
## Mansfield Park - 141
## Emma - ID 158
## Sense and Sensibility - ID 161
## Pride and Prejudice - ID 1342


##Tidy Austen Books
ja_tidy <- ja_books %>%
  unnest_tokens(word,text)

##Tidy Wells Books
hgw_tidy <- hgw_books %>%
  unnest_tokens(word,text)

##Tidy Bronte Sisters Books
bs_tidy <- bs_books %>%
  unnest_tokens(word,text)

##Word Frequency for Austen Books
ja_word_freq <- ja_tidy %>%
  count(word,sort=TRUE)

##Word Frequency for Wells Books
hgw_word_freq <- hgw_tidy %>%
  count(word,sort=TRUE)

##Word Frequency for Bronte Sisters Books
bs_word_freq <- bs_tidy %>%
  count(word,sort=TRUE)

##Basic Bar Plot Wells - Whole Dataset
barplot(hgw_word_freq$n)

##Wells - Top 1000
barplot(top_n(hgw_word_freq,1000)$n)

##Wells - Top 10 + Labels
barplot(top_n(hgw_word_freq,10)$n,names=top_n(hgw_word_freq,10)$word)

##Basic Bar Plot Bronte Sisters - Whole Dataset
barplot(bs_word_freq$n)

##Bronte Sisters - Top 1000
barplot(top_n(bs_word_freq,1000)$n)

##Bronte Sisters - Top 10 + Labels
barplot(top_n(bs_word_freq,10)$n,names=top_n(bs_word_freq,10)$word)

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

##Word Freq No Stop Austen/Wells/Bronte Sisters

ja_word_freq_no_stop <- ja_tidy_no_stop %>%
  count(word,sort=TRUE)

hgw_word_freq_no_stop <- hgw_tidy_no_stop%>%
  count(word,sort=TRUE)

bs_word_freq_no_stop <- bs_tidy_no_stop%>%
  count(word,sort=TRUE)

##Basic Bar Plot for Austen Word Freq No Stop Words 
##Whole Set/Top 1000/ Top 10

barplot(ja_word_freq_no_stop$n)

barplot(top_n(ja_word_freq_no_stop,1000)$n)

barplot(top_n(ja_word_freq_no_stop,10)$n,names=top_n(ja_word_freq_no_stop,10)$word)

##Basic Bar Plot for Wells Word Freq No Stop Words
##Whole Set/Top 1000/ Top 10

barplot(hgw_word_freq_no_stop$n)

barplot(top_n(hgw_word_freq_no_stop,1000)$n)

barplot(top_n(hgw_word_freq_no_stop,10)$n,names=top_n(hgw_word_freq_no_stop,10)$word)

##Basic Bar Plot for Bronte Sisters Word Freq No Stop Words 
##Whole Set/Top 1000/ Top 10

barplot(bs_word_freq_no_stop$n)

barplot(top_n(bs_word_freq_no_stop,1000)$n)

barplot(top_n(bs_word_freq_no_stop,10)$n,names=top_n(bs_word_freq_no_stop,10)$word)

