#0. Arbeitsverzeichnis aufräumen und Pfad setzen
rm(list = ls())
setwd(dr = "~/Dokumente/4._Semester/Oberseminar_Data_Mining/Datasets/")

#1. nötige Packages laden
library(MASS)
library(caret)

#2. Datensatz einlesen 
bn <- read.csv("banknote-authentication.csv")

#3. Zielvariable in factor-Variable wandeln
bn$class <- factor(bn$class)

#4. Erzeugen von zwei Partitionen
set.seed(1000)
train.idx <- createDataPartition(bn$class, p = 0.7, list=FALSE)

#5. Linear-Diskriminanzanalyse-Klassifikationsmodell erzeugen auf Basis Trainingsdaten
lda.model <- lda(bn[train.idx, 1:4], bn[train.idx, 5])
#lda.model <- lda(class ~ ., data = bn[train.idx,])

#6. Erzeugen der Modell-Prognosen auf den Trainingsdaten 
bn[train.idx,"Pred"] <- predict(lda.model, bn[train.idx, 1:4])$class

#7. Ausgabe der Konfusionsmatrix der Trainingsperformance
table(bn[train.idx, "class"], bn[train.idx, "Pred"], dnn = c("Actual", "Predicted"))

#8. Erzeugen der Prognosen auf den Testdaten
bn[-train.idx,"Pred"] <- predict(lda.model, bn[-train.idx, 1:4])$class

#9. Ausgabe der Konfusionsmatrix der Testperformance
table(bn[-train.idx, "class"], bn[-train.idx, "Pred"], dnn = c("Actual", "Predicted"))
