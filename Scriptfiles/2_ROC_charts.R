#0. Arbeitsverzeichnis aufräumen und pfad setzen
rm(list = ls())
setwd(dr = "Dokumente/4._Semester/Oberseminar_Data_Mining/")

#1. load requiered packages
library(ROCR)

#2.read data
dat <- read.csv("roc-example-1.csv")
#show data
head(dat)
#3. Create the prediction object:
pred <- prediction(dat$prob, dat$class)
#4. Create the performance object:
perf <- performance(pred, "tpr", "fpr")
#5. Plot the chart:
plot(perf)
#45 grad Linie zum vergleich
lines( par()$usr[1:2], par()$usr[3:4] )

#6. Find the cutoff values for various true positive rates. Extract the relevant data from
#the perf object into a data frame prob.cuts :
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
