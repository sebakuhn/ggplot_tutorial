### Auszug aus dem QOG-Datensatz erstellen und zusätzliche Variablen hinzufügen ###
## Sebastian Kuhn. 29.09.2021 - Update April 2026

## countrycode-Paket laden
# Im QOG-Datensatz ist keine Information zur kontinentalen Zugehörigkeit der Länder enthalten.
# Das countrycode-Paket umfasst neben dieser Variable auch zahlreiche weitere länderspezifischen ID-Variablen

# install.packages("countrycode")
library(countrycode)
library(tidyverse)
library(here)

## QOG-Daten importieren
qog <- readr::read_csv("https://www.qogdata.pol.gu.se/data/qog_std_cs_jan26.csv") #Standard-Datensatz
qog_ts <- readr::read_csv("https://www.qogdata.pol.gu.se/data/qog_std_ts_jan26.csv") #Zeitreihen-Datensatz

## Informationen zu den Kontinenten zum Datensatz hinzufügen
# Standard-Datensatz
qog <- qog %>%
  mutate(continent = countrycode(ccodealp, origin = "iso3c", destination = "continent"))

# Zeitreihen-Datensatz
# Hinweis: Die Warnung "Some values were not matched unambiguously" ist erwartbar.
# Sie betrifft historische Staaten, die nicht mehr existieren (z.B. DDR, Sowjetunion,
# Jugoslawien, Tschechoslowakei). Diese erhalten NA bei der continent-Variable und
# fallen in späteren Analysen automatisch heraus.
qog_ts <- qog_ts %>%
  mutate(continent = countrycode(ccodealp, origin = "iso3c", destination = "continent"))

## Vollständige Datensätze mit Informationen zu den Kontinenten speichern
# Vorsicht - erzeugt größere Datein (194 Zeilen × 1487 Spalten). 
# Im Laufe des Skripts wird ein kleineres Sample mit weniger Variablen erzeugt.

# readr::write_csv(qog,    here("01_data/qog_full.csv"))
# readr::write_csv(qog_ts, here("01_data/qog_ts_full.csv"))

# --------------------------------------------------------------------------------------

## Samples mit ausgewählten Datensätzen erstellen und speichern:

# Sample des Standard-Datensatzes
qog_sample <-
  qog %>%
  select(
    ccodealp,
    ccode,
    cname,
    ccodecow,
    wdi_dgovhexp,
    wdi_lifexp,
    wdi_pop,
    continent,
    vdem_corr,
    wdi_popurb,
    wdi_poprul,
    wvs_pmi12,
    wvs_pmi4,
    wvs_auton,
    wdi_litrad,
    wdi_chexppgdp,
    undp_hdi,
    wdi_hwf,
    wdi_hwfr,
    wdi_hwfu,
    who_let,
    ht_colonial,
    mad_gdppc1600,
    mad_gdppc1700,
    mad_gdppc1900,
    bti_ds,
    sgi_qd,
    vdem_libdem,
    wdi_gdpcapcon2015,
    wdi_gdpcappppcon2021,
    wdi_gdppppcon2021,
    wdi_incsh10h,
    gd_ptsh,
    gd_ptsa,
    wbgi_pve)

# Sample des Zeitreihen-Datensatzes
qog_ts_sample <-
  qog_ts %>%
  select(
    year,
    ccodealp,
    ccode,
    cname,
    ccodecow,
    wdi_dgovhexp,
    wdi_lifexp,
    wdi_pop,
    continent,
    vdem_corr,
    wdi_popurb,
    wdi_poprul,
    wvs_pmi12,
    wvs_pmi4,
    wvs_auton,
    wdi_litrad,
    wdi_chexppgdp,
    undp_hdi,
    wdi_hwf,
    wdi_hwfr,
    wdi_hwfu,
    who_let,
    ht_colonial,
    mad_gdppc1600,
    mad_gdppc1700,
    mad_gdppc1900,
    bti_ds,
    sgi_qd,
    vdem_libdem,
    wdi_gdpcapcon2015,
    wdi_gdpcappppcon2021,
    wdi_gdppppcon2021,
    wdi_incsh10h,
    gd_ptsh,
    gd_ptsa,
    wbgi_pve)

## Optional: Bearbeitete Sample-Datensätze speichern
readr::write_csv(qog_sample, here("01_data/qog_sample.csv"))
rm(qog)
readr::write_csv(qog_ts_sample, here("01_data/qog_ts_sample.csv"))
rm(qog_ts)


