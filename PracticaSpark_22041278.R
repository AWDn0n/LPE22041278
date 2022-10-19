# ID SCRIPT -----------------------------------------------------
## LEGUAJES DE PROGRAMACION ESTADISTICA
## PROFESOR : CHRISTIAN SUCUZHANAY AREVALO
## ALUMNO : PABLO RIBAS BORREGO, EXP 22041278
## PRACTICA SPARK

options(max.print = 100000)
pacman::p_load(httr, tidyverse, leaflet, janitor, readr, sparklyr)
url_ <- "https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/"
httr::GET(url_)
library(sparklyr)
library(dplyr)
library(tidyverse)
library(stringr)
library(readxl)
sc <- spark_connect(master = "local")

# Limpie los datasets


# Imprimo en un mapa interactivo la localizacion del Top 10 más caras y otro mapa interactivo del Top 20 más baratas
# Gasoleo A. Top 10 más caras
dataset %>% select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>% top_n(10, precio_gasoleo_a) %>%
  leaflet() %>% addTiles() %>% addCircleMarkers(lng = ~longitud_wgs, lat = ~latitud, popup = ~rotulo, label = ~precio_gasoleo_a)

# Gasoleo A. Top 10 más baratas
dataset %>% select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>% top_n(-20, precio_gasoleo_a) %>%
  leaflet() %>% addTiles() %>% addCircleMarkers(lng = ~longitud_wgs, lat = ~latitud, popup = ~rotulo, label = ~precio_gasoleo_a)