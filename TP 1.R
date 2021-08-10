# Librerias: Llamamos las librerias necesarias para el desarrollo del trabajo

library(tidyverse)
library(tidyr)
library(readr)
library(vroom)


# Importando datos 1: Con la funcion base de R 

campanasverdes1 <- read.csv("campanas_verdes.csv",encoding = "UTF-8", stringsAsFactors = TRUE)

# Importando datos 2: Con la funcion de la libreria readr

campanasverdes2 <- read_csv("campanas_verdes.csv" )

# Importando datos 3: Con la funcion de la libreria vroom

campanasverdes3 <- vroom("campanas_verdes.csv", delim = ",")


#Investigando el dataset

#Para ver el archivo en la consola
campanasverdes1

#Para ver cantidad de variables y observaciones
dim(campanasverdes1)
#Vemos que la base de datos cuenta con 9 variables y 2887 observaciones


#Para ver cantidad de observaciones
nrow(campanasverdes1)
#De esta manera observamos puntualmente la cantidad de observaciones

#Para ver cantidad de variables 
ncol(campanasverdes1)
#De esta menera observamos puntualmente la cantidad de varibales

#Para ver la estructura de la base de datos
str(campanasverdes1)
#Asi vemos la estructura del data set, visualizamos las variables, si son caracteres, factores o numeros 

#Para ver el encabezado
names(campanasverdes1)
#Vemos los nombres de las variables. En este caso puntual vemos que el dataset detalla el nombre de la calle en la que se ubican las campanas verdes, la altura, el modelo de campana, el barrio, la comuna y el codigo postal

#Para ver el nombre de las columnas y las primeras filas
head(campanasverdes1)

skimr::skim(campanasverdes1)
#Esta funcion nos permite ver si hay valores perdidos (NA). En este caso no nos sirve, pero podriamos conocer los promedios de algunos datos y otros valores estadisticos.



#Investigando una observación de la base de datos 

#Investigando la observacion Modelo
campanasverdes1$modelo
str(campanasverdes1$modelo)
class(campanasverdes1$modelo)  
#Vemos que esta variable tiene solo dos niveles. Puede ser Mecanico o Contenedor 3200

#Para ver la cantidad de observaciones dentro del modelo de campanas
summary(campanasverdes1$modelo)
#Hay 68 contenedores 3200 y 2819 Mecanicos


#Acomodando datos

#Eliminando una columna: Como la columna "codigo_postal_argentino" no nos proporciona información relevante para este análisis, la eliminamos. 
campanasverdes1_1<- select(campanasverdes1, -"codigo_postal_argentino")
#vemos que ahora tenemos una variable menos

#Partiendo una columna en 2: Para separar la comuna en dos datos, en una que figure "comuna" y en otra el número solo. 
campanasverdes_comunas <- campanasverdes1_1 %>% 
  separate(comuna, into=c("distrito", "numero"), sep= " ")
#De esta manera al incorporar otra variable, volvemos a tener el numero original de varibales

#Agregando una varibale: Para agregar una variable que diga la ciudad, en este caso será para todas la misma
campanasverdes_comunas <- campanasverdes_comunas %>% 
  mutate(ciudad="CABA")

#Ordenando datos 1: Para que los datos queden ordenados alfabéticamente según los barrios:
campanasverdes_barrio <- campanasverdes_comunas %>% 
  arrange(barrio)

#Ordenando datos 2: Para que los datos queden ordenados alfabéticamente segun los barrios, pero en este caso de manera inversa:
campanasverdes_barrio2 <- campanasverdes_comunas %>% 
  arrange(desc(barrio))
#Generamos un nuevo dataset para verlo ordenado alfabeticamente por barrio

#Filtro de datos 1: Para filtrar datos en donde no tenemos la certeza de como estan escritos, en este caso se busca filtrar el modelo "Mecanico" pero no sabes si esta escrito con tilde o no
campanasverdes_filtro1 <- campanasverdes1_1 %>%
  filter(str_detect(string = modelo, pattern = "MEC"))

#Filtro de datos 2: Para quedarnos con aquellas comunas que esten conformadas por un único barrio. Es decir, Recoleta (Comuna 2), Caballito (Comuna 6) y Palermo (Comuna 14)
campanasverdes_barrio <- campanasverdes_comunas %>%
  filter(barrio == "Caballito" | barrio == "Recoleta" | barrio == "Palermo")

#Agrupar datos y obtener valores: Agruparemos según el barrio para saber la cantidad de campanas verdes que tiene cada uno.
campanasverdesxbarrio <- campanasverdes_barrio %>%
  group_by(barrio) %>% 
  summarise(cantidad=n())

campanasverdesxbarrio
#Vemos que en caballito hay 96 campanas, en Palermo 175 y en Recoleta 40

#Pivotear: Para girar la tabla. En este caso queremos evitar que aparezcan los datos ordenados por barrio y cantidad, queremos que directamente figuren el nombre de cada barrio y la cantidad correspondiente de campanas verdes
campanasverdesxbarrio_ok <- campanasverdesxbarrio %>% 
  pivot_wider(names_from = "barrio",
              values_from = "cantidad")






