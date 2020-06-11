##Libraries
library(gutenbergr)
library(tidyverse)
library(tidytext)
library(scales)

##Import Austen Books

ja_books <- gutenberg_download(c(161,1342,141,158,121,105))

##Import Wells Books

hgw_books <- gutenberg_download(c(35,36,159,5230))

##Import Bronte Books

bs_books <- gutenberg_download(c(767,768,969,1260,9182))

##Word Freqs

ja_word_freq <- ja_books%>% 
  unnest_tokens(word,text)%>%
  count(word,sort=TRUE)

hgw_word_freq <- hgw_books%>%
  unnest_tokens(word,text)%>%
  count(word,sort=TRUE)

bs_word_freq <- bs_books%>%
  unnest_tokens(word,text)%>%
  count(word,sort=TRUE)
##Austen added Column

sum(ja_word_freq$n)

ja_word_freq <- mutate(ja_word_freq, ja_percent = n/725070)

##Wells added Column

sum(hgw_word_freq$n)

hgw_word_freq <- mutate(hgw_word_freq, hgw_percent = n/186615)

##Bronte Sisters added Column

sum(bs_word_freq$n)

bs_word_freq <- mutate(bs_word_freq, bs_percent = n/741773)

##Joining the 3 data frames

all_words_percents <- full_join(ja_word_freq,bs_word_freq, by = "word")%>%
  full_join(hgw_word_freq, by = "word")

## all words percents no stop

all_words_percents_no_stop <- all_words_percents%>% anti_join(stop_words)

##Fancy Jitter Plot Austen/Wells
ggplot(all_words_percents, aes(x = hgw_percent, y = ja_percent, color = abs(ja_percent - hgw_percent))) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  scale_color_gradient(limits = c(0, 0.001), low = "darkslategray4", high = "black") +
  theme(legend.position="none") +
  labs(y = "Jane Austen", x = "H.G. Wells")

##Fancy Jitter Plot Austen/Bronte Sisters
ggplot(all_words_percents, aes(x = bs_percent, y = ja_percent, color = abs(ja_percent - bs_percent))) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  scale_color_gradient(limits = c(0, 0.001), low = "darkslategray4", high = "black") +
  theme(legend.position="none") +
  labs(y = "Jane Austen", x = "Bronte Sisters")

##Fancy Jitter Plot Wells/Bronte Sisters
ggplot(all_words_percents, aes(x = hgw_percent, y = bs_percent, color = abs(bs_percent - hgw_percent))) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  scale_color_gradient(limits = c(0, 0.001), low = "darkslategray4", high = "black") +
  theme(legend.position="none") +
  labs(y = "Bronte Sisters", x = "H.G. Wells")

##Fancy Jitter Plot Austen/Wells no stop words
ggplot(all_words_percents_no_stop, aes(x = hgw_percent, y = ja_percent, color = abs(ja_percent - hgw_percent))) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  scale_color_gradient(limits = c(0, 0.001), low = "darkslategray4", high = "black") +
  theme(legend.position="none") +
  labs(y = "Jane Austen", x = "H.G. Wells")

##Fancy Jitter Plot Austen/Bronte Sisters no stop words
ggplot(all_words_percents_no_stop, aes(x = bs_percent, y = ja_percent, color = abs(ja_percent - bs_percent))) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  scale_color_gradient(limits = c(0, 0.001), low = "darkslategray4", high = "black") +
  theme(legend.position="none") +
  labs(y = "Jane Austen", x = "Bronte Sisters")

##Fancy Jitter Plot Wells/Bronte Sisters no stop words
ggplot(all_words_percents_no_stop, aes(x = hgw_percent, y = bs_percent, color = abs(bs_percent - hgw_percent))) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  scale_color_gradient(limits = c(0, 0.001), low = "darkslategray4", high = "black") +
  theme(legend.position="none") +
  labs(y = "Bronte Sisters", x = "H.G. Wells")