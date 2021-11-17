### Datenvisualisierung mit ggplot2 - Teil 4: Darstellung kategorialer und kontinuierlicher Variablen
### -------------------------------------------------------------------------------------------------------

## Wichtige Pakete laden und Datensatz importieren
library(tidyverse) # lädt alle Pakete des "tidyverse" - unter anderem ggplot2 und readr
library(here)

## Verwenden Sie bitte den Auszug aus dem QOG-Datensatz - beispielsweise mit
qog <- read.csv("01_data/qog_sample.csv") # Laufwerk und Verzeichnis ggf. anpassen

### -------------------------------------------------------------------------------------------------------

# Balkendiagramm: Anzahl der Länder je Kontinent
p <- ggplot(qog, aes(x = continent))
p + geom_bar()

# Balkendiagramm: Anzahl der Länder je Kontinent
p <- ggplot(qog, aes(x = continent))
p + geom_bar(fill = "deepskyblue", color = "black") + #Anpassung der Balkenfarbe und -Umrandung
  labs(x = "Kontinent",
       y = "Anzahl Länder",
       title = "Anzahl der Länder je Kontinent (im QOG-Datensatz)") + # Achsenbeschriftung und Titel
  theme_minimal() #Minimalistische Darstellung ohne Achsen und mit wenigen Hilfslinien
#theme_classic() #Darstellung mit weißem Hintergrund und ohne Hilfslinien
#theme_grey() #Zum Vergleich: die voreingestellte Standarddarstellung von ggplot

# Balkendiagramm: Anzahl der Länder je Kontinent
p + geom_bar(fill = "deepskyblue", color = "black") + #Anpassung der Balkenfarbe und -Umrandung
  labs(x = "Kontinent",
       y = "Anzahl Länder",
       title = "Anzahl der Länder je Kontinent (im QOG-Datensatz)") +
  #Anpassung einzelner Elemente in der theme()-Funktion
  theme(panel.border = element_blank(),
        panel.grid.major = element_line(color = "red"),
        panel.grid.minor = element_line(color = "turquoise2"),
        axis.line = element_line(colour = "green"),
        panel.background = element_rect(fill = "magenta4"),
        plot.background = element_rect(fill = "green"))

# Die colors()-Funktion gibt einen Überblick über die "namentlich bekannten" Farben in R.
colors()

# Balkendiagramm: Anzahl der Länder je Kontinent - eingefärbt nach Kontinenten
p <- ggplot(qog, aes(x = continent, fill = continent))
p + geom_bar()

# Verschiedene Optionen zur Platzierung der Legende
p + geom_bar() +
  # theme(legend.position = "bottom") # Legende unten
  # theme(legend.position = "top") # Legende oben
  # theme(legend.position = "left") # Legende links
  # theme(legend.position = "right") # Legende rechts
  theme(legend.position = "") # Keine Legende

# Manuelle Einfärbung der Balken
p + geom_bar() +
  scale_fill_manual(values = c("green", "blue", "grey", "black", "red")) +
  theme(legend.position = "")

# RColorBrewer-Paket laden
library(RColorBrewer)
# Überblick über die dort enthaltenen Farbskalen
display.brewer.all()

p + geom_bar() +
  scale_fill_brewer(palette = "Accent") +
  # scale_fill_brewer(palette = "Greens") +
  # scale_fill_brewer(palette = "Dark2") +
  # scale_fill_brewer(palette = "Spectral") +
  labs(x = "Kontinent",
       y = "Anzahl Länder",
       title = "Anzahl der Länder je Kontinent (im QOG-Datensatz)") +
  theme_classic() +
  theme(legend.position = "")

### -------------------------------------------------------------------------------------------------------

# Häufigkeitsverteilung der Variable "Lebenserwartung" (Histogramm)
p <- ggplot(qog, aes(x = wdi_lifexp))
p + geom_histogram()

# Häufigkeitsverteilung der Variable "Lebenserwartung" (Histogramm)
p + geom_histogram(color = "black", fill = "white") #Variante mit 30 bins (automatisch von
                                                    #ggplot festgelegt) und in schwarz/weiß
p + geom_histogram(bins = 20,
                   color = "darkgrey", fill = "Cyan") #20 bins mit den Farben "Cyan"
                                                      #(blau/grün) und einem dunklen Grau
p + geom_histogram(bins = 10,
                   color = "#000000", fill = "#FF0000") #10 bins, #000000 ist der Hex-Code für
                                                        #"schwarz" und "#FF0000" für "rot"

# Weitere Darstellungsformen als Alternativen zu Histogrammen:
p + geom_density()
p + geom_area(stat = "bin", binwidth = 1)
p + geom_freqpoly()
p + geom_dotplot(fill = "white", color = "black")

### -------------------------------------------------------------------------------------------------------

# Boxplot des Human Development Index in Abhängigkeit des jeweiligen Kontinents
#Schwarz/weiß
p <- ggplot(qog, aes(y=undp_hdi, x = continent))
p + geom_boxplot()

# Eingefärbt nach Kontinent
p <- ggplot(qog, aes(y=undp_hdi, x = continent, fill = continent))
p + geom_boxplot() +
  theme(legend.position = "") # Keine Legende

# Boxplot inkl. der einzelnen Datenpunkte
p + geom_boxplot(outlier.shape = NA) + #Keine Darstellung der Ausreißer als Punkte
  geom_point() +
  theme(legend.position = "")

# Boxplot inkl. der einzelnen Datenpunkte
p + geom_boxplot(outlier.shape = NA) +
  geom_jitter(width = 0.1)+ #Kleine Zufallsvariation
  # geom_jitter(width = 0.5)+ #Große Zufallsvariation
  theme(legend.position = "")

p + geom_boxplot(outlier.shape = NA) +
  geom_jitter(width = 0.1, shape = 21, fill = "white", alpha = 0.75) +
  theme(legend.position = "")

# Violin-Plots als Alternativen zu Boxplots
p + geom_violin()
# Kombination aus Violin- und Boxplot
p + geom_violin(color = NA, bw = .02) +
  geom_boxplot(fill = "white", alpha = 0.75)

# Zusätzlich benötigte Pakete laden
library(ggdist)
library(cowplot)
# "Regenwolken-Plot"
p + stat_halfeye(adjust = .5, width = .6, .width = 0, justification = -.3, point_colour = NA) +
  geom_boxplot(width = .2, outlier.shape = NA) +
  geom_jitter(width = 0.1, size = 1.5, alpha = .3) +
  labs(x = "Kontinent",
       y = "Human-Developement-Index",
       title = "HDI nach Kontinenten") +
  scale_y_continuous(limits = c(0.4, 1.0),
                     breaks = seq(0.4, 1.0, 0.1)) +
  theme_minimal_hgrid(12) +
  theme(legend.position = "")

# "Regenwolken-Plot" - in der gedrehten Variante
p + stat_halfeye(adjust = .5, width = .6, .width = 0, justification = -.3, point_colour = NA) +
  geom_boxplot(width = .2, outlier.shape = NA) +
  geom_jitter(width = 0.1, size = 1.5, alpha = .3) +
  labs(x = "Kontinent",
       y = "Human-Developement-Index",
       title = "HDI nach Kontinenten") +
  scale_y_continuous(limits = c(0.4, 1.0),
                     breaks = seq(0.4, 1.0, 0.1)) +
  theme_minimal_hgrid(12) +
  theme(legend.position = "") +
  coord_flip() # Hier wird die Darstellung einfach gedreht
