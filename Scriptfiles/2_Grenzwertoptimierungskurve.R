#0. Arbeitsverzeichnis aufräumen und pfad setzen
rm(list = ls())
setwd(dir = "~/Dokumente/4._Semester/Oberseminar_Data_Mining/Datasets/")
getwd()

#1. nötige Packages laden
library(ROCR)

#2. Datensatz einlesen
dat <- read.csv("roc-example-1.csv")

# Ersten sechs Einträge ausgeben
head(dat)

#3. Erzeugen des prediction-Objekts
pred <- prediction(dat$prob, dat$class)

str(pred)

#4. Erzeugen des performance- Objekts
perf <- performance(pred, "tpr", "fpr")

str(perf)

#5. Ausgeben der Grenzwertoptimierungskurve
plot(perf)

#45 grad Linie zum vergleich
lines( par()$usr[1:2], par()$usr[3:4] )

#6. Extrahieren der Schwellenwerte (cutoff-values) aus dem performance-Objekt
prob.cuts <- data.frame(cut=perf@alpha.values[[1]], fpr=perf@x.values[[1]], tpr=perf@y.values[[1]])
head(prob.cuts)
tail(prob.cuts)

#7. alternative mit nicht numerischen labels (factoren müssen geordnet werden)
dat <- read.csv("roc-example-2.csv")
#bei der prognose muss order angegeben werden
pred <- prediction(dat$prob, dat$class, label.ordering = c("non-buyer", "buyer"))
perf <- performance(pred, "tpr", "fpr")
plot(perf)
lines( par()$usr[1:2], par()$usr[3:4] )
