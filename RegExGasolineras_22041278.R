# ID SCRIPT -----------------------------------------------------
## LEGUAJES DE PROGRAMACION ESTADISTICA
## PROFESOR : CHRISTIAN SUCUZHANAY AREVALO
## ALUMNO : PABLO RIBAS BORREGO, EXP 22041278
## EJERCICIO REGEX

# LOADING LIBS --------------------------------------------------
## Instalamos las librerías necesarias
if(!require("pacman")) install.packages("pacman")
p_load(tidyverse, httr, janitor, magrittr)

# READING AND WRITING (FILES) ----------------------------------
## Obtenemos los datos con la URL de la API
url_ <- "https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/"
f_raw <- jsonlite::fromJSON(url_)

## Lo guardamos como Tibble
df_source <- f_raw$ListaEESSPrecio %>% as_tibble() %>% glimpse()

## Limpiamos los nombres
df <- df_source %>% janitor::clean_names() %>% type_convert(locale = locale(decimal_mark = ",")) %>% glimpse()

## Utilizamos expresiones regulares para obtener las gasolineras que son franquicias
## (aquellas que tienen S.A. o S.L. en su nombre como se especificó en clase) y después
## creamos una columna que indique si es una franquicia o no (TRUE o FALSE). Se tuvo en
## cuenta que es posible que haya rótulos en los que S.A. y S.L. se respresentaron sin puntos,
## es decir, SA y SL.
df %<>% tidyr::extract(rotulo, c("extension"), "(S\\.L|S\\.A|\\bSL\\b|\\bSA\\b)", remove = F) %>% 
  mutate(marca_franquicia = extension %in% c("SL", "SA", "S.A", "S.L"))

df$marca_franquicia <- plyr::mapvalues(df$marca_franquicia, from = c("TRUE", "FALSE"), to = c("FRANQUICIA", "MARCA"), warn_missing = F)
df %>% view()

## Podemos filtrar y ver cuántas franquicias hay
df %>% filter(marca_franquicia == "FRANQUICIA") %>% view()
