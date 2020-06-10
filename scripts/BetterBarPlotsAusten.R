# Better Bar Plots for Austen ----
library(tidyverse)
library(tidytext)

# This script assumes you have already generated data frame
# ja_word_freq_nostop (i.e. it is in Environment pane)


# First we want to just get the top 10 words in Austen.

ja_word_freq_no_stop_10 <- top_n(ja_word_freq_no_stop,10)

# The "word" column will be sorted alphabetically by default.
# If you want to sort by "n" instead, use

ja_word_freq_no_stop_10 <- mutate(ja_word_freq_no_stop_10,word=reorder(word,n))

# Now the plot, with a few theme elements thrown in:

ggplot(ja_word_freq_no_stop_10,aes(word,n)) +     
  geom_col()+               #  geom=columns (bars)
  xlab(NULL)+               #  theme 
  ylab(NULL)+               #  theme
  coord_flip()              #  theme 

# I encourage you to comment out (or delete) or otherwise change
# various lines above to see what happens.

# To do without creating any intermediate datasets, 
# use the pipe %>% operator.

ja_word_freq_no_stop %>%               
  top_n(10) %>%                        
  mutate(word=reorder(word,n)) %>%     
  ggplot(top_n(ja_word_freq_no_stop,10),aes(word,n)) +                #  aes map (x=word, y=n)  
  geom_col()+                          
  xlab(NULL)+                           
  ylab(NULL)+                          
  coord_flip()                         