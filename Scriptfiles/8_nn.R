#Klassifikation mit Neuronalem Netz
#0. Arbeitsverzeichnis aufräumen und pfad setzen
rm(list = ls())
setwd(dr = "Dokumente/4._Semester/Oberseminar_Data_Mining/")

#load packages
library(nnet)
library(caret)

#2.read data
bn <- read.csv("banknote-authentication.csv")

#3. Convert the outcome variable class to a factor:
bn$class <- factor(bn$class)

#4. Partition the data. The predictor variables are already numeric and the outcome
#variable class is already 0-1, so we do not have to do any data preparation. Refer
#to Creating random data partitions in Chapter, What's in There? – Exploratory Data
#Analysis for details on how the following command works:
train.idx <- createDataPartition(bn$class, p=0.7, list = FALSE)

#5. Build the neural network model:
nnet.model <- nnet(class ~., data=bn[train.idx,],size=3,maxit=10000,decay=.001, rang = 0.05)

#6. Use model to predict for validation partition:
nnet.pred <- predict(nnet.model, newdata=bn[-train.idx,], type="class")

#7. Build and display the error/classification-confusion matrix on the validation partition:
table(bn[-train.idx,]$class, nnet.pred)
