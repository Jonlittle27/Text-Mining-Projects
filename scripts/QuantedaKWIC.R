library(quanteda)
library(readtext)

# Let's just look at the movie reviews from earlier.
reviews <- corpus(LastChristmasReviews)

# Finds the word "movie" in the reviews with kwic window 2.
kwic(reviews, pattern="movie", window=3)
# Feel free to play with other words.

# Interesting feature: save kwic output and view.
movie_kwic2 <- kwic(reviews, pattern="movie", window=2)
View(movie_kwic2)


# Finally, quanteda also has handy visualization 
# of keywords in whole documents.  Called "textplot_xray".
textplot_xray(kwic(reviews, pattern = "movie")) 

textplot_xray(
  kwic(reviews, pattern = "movie"),
  kwic(reviews, pattern = "film")
) 

# If only one text in corpus textplot_xray will show them
# side-by-side in the text.
# The corpus "PnP" below is just Pride and Prejudice.
PnP <- texts(readtext(
  "http://www.gutenberg.org/files/1342/1342-0.txt"))
textplot_xray(
  kwic(PnP, pattern = "Elizabeth"),
  kwic(PnP, pattern = "Darcy")
) 
