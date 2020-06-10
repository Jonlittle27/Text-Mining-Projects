#Libraries
library(tidyverse)
library(tidytext)
library(quanteda)
library(quanteda.textmodels)

#Importing Enron Emails
emails <- read_csv("Data Sets/emails.csv")

#Changing the column names for readability
names(emails) <- c("label","text")

#checking spam and ham values. 0 = Ham 1 = Spam
emails %>% group_by(label) %>% summarise(length(label))

#Create corpus object for quanteda.
emails_corpus <- corpus(emails)

#Create dfm matrix for analysis
emails_dfm <- dfm(emails_corpus, tolower = TRUE)

#Getting 75-25 test-train split by using 4297 values
emails_dfm_train <- emails_dfm[1:4297,]
emails_dfm_test <- emails_dfm[4297:nrow(emails_dfm),]

#Splitting the original for ham/spam labels.
emails_train <- emails[1:4297,]
emails_test <- emails[4297:nrow(emails),]

#Checking to make sure splits match up
table(emails_train$label)

#Constructing the text classifier 
emails_classifier <- textmodel_nb(emails_dfm_train, emails_train$label)

#Predictions for test set
emails_pred <- predict(emails_classifier,newdata = emails_dfm_test)

#Confusion Matrix
table(emails_pred, emails_test$label)

#Printing the Matrix with the accuracy
confusion_matrix <- table(emails_pred, emails_test$label)
total <- sum(confusion_matrix)
correct <- confusion_matrix[1] + confusion_matrix[4]
percent <- paste(round(100*(correct/total), 2), "%", sep="")
message <- "Accuracy of Prediction Model is"

print(confusion_matrix)
print(paste(message,percent))
