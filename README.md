# Datenvisualisierung mit ggplot2 — Eine Einführung

Ein praxisorientiertes Tutorial zur Datenvisualisierung mit dem R-Paket `ggplot2`. Basiert auf einem älteren Videotutorial aus dem jahr 2021, das ich einmal für die FernUniversität in Hagen gemacht hatte. Update und Revision im April 2026.
Datenbasis: [Quality of Government (QOG) Datensatz](https://www.gu.se/en/quality-government/qog-data).

## Inhalt

| Datei | Thema |
|---|---|
| `02_code/01_Sample_Datensatz_erstellen.R` | Auszug aus dem QOG-Datensatz erstellen |
| `02_code/02_Das_erste_Scatterplot.R` | Grundlagen: erstes Streudiagramm |
| `02_code/03_Erweiterte_Scatterplots.R` | Scatterplot anpassen und erweitern |
| `02_code/04_Kategoriale_und_kontinuierliche_Variablen_visualisieren.R` | Balken-, Box- und Violinplots |
| `02_code/05_Zeitreihen_und_facets.R` | Zeitreihen und facet_wrap |
| `03_markdown/Einführung_ggplot2_Skript.Rmd` | Vollständiges Tutorial als R Markdown |

## Wichtigste Voraussetzungen

- R (>= 4.0)
- RStudio
- Pakete: `tidyverse`, `ggplot2`, `countrycode`

```r
install.packages(c("tidyverse", "countrycode"))
```

## Verwendete Daten

Die Skripte laden den QOG-Datensatz direkt von der Projektwebsite. Für die Offline-Nutzung liegen zwei Sample-Dateien unter `01_data/` bereit:

- `qog_sample.csv` — Querschnittsdaten
- `qog_ts_sample.csv` — Zeitreihendaten

## Autor

Sebastian Kuhn
