#0. Arbeitsverzeichnis aufräumen und pfad setzen
rm(list = ls())
setwd(dr = "Dokumente/4._Semester/Oberseminar_Data_Mining/")

#1. nötige Packages laden
library(e1071)
library(caret)

#2. Datensatz einlesen 
bn <- read.csv("banknote-authentication.csv")

#3. Zielgröße 'class' in factor-variable wandeln
bn$class <- factor(bn$class)

#4. Erzeugen von zwei Partitionen
set.seed(1000)
train.idx <- createDataPartition(bn$class, p=0.7, list=FALSE)

#5. SVM-Klassifikationsmodell erzeugen auf Basis Trainingsdaten
svm.model <- svm(class ~ ., data = bn[train.idx,])

#6/7. Prüfen der Modellperformance mit Trainingsdaten und Ausgabe der Konfusionsmatrix
(tab.train <- table(bn[train.idx,"class"], fitted(svm.model), dnn = c("Actual", "Predicted")))
round(prop.table(tab.train)*100,1) #Pozentual

#8. Erzeugen der Prognosen auf den Testdaten
pred <- predict(svm.model, bn[-train.idx,])

#9. Ausgabe der Konfusionsmatrix der Testperformance
(tab.val <- table(bn[-train.idx, "class"], pred, dnn = c("Actual", "Predicted")))
round(prop.table(tab.val)*100,1) #Pozentual

#8. Grafische Darstellung des Modells für Trainingsdaten
plot(svm.model, data=bn[train.idx,], skew ~ variance)

#9. Grafische Darstellung des Modells für Testdaten
plot(svm.model, data=bn[-train.idx,], skew ~ variance)


