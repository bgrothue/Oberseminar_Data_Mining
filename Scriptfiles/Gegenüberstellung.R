#0. Arbeitsverzeichnis aufräumen und Pfad setzen
rm(list = ls())
setwd(dir = "~/Dokumente/4._Semester/Oberseminar_Data_Mining/Datasets/")

#1. nötige Packages laden
library(MASS)
library(caret)
library(e1071)
library(nnet)
library(rpart) #Recursive Partitioning and Regression Trees
library(rpart.plot)


#2. Datensatz einlesen 
bn <- read.csv("banknote-authentication.csv")

#3. Zielvariable in factor-Variable wandeln
bn$class <- factor(bn$class)

#4. Erzeugen von zwei Partitionen
set.seed(1000)
train.idx <- createDataPartition(bn$class, p = 0.7, list=FALSE)

#5. Linear-Diskriminanzanalyse-Klassifikationsmodell erzeugen auf Basis Trainingsdaten
lda.model <- lda(class ~ ., data = bn[train.idx,])
#5. SVM-Klassifikationsmodell erzeugen auf Basis Trainingsdaten
svm.model <- svm(class ~ ., data = bn[train.idx,])
#5. Neuronales-Netz-Klassifikationsmodell erzeugen 
nnet.model <- nnet(class ~., data=bn[train.idx,],size=3,maxit=10000,decay=.001, rang = 0.05)
#5. Entscheidungsbaum-Modell erzeugen
rpart.model <- rpart(class ~ ., data = bn[train.idx, ], method =
                       "class", control = rpart.control(minsplit = 20, cp = 0.01))


#6. Erzeugen der Modell-Prognosen auf den Trainingsdaten 
bn[train.idx,"Pred"] <- predict(lda.model, bn[train.idx, 1:4])$class

#Prognostizierte Klassenzugehörigkeit der Testdaten
pred.class <- predict(rpart.model, bn[-train.idx,], type = "class") #factors
pred.prob <- predict(rpart.model, bn[-train.idx,], type = "prob") #probabilities

#8. Erzeugen der Prognosen auf den Testdaten
bn[-train.idx,"Pred"] <- predict(lda.model, bn[-train.idx, 1:4])$class

#8. Erzeugen der Prognosen auf den Testdaten
svm.pred <- predict(svm.model, bn[-train.idx,])

#6. Erzeugen der Prognosen auf den Testdaten
nnet.pred <- predict(nnet.model, newdata=bn[-train.idx,], type="class")



#9. Ausgabe der Konfusionsmatrix der Testperformance
(lda.tab <- table(bn[-train.idx, "class"], bn[-train.idx, "Pred"], dnn = c("Actual", "Predicted")))

#9. Ausgabe der Konfusionsmatrix der Testperformance
(svm.tab <- table(bn[-train.idx, "class"], svm.pred, dnn = c("Actual", "Predicted")))

#7. Ausgabe der Konfusionsmatrix der Testperformance
(nnet.tab <- table(bn[-train.idx,]$class, nnet.pred))

#Konfusionsmatrix der Klassifizierung
(rpart.tab <- table(bn[-train.idx,]$class, pred.class, dnn = c("Actual", "Predicted"))) #total