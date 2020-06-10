#libraries
library(tidyverse)
library(tidytext)
library(scales)
library(quanteda)
library(quanteda.textmodels)
library(readtext)
library(topicmodels)
library(igraph)
library(ggraph)


#data import
neg_reviews <- read_csv("Data Sets/neg_reviews.csv")
pos_reviews <- read_csv("Data Sets/pos_reviews.csv")


#Setting the data for import to wordcloud.com
neg_wc <- neg_reviews %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words)

pos_wc <- pos_reviews %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words)


#creating the text files for the import
#commented out so it doesn't automatically save if script is fully run

#write.table(neg_wc$word,"neg_reviews.txt",
#            sep=" ", row.names = FALSE, quote = FALSE)

#write.table(pos_wc$word,"pos_reviews.txt",
#            sep=" ", row.names = FALSE, quote = FALSE)

#creating word frequencies
neg_wf <- neg_reviews %>%
  unnest_tokens(word,text) %>%
  count(word,sort=TRUE) 

pos_wf <- pos_reviews %>%
  unnest_tokens(word,text) %>%
  count(word,sort = TRUE)

#Finding Sums and creating the percent columns
sum(neg_wf$n)
sum(pos_wf$n)

neg_wf <-mutate(neg_wf, neg_percent = n/617696)
pos_wf <-mutate(pos_wf, pos_percent = n/691445)

#Joining the resulting data and creating a second df without stop words
full_wf <- full_join(neg_wf,pos_wf, by = "word")

full_wf_ns <- full_wf %>% anti_join(stop_words)

#fancy jittered
ggplot(full_wf, aes(x = neg_percent, y = pos_percent, color = abs(pos_percent - neg_percent))) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  scale_color_gradient(limits = c(0, 0.001), low = "darkslategray4", high = "black") +
  theme(legend.position="none") +
  labs(y = "Positive Reviews", x = "Negative Reviews", title='Stop Words Included')

ggplot(full_wf_ns, aes(x = neg_percent, y = pos_percent, color = abs(pos_percent - neg_percent))) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  scale_color_gradient(limits = c(0, 0.001), low = "darkslategray4", high = "black") +
  theme(legend.position="none") +
  labs(y = "Positive Reviews", x = "Negative Reviews", title = 'Stop Words Removed')

#bing sentiment analyses - on positive and negative review sets

#Creating all the sentiment sets
neg_sent <- neg_reviews %>%
  unnest_tokens(word,text)%>%
  inner_join(get_sentiments('bing'))

pos_sent <- pos_reviews %>%
  unnest_tokens(word,text) %>%
  inner_join(get_sentiments('bing'))

neg_nrc_sent <- neg_reviews%>%
  unnest_tokens(word,text) %>%
  inner_join(get_sentiments('nrc'))

pos_nrc_sent <- pos_reviews%>%
  unnest_tokens(word,text) %>%
  inner_join(get_sentiments('nrc'))

#counting bing sentiments
neg_sent_count <- neg_sent %>%
  count(sentiment) %>%
  spread(sentiment,n,fill=0)

pos_sent_count <- pos_sent %>%
  count(sentiment) %>%
  spread(sentiment,n,fill=0)

#nrc lexicon analysis
neg_nrc_sent_count <- neg_nrc_sent %>%
  filter(sentiment == 'sadness') %>%
  nrow()

pos_nrc_sent_count <- pos_nrc_sent %>%
  filter(sentiment == 'sadness') %>%
  nrow()

#finding a word that appears 20-50 times in both datasets
words <- full_wf_ns %>%
  filter(n.x >= 20 & n.x <= 50) %>%
  filter(n.y >= 20 & n.y <= 50)

#kwic - creating corpuses
neg_corpus <- corpus(neg_reviews)

pos_corpus <- corpus(pos_reviews)

#kwic in both datasets for the word guilty 
neg_kwic <- kwic(neg_corpus, pattern= 'guilty', window = 2)
View(neg_kwic)

pos_kwic <- kwic(pos_corpus, pattern= 'guilty', window = 2)
view(pos_kwic)

#topic model of combined sets - 20 topics
#joining the datasets as a combined set / removing stopwords
total_reviews <- full_join(pos_reviews,neg_reviews)

total_wf <- total_reviews %>%
  unnest_tokens(word,text) %>%
  group_by(val) %>%
  count(word,sort = TRUE) %>%
  anti_join(stop_words)

#Eliminating potential NA cells
total_wf <- total_wf[complete.cases(total_wf),]

#renaming for consistency with dtm
names(total_wf) <- c('document','term','n')

#Casting into document-term matrix
total_dtm <- total_wf %>%
  cast_dtm(document,term,n)

#LDA - Using 20 topics and setting a seed for reproducibility
total_lda <- LDA(total_dtm,k=20,control = list(seed = 1234))


#Getting beta matrix 
total_topics <- tidy(total_lda,matrix="beta")

#Looking up the top 10 words in each topic.
total_top_terms <- total_topics %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

#Plotting the first 10 topics as bar chart
total_top_terms %>%  
  filter(topic <= 10) %>%
  ggplot(aes(term, beta, fill = factor(as.factor(topic)))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip() +
  labs(title = "Total Reviews Topics 1-10 ") + 
  scale_x_reordered()

#Plotting topics 10-20 as a bar chart
total_top_terms %>%  
  filter(topic >= 11) %>%
  ggplot(aes(term, beta, fill = factor(as.factor(topic)))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip() +
  labs(title = "Total Reviews Topics 11-20 ") + 
  scale_x_reordered()
  
#Creating a text classifier to predict if a review is pos or neg
#Create corpus object for quanteda and creating a random sample to mix data

set.seed(35)
random_reviews <- total_reviews[sample(nrow(total_reviews)),]

total_corpus <- corpus(random_reviews)

#Create dfm matrix for analysis
total_dfm <- dfm(total_corpus, tolower = TRUE)

#Getting 75-25 test-train split by using  values
total_dfm_train <- total_dfm[1:1500,]
total_dfm_test <- total_dfm[1500:nrow(total_dfm),]

#Splitting the original for pos/neg values.
total_train <- random_reviews[1:1500,]
total_test <- random_reviews[1500:nrow(random_reviews),]

#Checking to make sure splits match up
table(total_train$val)

#Constructing the text classifier 
total_classifier <- textmodel_nb(total_dfm_train, total_train$val)

#Predictions for test set
total_pred <- predict(total_classifier,newdata = total_dfm_test)

#Confusion Matrix
table(total_pred, total_test$val)

#Printing the Matrix with the accuracy
confusion_matrix <- table(total_pred, total_test$val)
total <- sum(confusion_matrix)
correct <- confusion_matrix[1] + confusion_matrix[4]
percent <- paste(round(100*(correct/total), 2), "%", sep="")
message <- "Accuracy of Prediction Model is"

print(confusion_matrix)
print(paste(message,percent))

#bigrams
#creating the bigram function
count_bigrams <- function(dataset) {
  dataset %>%
    unnest_tokens(bigram, text, token = "ngrams", n = 2) %>%
    separate(bigram, c("word1", "word2"), sep = " ") %>%
    filter(!word1 %in% stop_words$word,
           !word2 %in% stop_words$word) %>%
    count(word1, word2, sort = TRUE)
}

#creating the visualization function for bigrams
visualize_bigrams <- function(bigrams) {
  set.seed(1234)
  a <- grid::arrow(type = "closed", length = unit(.15, "inches"))
  
  bigrams %>%
    top_n(30) %>%
    graph_from_data_frame() %>%
    ggraph(layout = "fr") +
    geom_edge_link(aes(edge_alpha = n), show.legend = FALSE, arrow = a) +
    geom_node_point(color = "lightblue", size = 5) +
    geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
    theme_void()
}

#counting the bigrams
total_bigrams <- count_bigrams(total_reviews)

#visualizing the bigrams
visualize_bigrams(total_bigrams)








