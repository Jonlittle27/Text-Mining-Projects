# Libraries for Silge & Robinson Chapter 1 ----

library(gutenbergr)
library(tidyverse)
library(tidytext)

# Import Austen books ----

ja_books <- gutenberg_download(c(161,1342,141,158,121,105))
