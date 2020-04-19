setwd(dr = "Dokumente/4._Semester/Oberseminar_Data_Mining/")
cp <- read.csv("college-perf.csv")

str(cp) #Ausgabe der Struktur
summary(cp) #statistische Zusammenfassung des data

# Umwandeln in factors (hier: ordinale Variablen)
cp$Perf <- ordered(cp$Perf, levels = c("Low", "Medium", "High"))
cp$Pred <- ordered(cp$Pred, levels = c("Low", "Medium", "High"))

#1. Auftrittshäufigkeiten:
tab <- table(cp$Perf, cp$Pred, dnn = c("Actual", "Predicted"))
tab

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
