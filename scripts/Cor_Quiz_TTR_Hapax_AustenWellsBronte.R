##Libraries
library(tidyverse)
library(tidytext)
library(gutenbergr)

##Import Austen Books

ja_books <- gutenberg_download(c(161,1342,141,158,121,105))

##Import Wells Books

hgw_books <- gutenberg_download(c(35,36,159,5230))

##Import Bronte Books

bs_books <- gutenberg_download(c(767,768,969,1260,9182))


##Austen 105 - first 30k
ja_105 <-ja_books%>% 
  filter(gutenberg_id==105)%>%
  unnest_tokens(word,text)
ja_105<- ja_105[1:30000,] 

##105 types and Hapax
types_105 <-ja_105%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_105 <- ja_105%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()

##Austen 121 - First 30k
ja_121 <-ja_books%>% 
  filter(gutenberg_id==121)%>%
  unnest_tokens(word,text)
ja_121<- ja_121[1:30000,] 

##121 types and Hapax
types_121 <-ja_121%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_121 <- ja_121%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()

##Austen 141 - First 30k
ja_141 <-ja_books%>% 
  filter(gutenberg_id==141)%>%
  unnest_tokens(word,text)
ja_141<- ja_141[1:30000,] 
##141 types and Hapax
types_141 <-ja_141%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_141 <- ja_141%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()

##Austen 158 - First 30k
ja_158 <-ja_books%>% 
  filter(gutenberg_id==158)%>%
  unnest_tokens(word,text)
ja_158<- ja_158[1:30000,] 
##158 types and Hapax
types_158 <-ja_158%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_158 <- ja_158%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()

##Austen 161 - First 30k
ja_161 <-ja_books%>% 
  filter(gutenberg_id==161)%>%
  unnest_tokens(word,text)
ja_161<- ja_161[1:30000,] 
##161 types and Hapax
types_161 <-ja_161%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_161 <- ja_161%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()

##Austen 1342 - First 30k
ja_1342 <-ja_books%>% 
  filter(gutenberg_id==1342)%>%
  unnest_tokens(word,text)
ja_1342<- ja_1342[1:30000,] 
##1342 types and Hapax
types_1342 <-ja_1342%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_1342 <- ja_1342%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()

##Wells 35 - First 30k
hgw_35 <-hgw_books%>% 
  filter(gutenberg_id==35)%>%
  unnest_tokens(word,text)
hgw_35<- hgw_35[1:30000,] 
##35 types and Hapax
types_35 <-hgw_35%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_35 <- hgw_35%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()

##Wells 36 - First 30k
hgw_36 <-hgw_books%>% 
  filter(gutenberg_id==36)%>%
  unnest_tokens(word,text)
hgw_36<- hgw_36[1:30000,] 
##36 types and Hapax
types_36 <-hgw_36%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_36 <- hgw_36%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()

##Wells 35 - First 30k
hgw_35 <-hgw_books%>% 
  filter(gutenberg_id==35)%>%
  unnest_tokens(word,text)
hgw_35<- hgw_35[1:30000,] 
##105 types and Hapax
types_35 <-hgw_35%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_35 <- hgw_35%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()

##Wells 159 - First 30k
hgw_159 <-hgw_books%>% 
  filter(gutenberg_id==159)%>%
  unnest_tokens(word,text)
hgw_159<- hgw_159[1:30000,] 
##159 types and Hapax
types_159 <-hgw_159%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_159 <- hgw_159%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()

##Wells 5230 - First 30k
hgw_5230 <-hgw_books%>% 
  filter(gutenberg_id==5230)%>%
  unnest_tokens(word,text)
hgw_5230<- hgw_5230[1:30000,] 
##5230 types and Hapax
types_5230 <-hgw_5230%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_5230 <-hgw_5230%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()

##Bronte 767 - First 30k
bs_767 <-bs_books%>% 
  filter(gutenberg_id==767)%>%
  unnest_tokens(word,text)
bs_767<- bs_767[1:30000,] 
##767 types and Hapax
types_767 <-bs_767%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_767 <- bs_767%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()

##Bronte 768 - First 30k
bs_768 <-bs_books%>% 
  filter(gutenberg_id==768)%>%
  unnest_tokens(word,text)
bs_768<- bs_768[1:30000,] 
##768 types and Hapax
types_768 <-bs_768%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_768 <- bs_768%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()

##Bronte 969 - First 30k
bs_969 <-bs_books%>% 
  filter(gutenberg_id==969)%>%
  unnest_tokens(word,text)
bs_969<- bs_969[1:30000,] 
##969 types and Hapax
types_969 <-bs_969%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_969 <- bs_969%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()
 
##Bronte 767 - First 30k
bs_767 <-bs_books%>% 
  filter(gutenberg_id==767)%>%
  unnest_tokens(word,text)
bs_767<- bs_767[1:30000,] 
##105 types and Hapax
types_767 <-bs_767%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_767 <- bs_767%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()

##Bronte 1260 - First 30k
bs_1260 <-bs_books%>% 
  filter(gutenberg_id==1260)%>%
  unnest_tokens(word,text)
bs_1260 <- bs_1260[1:30000,] 
##1260 types and Hapax
types_1260 <-bs_1260%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_1260 <- bs_1260%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()

##Bronte 9182 - First 30k
bs_9182 <-bs_books%>% 
  filter(gutenberg_id==9182)%>%
  unnest_tokens(word,text)
bs_9182<- bs_9182[1:30000,] 
##9182 types and Hapax
types_9182 <-bs_9182%>%
  count(word,sort=TRUE)%>%
  nrow()
hapax_9182 <- bs_9182%>%
  count(word,sort=TRUE)%>%
  filter(n== 1)%>%
  nrow()

##New Data Frames
ja_types_hapax <- data.frame("gutenberg_id" = c(105,121,141,158,161,1342),
                             "types" = c(types_105,types_121,types_141,types_158,types_161,types_1342),
                             "hapax" = c(hapax_105,hapax_121,hapax_141,hapax_158,hapax_161,hapax_1342))

hg_types_hapax <- data.frame("gutenberg_id" = c(35,36,159,5230),
                             "types" = c(types_35,types_36,types_159,types_5230),
                             "hapax" = c(hapax_35,hapax_36,hapax_159,hapax_5230))     

bs_types_hapax <- data.frame("gutenberg_id" = c(767,768,969,1260,9182),
                             "types" = c(types_767,types_768,types_969,types_1260,types_9182),
                             "hapax" = c(hapax_767,hapax_768,hapax_969,hapax_1260,hapax_9182)) 

## Final Data Frame with Averages

avg_types_hapax <- data.frame("Author" = c("Jane Austen", "H.G. Wells", "Bronte Sisters"),
                              "avg types" = c(mean(ja_types_hapax$types),
                                              mean(hg_types_hapax$types),
                                              mean(bs_types_hapax$types)),
                              "avg hapax"= c(mean(ja_types_hapax$hapax),
                                             mean(hg_types_hapax$hapax),
                                             mean(bs_types_hapax$hapax)))

##Printing the Four Data Frames to console
ja_types_hapax
hg_types_hapax
bs_types_hapax
avg_types_hapax
                             


##Correlation Quiz
round(cor(ja_types_hapax, use= "complete.obs"),2)
round(cor(hg_types_hapax,use="complete.obs"),2)
round(cor(bs_types_hapax,use="complete.obs"),2)                             
