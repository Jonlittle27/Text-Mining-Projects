#Libraries
library(gutenbergr)
library(tidytext)
library(tidyverse)
library(readr)

#importing the csv
hist_text <- read_csv("Data Sets/hist.csv")

#Word Frequency / no stop words
hist_word_freq <- hist_text%>% 
  unnest_tokens(word,text)%>%
  anti_join(stop_words)%>%
  count(word,chapter)

#Eliminating potential NA cells
hist_word_freq <- hist_word_freq[complete.cases(hist_word_freq),]

#For consistency with document-term matrix and readability
names(hist_word_freq) <- c("term","document","n")

#Casting into document-term matrix
hist_dtm <- hist_word_freq %>%
  cast_dtm(document,term,n)

#LDA
hist_lda <- LDA(hist_dtm,k=30,control = list(seed = 1234))


#Getting beta matrix 
hist_topics <- tidy(hist_lda,matrix="beta")

#Looking up the top 10 words in each topic.
hist_top_terms <- hist_topics %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)


#Plotting the first 10 topics as bar chart
hist_top_terms %>%  
  filter(topic <= 10) %>%
  ggplot(aes(term, beta, fill = factor(as.factor(topic)))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip() +
  labs(title = "History Text Topics 1-10 ") + 
  scale_x_reordered()

#Plotting topics 10-20 as a bar chart
hist_top_terms %>%  
  filter(topic >= 11 & topic <= 20) %>%
  ggplot(aes(term, beta, fill = factor(as.factor(topic)))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip() +
  labs(title = "History Text Topics 11-20 ") + 
  scale_x_reordered()

#Plotting the last 10 topics as a bar chart
hist_top_terms %>%  
  filter(topic >= 21) %>%
  ggplot(aes(term, beta, fill = factor(as.factor(topic)))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip() +
  labs(title = "History Text Topics 21-30 ") + 
  scale_x_reordered()

#Obtaining gamma
hist_docs <- tidy(hist_lda,matrix="gamma")

#plotting documents 30 and under as a tile plot
hist_docs %>%
  filter(document <= 30) %>%
  ggplot(aes(document, topic, fill = gamma)) +
  geom_tile(color="grey") +
  scale_fill_gradient2(high = "red", label = percent_format()) +
  coord_flip() +
  labs(title = "First 30 Documents")

#PLotting documents 31 and above as a tile plot
hist_docs %>%
  filter(document >= 31) %>%
  ggplot(aes(document, topic, fill = gamma)) +
  geom_tile(color="grey") +
  scale_fill_gradient2(high = "red", label = percent_format()) +
  coord_flip() +
  labs(title = "Final Documents")
