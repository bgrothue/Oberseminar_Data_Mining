#0. Arbeitsverzeichnis aufräumen und pfad setzen
rm(list = ls())
setwd("Dokumente/4._Semester/Oberseminar_Data_Mining/")

#read data
cp <- read.csv("college-perf.csv")

str(cp) #Ausgabe der Struktur
summary(cp) #statistische Zusammenfassung des data

class(cp$Perf)

# Umwandeln in factors (hier: ordinale Variablen)
cp$Perf <- ordered(cp$Perf, levels = c("Low", "Medium", "High"))

cp$Pred <- ordered(cp$Pred, levels = c("Low", "Medium", "High"))

class(cp$Perf)

#1. Auftrittshäufigkeiten: dnn: dimension names
(tab <- table(cp$Perf, cp$Pred, dnn = c("Actual", "Predicted")))


#2. relative Häufigkeiten:
prop.table(tab)
#2.1 prozentual:
round(prop.table(tab)*100,1)

#3. Darstellung der Wahrscheinlichkeiten zeilenweise
#prop.table(tab, 1)
#3.1 Darstellung zeilenweise in Prozenten
round(prop.table(tab, 1)*100, 1)

#4.1 Visualisierung als Barplot
barplot(tab, legend = TRUE)

#4.2 Visualisierung als Mosaikplot
mosaicplot(tab, main="Prediction performance", color = rainbow(3))
