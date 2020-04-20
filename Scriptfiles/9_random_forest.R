#0. Arbeitsverzeichnis aufräumen und pfad setzen
rm(list = ls())
setwd(dir = "~/Dokumente/4._Semester/Oberseminar_Data_Mining/Datasets/")

#1. load requiered packages
library(randomForest)
library(caret)

#2.read data
bn <- read.csv("banknote-authentication.csv")

#abhängige Variable in factor umwandeln
bn$class <- factor(bn$class)

#3. Select a subset of the data for building the model. In Random Forests, we do not
#need to actually partition the data for model evaluation since the tree construction
#process has partitioning inherent in every step. However, we keep aside some of the
#data here just to illustrate the process of using the model for prediction and also to
#get an idea of the model's performance:
set.seed(1000)
train.idx <- createDataPartition(bn$class, p=0.7, list=FALSE)

#4. Build the random forest model (since it builds many classification trees, the following
#command can take a lot of processing time on even moderately large data):
mod <- randomForest(x = bn[train.idx,1:4], y=bn[train.idx,5], ntree=500, keep.forest=TRUE)

#5. Use the model to predict for cases that we set aside in step 3:
pred <- predict(mod, bn[-train.idx,])

#6. Build the error matrix:
(tab <- table(bn[-train.idx,"class"], pred, dnn = c("Actual", "Predicted"))) #total
round(prop.table(tab)*100,1) #Pozentual

#Generating the ROC chart
#Using the preceding probabilities, we can generate the ROC chart. For details, refer to
#Generating ROC charts earlier in this chapter:
probs <- predict(mod, bn[-train.idx,], type = "prob") #Wahrscheinlichkeiten
pred.rocr <- prediction(probs[,2], bn[-train.idx,"class"])
perf.rocr <- performance(pred.rocr, "tpr", "fpr")
plot(perf.rocr)
