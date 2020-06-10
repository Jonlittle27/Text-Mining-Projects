##Libraries 

library(gutenbergr)
library(tidyverse)
library(tidytext)

##Import Austen Books/Tidy/Word Freq

ja_freq <- gutenberg_download(c(161,1342,141,158,121,105))%>%
  unnest_tokens(word,text)%>%
  count(word,sort=TRUE)

##Import Wells Books/Tidy/Word Freq

hgw_freq <- gutenberg_download(c(35,36,159,5230))%>%
  unnest_tokens(word,text)%>%
  count(word,sort=TRUE)

##Import Bronte Books/Tidy/Word Freq

bs_freq <- gutenberg_download(c(767,768,969,1260,9182))%>%
  unnest_tokens(word,text)%>%
  count(word,sort=TRUE)

##Percentage Top 10/50/75 Words of the total - Austen
sum(ja_freq$n)

round(sum(top_n(ja_freq,10)$n)/sum(ja_freq$n),3)

round(sum(top_n(ja_freq,50)$n)/sum(ja_freq$n),3)

round(sum(top_n(ja_freq,75)$n)/sum(ja_freq$n),3)

##Percentage Top 10/50/75 Words of the total - Wells
sum(hgw_freq$n)

round(sum(top_n(hgw_freq,10)$n)/sum(hgw_freq$n),3)

round(sum(top_n(hgw_freq,50)$n)/sum(hgw_freq$n),3)

round(sum(top_n(hgw_freq,75)$n)/sum(hgw_freq$n),3)

##Percentage Top 10/50/75 Words of the total - Bronte Sisters
sum(bs_freq)

round(sum(top_n(bs_freq,10)$n)/sum(bs_freq$n),3)

round(sum(top_n(bs_freq,50)$n)/sum(bs_freq$n),3)

round(sum(top_n(bs_freq,75)$n)/sum(bs_freq$n),3)


