#0. Arbeitsverzeichnis aufräumen und Pfad setzen
rm(list = ls())
setwd(dir = "~/Dokumente/4._Semester/Oberseminar_Data_Mining/Datasets/")

#1. nötige Packages laden
library(nnet)
library(caret)

#2. Datensatz einlesen 
bn <- read.csv("banknote-authentication.csv")

#3. Zielvariable in factor-Variable wandeln
bn$class <- factor(bn$class)

#4. Erzeugen von zwei Partitionen
train.idx <- createDataPartition(bn$class, p=0.7, list = FALSE)

#5. Neuronales-Netz-Klassifikationsmodell erzeugen 
nnet.model <- nnet(class ~., data=bn[train.idx,],size=3,maxit=10000,decay=.001, rang = 0.05)

#6. Erzeugen der Prognosen auf den Testdaten
nnet.pred <- predict(nnet.model, newdata=bn[-train.idx,], type="class")

#7. Ausgabe der Konfusionsmatrix der Testperformance
(table(bn[-train.idx,]$class, nnet.pred))
