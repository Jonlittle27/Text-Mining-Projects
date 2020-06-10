# The following script imports the files in
# the midterm project.  In the next unit 
# we'll see how to get RStudio to do this kind of work 
# for us in general, without scripts.


# The HarryPotterSeries.txt file is a delimited file.
# (We'll talk abut these further next unit.)
# Package readr has handy importing functions.
# You can name your data frame whatever you wish,
# I'm just calling it HP_dataframe here.
library(readr)
HP_dataframe <- read_csv("HarryPotterSeries.txt")


# The txt files in the corpus folder are raw text files.
# (Be sure to make the corpus folder the working directory.)
# In the code below I'll just use the generic "book.txt" as
# the name of one of these files.  Substitute the correct 
# file name and your own data frame name to use the code.
library(tidytext)
tidy_book <- read_csv("book.txt",col_names=FALSE) %>%
  unnest_tokens(word,X1)

