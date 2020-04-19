#0. Arbeitsverzeichnis aufräumen und pfad setzen
rm(list = ls())
setwd(dr = "Dokumente/4._Semester/Oberseminar_Data_Mining/")

#1. Load the e1071 and caret packages:
library(e1071)
library(caret)

#2. Read the data:
ep <- read.csv("electronics-purchase.csv")

#3. Partition the data:
set.seed(1000)
train.idx <- createDataPartition(ep$Purchase, p = 0.67, list = FALSE)

#4. Build the model:
nb.model <- naiveBayes(Purchase ~ . , data = ep[train.idx,])

#5. Look at the model:
nb.model

#6. Predict for each case of the validation partition:
nb.pred <- predict(nb.model, ep[-train.idx,])

#7.
#Generate and view the error matrix/classification confusion matrix for the validation
#partition:
nb.tab <- table(ep[-train.idx,]$Purchase, nb.pred, dnn = c("Actual",
                                                         "Predicted"))
nb.tab
