#Libraries
library(gutenbergr)
library(tidytext)
library(tidyverse)
library(readr)

#importing the csv
hist_text <- read_csv("Data Sets/hist.csv")

#Word Frequencies grouped by chapter
hist_word_freq <- hist_text%>% 
  unnest_tokens(word,text)%>%
  group_by(chapter)%>%
  count(word,sort=TRUE)

#Adding tf-idf columns and values
hist_tf_idf <- hist_word_freq %>%
  bind_tf_idf(word,chapter,n) %>%
  arrange(desc(tf_idf))

#Changing to top fives by chapter
hist_top_by_chap <- hist_tf_idf %>%
  top_n(5)

#Unsure if final product is supposed to be the above df or arranged so
hist_top_by_chap2 <- hist_top_by_chap%>%
  arrange(chapter)
