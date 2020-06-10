# We will assume that you have run BingLex.R already
# and so have those data frames available as needed.

# Get AFINN sentiment scores----
# Join with AFINN

ja_afinn_sent <- ja_tidy_chaps %>% 
  inner_join(get_sentiments("afinn"))

# That seperates out words that are pos/neg.
# However these pos/neg are values, not categories.
# Need to tally values differently than categories.

ja_chap_sent_afinn <- ja_afinn_sent %>%
  group_by(book,chapter) %>%
  summarise(sentiment=sum(value))

# Each chapter has one value now:  total sentiment (pos+neg)
# Can plot easily

# Plot-----

ggplot(ja_chap_sent_afinn,aes(x=chapter,y=sentiment,fill=book)) + 
  geom_col(show.legend = FALSE) + 
  facet_wrap(~book,ncol=2,scales="free_x") 

