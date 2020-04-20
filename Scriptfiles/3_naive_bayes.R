#0. Arbeitsverzeichnis aufräumen und Pfad setzen
rm(list = ls())
setwd(dr = "Dokumente/4._Semester/Oberseminar_Data_Mining/")

#1. nötige Packages laden
library(e1071)
library(caret)

#2. Datensatz einlesen 
ep <- read.csv("electronics-purchase.csv")

#4. Erzeugen von zwei Partitionen (Indexe)
set.seed(1000)
train.idx <- createDataPartition(ep$Purchase, p = 0.67, list = FALSE)

#4. Naive-Bayes-Klassifikationsmodell erzeugen auf Basis Trainingsdaten
nb.model <- naiveBayes(Purchase ~ . , data = ep[train.idx,])

#5. Modell ausgeben lassen
nb.model

#6. Prognose der Testdaten auf Basis des Modells
nb.pred <- predict(nb.model, ep[-train.idx,])

#7. Ausgabe der Konfusionsmatrix für die Testperformance
(nb.tab <- table(ep[-train.idx,]$Purchase, nb.pred, dnn = c("Actual", "Predicted")))

