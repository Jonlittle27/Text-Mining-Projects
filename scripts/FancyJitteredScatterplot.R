# Libraries for Silge Chapter 1 ----
library(tidyverse)
library(tidytext)
library(scales)
# The scales library provides some additional ways to 
# label the axes, for instance showing 10% instead of .10.

# Basic plot of hg_percent vs ja_percent
ggplot(all_words_percents, aes(x = hg_percent, y = ja_percent)) +
  geom_point()
  
# Points are "bunched up."  Can confirm with transparency.
ggplot(all_words_percents, aes(x = hg_percent, y = ja_percent)) +
  geom_point(alpha=0.1)

# Can stretch out using log scale (like with mammals data)
ggplot(all_words_percents, aes(x = hg_percent, y = ja_percent)) +
  geom_point(alpha=0.1) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) 
  
# We see "strata".  Can get "cloud" using jitter.
ggplot(all_words_percents, aes(x = hg_percent, y = ja_percent)) +
  geom_jitter(alpha=0.1) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) 

# To get jitter to work need to give it "wiggle room."
ggplot(all_words_percents, aes(x = hg_percent, y = ja_percent)) +
  geom_jitter(alpha=0.1, width=0.3, height=0.3) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) 

# What words are which points?  Can put text geoms down.
ggplot(all_words_percents, aes(x = hg_percent, y = ja_percent)) +
  geom_jitter(alpha=0.1, width=0.3, height=0.3) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  geom_text(aes(label = word)) 
  
# Ack!  Need to not overlap so much!
ggplot(all_words_percents, aes(x = hg_percent, y = ja_percent)) +
  geom_jitter(alpha=0.1, width=0.3, height=0.3) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  geom_text(aes(label = word),check_overlap = TRUE) 
  
#  Which words are on which side?  Dividing line layer.
ggplot(all_words_percents, aes(x = hg_percent, y = ja_percent)) +
  geom_jitter(alpha=0.1, width=0.3, height=0.3) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  geom_text(aes(label = word),check_overlap = TRUE) +
  geom_abline(linetype=2)

# Rest is basically "theme" window-dressing.  Final:
ggplot(all_words_percents, aes(x = hg_percent, y = ja_percent, color = abs(ja_percent - hg_percent))) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  scale_color_gradient(limits = c(0, 0.001), low = "darkslategray4", high = "black") +
  theme(legend.position="none") +
  labs(y = "Jane Austen", x = "H.G. Wells")
