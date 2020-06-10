#Libraries
library(tidyverse)
library(tidytext)
library(readr)


#importing the data
LastChristmasReviews<- read_csv("Data Sets/LastChristmasReviews(1).csv")

#Cleaning the data
LCR_tidy <- LastChristmasReviews %>%
  group_by(source) %>%
  unnest_tokens(word,text)

#Joining with the Sentiment Data for analysis
LCR_Sent <- LCR_tidy %>% 
  inner_join(get_sentiments("bing"))

#Counting the total sentiments
LCR_Sent_Count <- LCR_Sent %>%
  count(source,metacritic,sentiment) %>%
  spread(sentiment,n,fill=0)

#Creating a column for the Sentiment differences
LCR_diff <- LCR_Sent_Count %>%
  mutate(diff = positive - negative)

#Bar plot showing the metacritic scores for the reviews
ggplot(LCR_diff, aes(x=source,y=metacritic)) +
  geom_col(fill='darkgreen') + 
  coord_flip() + 
  labs(title = "Metacritic Scores by Review",x="Review Source",
       y="Metacritic Score")

#Bar plot for the bing sentiment difference for the reviews
fill = c("blue","blue","red","blue","red","blue","blue","red","blue","blue")
ggplot(LCR_diff, aes(x=source,y=diff)) +
  geom_col(fill=fill) + 
  coord_flip() + 
  labs(title = "Bing Sentiment Difference by Review",x="Review Source",
       y="Sentiment Difference")

#Calculating Correlation between Metacritic Score and Sentiment Difference
cor <- round(cor(LCR_diff$metacritic,LCR_diff$diff),2)
cor
