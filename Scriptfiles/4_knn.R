#0. Arbeitsverzeichnis aufräumen und Pfad setzen
rm(list = ls())
setwd(dir = "~/Dokumente/4._Semester/Oberseminar_Data_Mining/Datasets/")

#1. nötige Packages laden
library(class)
library(caret)

#2. Datensatz einlesen
vac <- read.csv("vacation-trip-classification.csv")

#3. Standardisieren der Einflussgrößen 'Income' and 'Family_size'
vac$Income.z <- scale(vac$Income)
vac$Family_size.z <- scale(vac$Family_size)

#4. Erzeugen von drei Partitionen für das knn-Modell
set.seed(1000)
train.idx <- createDataPartition(vac$Result, p = 0.5, list = FALSE)
train <- vac[train.idx, ]
temp <- vac[-train.idx, ]
val.idx <- createDataPartition(temp$Result, p = 0.5, list = FALSE)
val <- temp[val.idx, ]
test <- temp[-val.idx, ]

#5. Erzeugen der Prognosen für Validierungsdaten mit k=1
pred.val <- knn(train[,4:5], val[,4:5], train[,3], 1)

#6. Erzeugen der Konfusionsmatrix für k=1 für Validationsdaten
(errmat.valk1 <- table(val$Result, pred.val, dnn = c("Actual", "Predicted")))
plot(errmat.valk1, col = rainbow(2))
#7.  Erzeugen der Prognosen für Testdaten mit k=1
pred.test <- knn(train[,4:5], test[,4:5], train[,3], 1)

#8. Erzeugen der Konfusionsmatrix für k=1 für Testdaten
(errmat.test <- table(test$Result, pred.test, dnn = c("Actual", "Predicted")))
plot(errmat.test, col = rainbow(2))
                        
