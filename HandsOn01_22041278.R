# ID SCRIPT -----------------------------------------------------
## LEGUAJES DE PROGRAMACION ESTADISTICA
## PROFESOR : CHRISTIAN SUCUZHANAY AREVALO
## ALUMNO : PABLO RIBAS BORREGO, EXP 22041278
## HANDS ON 01

# SHORTCUTS -----------------------------------------------------
## Crtl + L - Limpia la consola
## Crtl + Shift + R - Nueva sección
## Ctrl + Enter - Ejecuta una línea del código
## Ctrl + Shift + Enter - Ejecuta todo el código

# GIT COMMANDS --------------------------------------------------
## git status - Estado del repositorio de git
## git init - Inicializa un repositorio
## git add - Añade archivos al índice
## git commit -m "message" - Guardar cambios en local
## git push -u origin main - Actualizar el repositorio remoto
## git branch Emilia - Crea una nueva rama en el repositorio
## git merge - Combinar ramas o repositorios
## git remote add origin url - Conecta un repositorio local con uno remoto
## git clone url - Clona un repositorio remoto a uno local de forma idéntica
## git pull
## git fetch

# TERMINAL COMMANDS ---------------------------------------------
## ls - Lista los archivos del directorio
## cd - Avanza o retrocede (..) direcctorios
## pwd - Muestra la ruta en la que nos encontramos
## mkdir - Crea un nuevo directorio
## touch
## nano
## less
## cat - Lo mismo que less pero no se puede hacer scroll
## clear - Limpia la consola
## where/which - Muestra dónde se encuentra un archivo (Windows y Linux diferente)

# LOADING LIBS --------------------------------------------------
install.packages("tidyverse")
install.packages("httr")
install.packages("janitor")

install.packages (c("tidyverse","httr","janitor"))

## Tidyverse - Ordenación de datos
## HTTR - Salir a Internet
## Janitor - Limpieza de datos

## Hay que cargar las librerías antes de usarlas
library(tidyverse)

## Si ponemos :: detrás del nombre de un paquete, sabremos qué comandos hay
## disponibles para ese paquete. Por ejemplo:
## dplyr::
## readr::

install.packages("pacman")

## Pacman - Instalador y gestor de paquetes

# BASIC OPERATORS -----------------------------------------------
cristina <- 20 ## Asigna el número 20 a la variable "cristina"
clase_lpe <- c("marta","emilia","pablo") ## Hay que usar combine (c) para guardar varios datos en la variable

# GETTING DATA FROM INTERNET ------------------------------------
df <- httr::GET("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")
glimpse(preciosEESS_es) ## Comprueba las variables de la tabla de forma sencilla en consola

library(readxl)
preciosEESS_es <- read_excel("C:/Users/pablo/Downloads/preciosEESS_es.xls", skip = 3)
View(preciosEESS_es)