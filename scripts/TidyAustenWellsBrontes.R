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



