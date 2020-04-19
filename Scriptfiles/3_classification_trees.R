#0. Arbeitsverzeichnis aufräumen und pfad setzen
rm(list = ls())
setwd(dr = "Dokumente/4._Semester/Oberseminar_Data_Mining/")

#1. load requiered packages
library(rpart) #Recursive Partitioning and Regression Trees
library(rpart.plot)
library(caret) #Classification And REgression Training

#2.read data
titanic_data <- read.csv("titanic.csv")


#Initialisieren des Pseudozufallszahlengenerators
set.seed(1000)

#Partition mit zufälligen 70% der Einträge
train.index <- createDataPartition(titanic_data$Survived, p = 0.7, list = FALSE)

#build classification model
mod <- rpart(Survived ~ Pclass + Sex + Age + Fare, data = titanic_data[train.index, ], method =
               "class", control = rpart.control(minsplit = 20, cp = 0.01))

#plot the model
rpart.plot(mod, box.palette="RdBu", shadow.col="gray", nn=TRUE)

#Prognostizierte Klassenzugehörigkeit der Testdaten
pred.class <- predict(mod, titanic_data[-train.index,], type = "class") #factors
pred.prob <- predict(mod, titanic_data[-train.index,], type = "prob") #probabilities

#Konfusionsmatrix der Klassifizierung
(tab <- table(titanic_data[-train.index,]$Survived, pred.class, dnn = c("Actual", "Predicted"))) #total
round(prop.table(tab)*100,1) #Pozentual

#Erstelle Prediction-Objekt
pred.rocr <- prediction(pred.prob[,2], titanic_data[-train.index,"Survived"])
#Generiere Performance-Objekt
perf.rocr <- performance(pred.rocr, "tpr", "fpr")
plot(perf.rocr)

