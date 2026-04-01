### Datenvisualisierung mit ggplot2 - Teil 2: Das erste Scatterplot
## Sebastian Kuhn. 29.09.2021 - Update April 2026

## Wichtige Pakete laden und Datensatz importieren
library(tidyverse) # lädt alle Pakete des "tidyverse" - unter anderem ggplot2 und readr
library(here)

## QOG-Samle-Datensatz - beispielsweise mit
qog <- read.csv(here("01_data/qog_sample.csv"))

## Für den Import der originalen Version des QOG Standard_Datensatzes:
#qog <- readr::read_csv("https://www.qogdata.pol.gu.se/data/qog_std_cs_jan21.csv") #Standard-Datensatz

### -------------------------------------------------------------------------------------------------------

### Und los geht's!: Das erste Streudiagramm
## Variablen:

# wdi_dgovhexp
#   Öffentliche Ausgaben für Gesundheit aus inländischen Quellen als Anteil der Wirtschaft,
#   gemessen am BIP.
# wdi_lifexp
#   Die Lebenserwartung bei der Geburt gibt die Anzahl der Jahre an, die ein
#   Neugeborenes leben würde, wenn die zum Zeitpunkt seiner Geburt vorherrschenden
#   Sterblichkeitsmuster zum Zeitpunkt seiner Geburt sein ganzes Leben lang gleich bleiben würden.

## Daten übergeben
ggplot(data = qog)
ggplot(qog) # Führt zum selben Ergebnis

# Das "Mapping-Argument" - die Zuordnung von Variablen zu Aesthetics
ggplot(qog, aes(x = wdi_dgovhexp, y = wdi_lifexp))

# Das erste Streudiagramm
ggplot(qog, aes(x = wdi_dgovhexp, y = wdi_lifexp)) + # Neue Ebenen werden mit dem "+"-Operator hinzugefügt
  geom_point()

### -------------------------------------------------------------------------------------------------------

### ggplot-Befehle sinnvoll aufbauen

# Das erste Streudiagramm - kürzere Variante
ggplot(qog, aes(wdi_dgovhexp, wdi_lifexp)) + geom_point()

# Das erste Streudiagramm - kürzere Variante mit anderer Reihenfolge
ggplot(qog, aes(wdi_lifexp, wdi_dgovhexp)) + geom_point()

# Das erste Streudiagramm - y vor x
ggplot(qog, aes(y = wdi_lifexp, x = wdi_dgovhexp)) + geom_point()

# Das erste Streudiagramm - y vor x
ggplot(qog, aes(y = wdi_lifexp, x = wdi_dgovhexp)) +
  geom_point() # Zur besseren Lesbarkeit und Übersicht bitte in einer neuen Zeile

# Daten und Mapping in "p" zwischenspeichern
p <- ggplot(qog, aes(y = wdi_lifexp, x = wdi_dgovhexp))
p

# Darstellung als Scatterplot
p + geom_point()

# Darstellung als Liniendiagramm
p + geom_line()

# Darstellung mit Dichte-Plot
p + geom_density_2d() +
  geom_point()
