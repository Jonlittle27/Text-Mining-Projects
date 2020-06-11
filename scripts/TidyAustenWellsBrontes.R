##Libraries 

library(gutenbergr)
library(tidyverse)
library(tidytext)

#Gutenberg book downloads

##Import Austen Books

ja_books <- gutenberg_download(c(161,1342,141,158,121,105))

##Import Wells Books

hgw_books <- gutenberg_download(c(35,36,159,5230))

##Import Bronte Books

bs_books <- gutenberg_download(c(767,768,969,1260,9182))

#Basic text tidying

##Tidy Austen Books
ja_tidy <- ja_books %>%
  unnest_tokens(word,text)

##Tidy Wells Books
hgw_tidy <- hgw_books %>%
  unnest_tokens(word,text)

##Tidy Bronte Sisters Books
bs_tidy <- bs_books %>%
  unnest_tokens(word,text)



