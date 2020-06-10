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

##Word Freqs

ja_word_freq <- ja_books%>% 
  unnest_tokens(word,text)%>%
  count(word,sort=TRUE)

hgw_word_freq <- hgw_books%>%
  unnest_tokens(word,text)%>%
  count(word,sort=TRUE)

bs_word_freq <- bs_books%>%
  unnest_tokens(word,text)%>%
  count(word,sort=TRUE)
##Austen added Column

sum(ja_word_freq$n)

ja_word_freq <- mutate(ja_word_freq, ja_percent = n/725070)

##Wells added Column

sum(hgw_word_freq$n)

hgw_word_freq <- mutate(hgw_word_freq, hgw_percent = n/186615)

##Bronte Sisters added Column

sum(bs_word_freq$n)

bs_word_freq <- mutate(bs_word_freq, bs_percent = n/741773)

##Joining the 3 data frames

all_words_percents <- full_join(ja_word_freq,bs_word_freq, by = "word")%>%
  full_join(hgw_word_freq, by = "word")

## all words percents no stop

all_words_percents_no_stop <- all_words_percents%>% anti_join(stop_words)


##correalation quiz wrangling and tables
AAAA <- all_words_percents%>% 
  subset(select= -c(n.x,n.y,n))


round(cor(AAAA[2:4],use="complete.obs"), digits = 2)

BBBB <- all_words_percents_no_stop%>% 
  subset(select= -c(n.x,n.y,n))
  
round(cor(BBBB[2:4],use="complete.obs"), digits = 2)


