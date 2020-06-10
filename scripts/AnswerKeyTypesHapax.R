# One way to get types and hapax
# for the first 30000 words of each novel
# by our three authors.

# Libraries
library(gutenbergr)
library(tidyverse)
library(tidytext)

# First 30000 words = first 30000 rows of the tidy datasets.
# If you have those in your environment already
# then you don't need the next bit of code
# (which is familiar from first few units).

# Get books from Gutenberg and tidy them

ja_books <- gutenberg_download(c(161,1342,141,158,121,105))
hg_books <- gutenberg_download(c(35,36,5230,159))
bs_books <- gutenberg_download(c(1260,768,969,9182,767))

ja_tidy <- ja_books %>%
  unnest_tokens(word,text)
hg_tidy <- hg_books %>%
  unnest_tokens(word,text) 
bs_tidy <- bs_books %>% 
  unnest_tokens(word,text) 

# Now we're ready to get types and hapax.
# We can do this for all Austen's books at once
# by making use of the gutenberg_id column
# and using the group_by command.
# The slice command gives us the first 30000 rows.
# (The head command works similarly.)

# Austen types for first 30000 words
# The types are the number of rows of word freq table.
ja_types <- ja_tidy %>%
  group_by(gutenberg_id) %>% 
  slice(gutenberg_id, 1:30000) %>%   
  count(word,sort=TRUE) %>% 
  summarize(types=n())            

# Austen hapax for first 30000 words
# The hapax are the entries of word freq table with n=1.
ja_hapax <- ja_tidy %>%
  group_by(gutenberg_id) %>%
  slice(1:30000) %>%
  count(word,sort=TRUE)  %>%
  filter(n==1) %>%
  summarize(hapax=n())


# Now combine Austen types and hapax tables into one table.
ja_types_hapax <- full_join(ja_types,ja_hapax,by="gutenberg_id")


# You can also do both types and hapax with one pipeline
# by taking advantage of the fact that the number of hapax
# is the sum of the n=1 entries,
# like in the commented code below.

# ja_types_hapax <- ja_tidy %>%
#   group_by(gutenberg_id) %>% 
#   slice(1:30000) %>% 
#   count(word,sort=TRUE) %>% 
#   summarize(types=n(), hapax=sum(n==1)) 


# Wells and the Brontes go similarly
# and I'll put them as single pipelines without comments.
hg_types_hapax <- hg_tidy %>%
  group_by(gutenberg_id) %>% 
  slice(1:30000) %>% 
  count(word,sort=TRUE) %>% 
  summarize(types=n(), hapax=sum(n==1)) 

bs_types_hapax <- bs_tidy %>%
  group_by(gutenberg_id) %>% 
  slice(gutenberg_id, 1:30000) %>% 
  count(word,sort=TRUE) %>% 
  summarize(types=n(), hapax=sum(n==1)) 


# Now get averages and combine all three tables.
ja_avg <- ja_types_hapax %>% 
  summarize(author="Austen", types_avg=mean(types), hapax_avg=mean(hapax)) 
hg_avg <- hg_types_hapax %>% 
  summarize(author="Wells", types_avg=mean(types), hapax_avg=mean(hapax)) 
bs_avg <- bs_types_hapax %>% 
  summarize(author="Brontes", types_avg=mean(types), hapax_avg=mean(hapax)) 

avg_types_hapax <- rbind(ja_avg,hg_avg,bs_avg)  

