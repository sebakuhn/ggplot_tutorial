### Datenvisualisierung mit ggplot2 - Teil 5: Zeitreihen und facets
### -------------------------------------------------------------------------------------------------------

## Wichtige Pakete laden und Datensatz importieren
library(tidyverse) # lädt alle Pakete des "tidyverse" - unter anderem ggplot2 und readr
library(here)

## Verwenden Sie bitte den Auszug aus dem QOG-Zeitreihen-Datensatz - beispielsweise mit
qog_ts <- read.csv("01_data/qog_ts_sample.csv") # Laufwerk und Verzeichnis ggf. anpassen



# Variante 1 (Zweistufig): ---------------------------------------
# 1: Teildatensatz erstellen und speichern
poland_2000 <- filter(qog_ts, cname == "Poland" & year >1999)

# 2: Visualisierung mit ggplot
p <- ggplot(poland_2000, aes(x=year,  y=vdem_libdem))
p + geom_line()

# Variante 2 ------------------------------------------------------
# ggplot in die dplyr-Pipe "einbauen"

  #"Nimm den Datensatz "qog_ts" und dann...
p <- qog_ts %>%
  #...verwende nur Daten aus Polen und nach 1999 und dann...
  filter(cname == "Poland" & year > 1999) %>%
  # ...verwende diese Daten in der ggplot-Funktion."
  ggplot(aes(x=year,  y=vdem_libdem))

# Liniendiagramm darstellen
p + geom_line()

# Skalierung anpassen
p + geom_line() +
scale_y_continuous(limits = c(0,1))  # Anpassung der Skalierung der Y-Achse

# Darstellungsversuch für ganz Europa
p <- qog_ts %>%
  filter(continent == "Europe" & year > 1999) %>%
  ggplot(aes(x=year,  y=vdem_libdem))

# Liniendiagramm darstellen
p + geom_line()

# Darstellungsversuch für ganz Europa 2
p + geom_line(aes(group = cname))

# Darstellungsversuch für ganz Europa mit facets
p + geom_line() +
  scale_y_continuous(limits = c(0,1)) + # Anpassung der Skalierung der Y-Achse
facet_wrap(.~cname)

# Fehlende Werte in der dplyr-Pipeline ausschließen
p <- qog_ts %>%
  select(cname, continent, year, vdem_libdem) %>%
  filter(continent == "Europe" & year > 1999) %>%
  drop_na() %>%
  ggplot(aes(x=year,  y=vdem_libdem))

# Liniendiagramme für die einzelnen Länder darstellen
p + geom_line() +
  scale_y_continuous(limits = c(0,1)) + # Anpassung der Skalierung der Y-Achse
  labs (x = "Jahr",
        y = "Vanhanen-Index",
        title = "Entwicklung der Demokratisierung in Europa seit 2000",
        caption = "Quelle: QOG-Datensatz") +
  facet_wrap(.~cname, ncol = 5) + # mit "ncol" wird die Anzahl der Spalten gesteuert
   theme_classic() +
  #theme_minimal() +
  theme(axis.text.x = element_text(angle = 90)) # Text auf der x-Achse drehen

# Bevölkerungsentwicklung in Ruanda
qog_ts %>%
  filter(ccodealp == "RWA") %>%
  ggplot(., aes(x=year,  y=wdi_pop)) +
  geom_line()

# Annotierte Darstellung der Bevölkerungsentwicklung in Ruanda
# Beachten Sie, dass Sie für den Codeblock das Paket "scales" benötigen.
# install.packages("scales")
# library(scales)

qog_ts %>%
  filter(ccodealp == "RWA" & year > 1960) %>%
  ggplot(aes(x=year,  y=wdi_pop, color = cname)) +
  geom_line(size = 2) +
  geom_point(size = 2, shape = 21, color = "black", fill = "white") +
  labs(title = "Bevölkerungsentwicklung in Ruanda",
       x ="Jahr",
       y="Bevölkerungszahl") +
  scale_y_continuous(label = scales::comma_format(big.mark = ".", decimal.mark = ",")) +
  scale_x_continuous(breaks = seq(1960, 2020, 5)) +
  annotate("rect", xmin = 1990, xmax = 1994, ymin = -Inf, ymax = Inf, alpha = .2) +
  annotate("text", x = 1992, y = 10000000, angle = 90, label = "1990-1994: Bürgerkrieg und Genozid") +
  theme_classic() +
  theme(legend.position = "none")

