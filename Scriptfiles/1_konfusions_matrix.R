#0. Arbeitsverzeichnis aufräumen und Pfad setzen
rm(list = ls())
setwd(dir = "~/Dokumente/4._Semester/Oberseminar_Data_Mining/Datasets/")

#1. read data
cp <- read.csv("college-perf.csv")

str(cp) #Ausgabe der Struktur
summary(cp) #statistische Zusammenfassung des data

class(cp$Perf)

#2. Umwandeln in factors (hier: kategorial zu ordinal)
cp$Perf <- ordered(cp$Perf, levels = c("Low", "Medium", "High"))

cp$Pred <- ordered(cp$Pred, levels = c("Low", "Medium", "High"))

class(cp$Perf)

#3. Auftrittshäufigkeiten: dnn: dimension names
(tab <- table(cp$Perf, cp$Pred, dnn = c("Wahrer Wert", "Prognose")))


#4. relative Häufigkeiten:
prop.table(tab)
#4.1 prozentual:
round(prop.table(tab)*100,1)

#5. Darstellung der Wahrscheinlichkeiten zeilenweise
#prop.table(tab, 1)
#5.1 Darstellung zeilenweise in Prozenten
round(prop.table(tab, 1)*100, 1)

#6.1 Visualisierung als Barplot
barplot(tab, legend = TRUE)

#6.2 Visualisierung als Mosaikplot
mosaicplot(tab, main="Prediction performance", color = rainbow(3))
