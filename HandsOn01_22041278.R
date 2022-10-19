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

# INSTALLING KAGGLE ---------------------------------------------
## pip install kaggle - Instalación de Kaggle
## mkdir .kaggle - Creamos una carpeta para guardar el Token de la API
## Una vez guardada la clave de la API, ya podemos usar Kaggle por terminal

# KAGGLE COMMANDS -----------------------------------------------
## kaggle datasets -h - Help para comandos de Kaggle
## kaggle datasets list -s "keyword" - Busca datasets en Kaggle que coincidan
## kaggle datasets download -d [user/dataset] - Descarga el dataset que queremos

# CONFIGURING SSH -----------------------------------------------
## gh auth login - Inicia el proceso
## Elegimos GitHub.com
## Elegimos SSH
## Decimos que sí queremos añadir una nueva clave SSH
## Ponemos una contraseña si se desea (guardada en WhatsApp)
## Ponemos el título que queramos
## Autenticamos mediante login con un navegador
## Copiamos el código, damos enter dentro del terminal y pegamos el código
## Autorizamos, ponemos nuestra contraseña de GitHub y... ¡listo!

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
## git pull - Descarga contenido de un repositorio remoto al local y actualiza el existente
## git fetch - Descarga archivos de un repositorio remoto

# TERMINAL COMMANDS ---------------------------------------------
## ls - Lista los archivos del directorio
## cd - Avanza o retrocede (..) direcctorios
## pwd - Muestra la ruta en la que nos encontramos
## mkdir - Crea un nuevo directorio
## touch - Permite actualizar la fecha de acceso al archivo
## nano - Abre un editor en la línea de comandos
## less - Muestra archivos de texto
## cat - Lo mismo que less pero no se puede hacer scroll
## clear - Limpia la consola
## where/which - Muestra dónde se encuentra un archivo (Windows y Linux diferente)

# LOADING LIBS --------------------------------------------------
install.packages("tidyverse")
install.packages("httr")
install.packages("janitor")

## Usando combine
install.packages (c("tidyverse","httr","janitor"))

## Tidyverse - Ordenación de datos
## HTTR - Salir a Internet
## Janitor - Limpieza de datos

## Hay que cargar las librerías antes de usarlas
library(tidyverse)
library(httr)
library(janitor)

## Si ponemos :: detrás del nombre de un paquete, sabremos qué comandos hay
## disponibles para ese paquete. Por ejemplo:
## dplyr::
## readr::

install.packages("pacman")

## Pacman - Instalador y gestor de paquetes

pacman::p_load(httr, tidyverse, leaflet, janitor, readr, sparklyr)
library(sparklyr)
library(dplyr)
library(tidyverse)
library(stringr)
library(readxl)

# BASIC OPERATORS -----------------------------------------------
cristina <- 20 ## Asigna el número 20 a la variable "cristina"
clase_lpe <- c("marta","emilia","pablo") ## Hay que usar combine (c) para guardar varios datos en la variable

# GETTING DATA FROM INTERNET ------------------------------------
library(readxl)
preciosEESS_es <- read_excel("C:/Users/pablo/Downloads/preciosEESS_es.xls", skip = 3)
glimpse(preciosEESS_es) ## Comprueba las variables de la tabla de forma sencilla en consola
View(preciosEESS_es)

res_ <- httr::GET("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")

## Hay que leer el contenido de la respuesta provista por el servidor
xml2::read_xml(res_$content)

## READING AND WRITING (FILES) ----------------------------------
## Guardamos la url en una variable y usamos jsonlite para sacar los datos de forma fácil, rápida y directa
url_ <- "https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/"
f_raw <- jsonlite::fromJSON(url_)

## Guardamos el dataframe en una variable y lo visualizamos
df_source <- f_raw$ListaEESSPrecio %>% glimpse()
view(df_source)

## Tiene una columna más que cuando los descargamos manualmente desde la página a nuestro ordenador porque
## se hizo mediante una API

## Usamos janitor para poner los nombres de las variables bien y luego type_convert para arreglar las variables
df_source %>% janitor::clean_names() %>% type_convert(locale = locale(decimal_mark = ",")) %>% glimpse()

## Tras haber visto con los pipe que nos gusta como queda el dataframe, lo guardamos en una variable nueva
df <- df_source %>% janitor::clean_names() %>% type_convert(locale = locale(decimal_mark = ","))
df %>% glimpse()

# CREATING NEW VARIABLES ------------------------------------------
## Clasificamos por gasolineras baratas y no baratas
df %>% view()

## Creamos la variable "expensive" en el dataframe, basado en las gasolineras caras
df %>% mutate(expensive = rotulo %in% c("CEPSA", "REPSOL", "SHELL", "BP")) %>% view()
ds22041278_33 <- df %>% mutate(expensive = rotulo %in% c("CEPSA", "REPSOL", "SHELL", "BP"))

## Calculamos el precio medio de la gasolina por CCAA
ds22041278_33 %>% select(precio_gasoleo_a, idccaa, rotulo, expensive) %>% drop_na() %>% group_by(idccaa, expensive) %>% summarise(mean(precio_gasoleo_a)) %>% view()

## EJERCICIO: Crear una columna que informe a qué comunidad autónoma corresponde cada ID
## Primero duplicaremos el dataframe a uno nuevo
ds22041278_34 <- ds22041278_33

## Hace falta instalar el paquete de plyr e importarlo.
install.packages("plyr")
library(plyr)

## Los datos de los IDs de las CCAA se encontraron en: https://www.ine.es/daco/daco42/codmun/cod_ccaa.htm
## Usando la función mapvalues de plyr, mapeamos los valores de la columna idccaa y les asignamos las CCAA correspondientes en una nueva columna llamada ccaa
ds22041278_34$ccaa <- plyr::mapvalues(ds22041278_34$idccaa, from = c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19"), 
                                      to = c("Andalucía", "Aragón", "Principado de Asturias", "Illes Balears", "Canarias", "Cantabria", "Castilla y León", "Castilla - La Mancha", 
                                             "Cataluña", "Comunitat Valenciana", "Extremadura", "Galicia", "Comunidad de Madrid", "Región de Murcia", "Comunidad Foral de Navarra",
                                             "País Vasco", "La Rioja", "Ceuta", "Melilla"))
ds22041278_34 %>% view()

## Por último, exportamos los dataframes como CSV al ordenador
write.csv(ds22041278_33,"C:/Users/pablo/Documents/R Projects/LPE22041278/ds22041278_33.csv", row.names = FALSE)
write.csv(ds22041278_34,"C:/Users/pablo/Documents/R Projects/LPE22041278/ds22041278_34.csv", row.names = FALSE)

# INTERACTIVE MAPS WITH LEAFLET ----------------------------------
## Instalamos y cargamos la librería de Leaflet
install.packages("leaflet")
library(leaflet)

## Imprimo en un mapa interactivo la localizacion del Top 10 más caras y otro mapa interactivo del Top 20 más baratas de Málaga
## Gasoleo A. Top 10 más caras
ds22041278_34 %>% select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>% top_n(10, precio_gasoleo_a) %>%
  leaflet() %>% addTiles() %>% addCircleMarkers(lng = ~longitud_wgs84, lat = ~latitud, popup = ~rotulo, label = ~precio_gasoleo_a)

## EJERCICIO: Crear un mapa interactivo con el Top 20 de gasolineras más baratas de MÁLAGA
## Disponible en el link de RPubs: https://rpubs.com/AWDn0n/LPE22041278_19102022
ds22041278_34 %>% filter(provincia == "MÁLAGA") %>% select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>% top_n(-20, precio_gasoleo_a) %>%
  leaflet() %>% addTiles() %>% addCircleMarkers(lng = ~longitud_wgs84, lat = ~latitud, popup = ~rotulo, label = ~precio_gasoleo_a)
