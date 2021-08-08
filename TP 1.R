# Importando datos


campanasverdes1 <- read.csv("campanas_verdes.csv")

library(readr)

campanasverdes2 <- read_csv("campanas_verdes.csv")

library(vroom)
campanasverdes3 <- vroom("campanas_verdes.csv", delim = ",")

#Investigando el dataset

#Para ver el archivo
campanasverdes1

#Para ver la estructura de la base de datos

str(campanasverdes1)


#Para ver el encabezado

names(campanasverdes1)

#Para ver el nombre de las columnas y las primeras filas

head(campanasverdes1)

