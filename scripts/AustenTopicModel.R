# Libraries-----
library(tidyverse)
library(tidytext)
library(topicmodels)
library(scales)


# Assumes you have data frame ja_tidy from unit 3.
# It has one column for "gutenber_id" and one for "word".
# (You may want to have the books labeled with their
# actual titles rather than their Gutenberg IDs.
# Makes identifying the "documents" easier in LDA.)

# Get word frequencies and remove stopwords.
ja_word_freq_no_stop <- ja_tidy %>% 
  unnest_tokens(word,word) %>%
  anti_join(stop_words) %>%
  count(word,gutenberg_id) 

# Just in case there are NA cells, eliminate those.
ja_word_freq_no_stop <- ja_word_freq_no_stop[complete.cases(ja_word_freq_no_stop),]

# For consistency with document-term matrix
# we'll rename headings (optional) 
names(ja_word_freq_no_stop) <- c("term","document","n")

# We've eliminated stopwords but could eliminate 
# low-frequency terms (numbers) too, so long as they
# play no role in creating topics.


# Cast tidy data frame into document term matrix.
ja_dtm <- ja_word_freq_no_stop %>%
  cast_dtm(document,term,n)

# LDA.  Choosing 10 topics just to see.  
# This will take a minute or two.
ja_lda <- LDA(ja_dtm,k=10,control = list(seed = 1234))

# The object ja_lda is a wrapper for lots of LDA outputs.
# We only care here about the two matrices beta and gamma.  
# Beta relates the words in the topics.
# Gamma relates the topics in the documents.

# Getting beta matrix from ja_lda.
ja_topics <- tidy(ja_lda,matrix="beta")

# Looking up the top 10 words in each topic.
ja_top_terms <- ja_topics %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)


# Plot topics as bar chart.  One small note:  we are
# treating the topic column as a factor here so that
# it works as a facet.
ja_top_terms %>%  
  ggplot(aes(term, beta, fill = factor(as.factor(topic)))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip() +
  scale_x_reordered()


# Getting gamma, which gives the topics in the documents.
ja_docs <- tidy(ja_lda,matrix="gamma")

# Plot this as a tile plot.
ja_docs %>%
  ggplot(aes(document, topic, fill = gamma)) +
  geom_tile(color="grey") +
  scale_fill_gradient2(high = "red", label = percent_format()) +
  coord_flip()
