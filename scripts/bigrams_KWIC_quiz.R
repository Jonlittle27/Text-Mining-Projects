ctweets <- read_delim("Data Sets/ctweets.csv", 
                      ";", escape_double = FALSE, trim_ws = TRUE)
View(ctweets)

ctweets_ns <-

tweet_bigrams<-count_bigrams(ctweets)

visualize_bigrams(tweet_bigrams)

tweet_corpus <- corpus(ctweets)

greatest_kwic <-kwic(tweet_corpus, pattern="greatest", window=5)
view(greatest_kwic)

textplot_xray(kwic(tweet_corpus, pattern="fake"))

#fake news
#582
#crooked hillary
#328
#6
#103
#witch
#4
#23