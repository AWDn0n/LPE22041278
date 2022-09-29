# ID SCRIPT -----------------------------------------------------
## LEGUAJES DE PROGRAMACION ESTADISTICA
## PROFESOR : CHRISTIAN SUCUZHANAY AREVALO
## ALUMNO : PABLO RIBAS BORREGO, EXP 22041278
## CARGA DATOS POD II

# R SCRIPT ------------------------------------------------------
## Instalamos y cargamos las librerías
install.packages (c("tidyverse","httr","janitor"))

library(tidyverse)
library(httr)
library(janitor)

# GET METHOD -----------------------------------------------------
## Hacemos el GET de los datos con la URL de la página desde la que se descargan (Kaggle)
## NO FUNCIONA, SOLO DEVUELVE EL CÓDIGO FUENTE DE LA PÁGINA DE KAGGLE 
df_web <- httr::GET("https://www.kaggle.com/datasets/susant4learning/holiday-package-purchase-prediction/download?datasetVersionNumber=1", 
          httr::authenticate("pabloribasborrego", "0ef592c3770cc8b06b7f6fa9776a585f", type = "basic"))

## Creamos un archivo temporal
temp <- tempfile()

## Descargamos el archivo y lo guardamos en el temp
download.file(df_web$url,temp)

## Descomprimimos el zip en el que se encuentra el CSV de nuestros datos
data <- read.csv(unz(temp, "Travel.csv"))

## Desenlazamos temp pues ya no lo vamos a usar
unlink(temp)

## Hacemos un glimpse de los datos para ver valores iniciales y tipos de los mismos
glimpse(df_web)

# Por último visualizamos el dataset completo con view
View(df_web)

# READ_CSV METHOD ----------------------------------------------------
## Ahora hacemos lo mismo leyendo el csv desde nuestro ordenador con el comando read_csv() de Readr
df_pc <- read_csv("C:/Users/pablo/Downloads/Travel.csv")
glimpse(df_pc)
View(df_pc)