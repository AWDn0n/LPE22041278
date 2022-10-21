# ID SCRIPT -----------------------------------------------------
## LEGUAJES DE PROGRAMACION ESTADISTICA
## PROFESOR : CHRISTIAN SUCUZHANAY AREVALO
## ALUMNO : PABLO RIBAS BORREGO, EXP 22041278
## HANDS ON 02

# CASE STUDY FROM 0 TO HERO -------------------------------------
## Your profile name and handson number + link to the repo
browseURL("https://github.com/AWDn0n/LPE22041278")

# INSTALL AND LOAD LIBRARIES ------------------------------------
if(!require("pacman")) install.packages("pacman")
pacman::p_load(pacman, magrittr, productplots, psych, RColorBrewer, tidyverse)

## Magrittr = Piping bidireccional
## ProductPlots = Representar gráficamente variables categóricas
## Psych = Estadísticos
## RColorBrewer = Pintar y paleta de colores

# LOAD AND PREPARE DATA ------------------------------------------
browseURL("http://j.mp/37Wxvv7")
?happy

## ?dataset = Documentación del dataset

df <- happy %>% as_tibble
view(df)

## Check happiness levels
levels(df$happy)

## Reverse levels with Magrittr
df %<>% mutate(happy = fct_rev(happy))

# OUTCOME VARIABLES: HAPPINESS ------------------------------------
df %>% ggplot() + geom_bar(aes(happy, fill = happy)) + theme(axis.title.x = element_blank(), legend.position = "none")
browseURL("https://rpubs.com/AWDn0n/LPE22041278_21102022_01")

## Frequencies for happy
df %>% count(happy)

## Replace missing values
df %<>% select(happy:health) %>% view()
df %<>% filter(!is.na(happy))

# HAPPINESS AND GENDER --------------------------------------------
df %>% ggplot(aes(sex, fill = happy)) + geom_bar(position = "fill")
browseURL("https://rpubs.com/AWDn0n/959692")

# HAPPINESS AND MARITAL STATUS ------------------------------------
df %>% ggplot(aes(marital, fill = happy)) + geom_bar(position = "fill")
browseURL("https://rpubs.com/AWDn0n/959699")

# HAPPINESS AND EDUCATION LEVEL -----------------------------------
df %>% ggplot(aes(degree, fill = happy)) + geom_bar(position = "fill")
browseURL("https://rpubs.com/AWDn0n/959712")

# HAPPINESS AND MONEY --------------------------------------------
df %>% ggplot(aes(finrela, fill = happy)) + geom_bar(position = "fill")
browseURL("https://rpubs.com/AWDn0n/959713")

# HAPPINESS AND HEALTH --------------------------------------------
df %>% ggplot(aes(health, fill = happy)) + geom_bar(position = "fill")
browseURL("https://rpubs.com/AWDn0n/959714")

# DICHOTOMOUS MARRIED / NOT VARIABLE ------------------------------
df %<>% mutate(married = if_else(marital == "married", "yes", "no")) %>% mutate(married = as_factor(married)) %>% view()