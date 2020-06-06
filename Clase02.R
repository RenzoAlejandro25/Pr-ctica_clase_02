rm(list=ls())
getwd()
setwd("c:/Users/Usuario/Desktop/Clases_de_R/Prácticas/Clase_2/")
dir()

#### Data lista para trabajar ####

#Las bases de datos de datasets ya esta lista para el análisis, no se tiene que limpiar.

library(datasets) #Cargar el paquete que quiero utilizar
library(help="datasets") #Muestra información del paquete que quiero utilizar
data("cars") #Para cargar la data cars de la libreria datasets
head(cars)

library(car)
library(help="car")
data("Prestige")
head(Prestige)
str(Prestige)
summary(Prestige)

#### Matriz de correlación ####
str(Prestige) #La variable type, orden seis, es de tipo cualitativa ordinal. 
cor(Prestige[,-6]) #Le quiero quitar la sexta columna (type) a Prestige para hacer la 
# la matriz de correlación. 
library(corrplot) #Cargar el paquete corrplot
library(help="corrplot") #Sirve para tener un gráfico de visualización  de la correlación
corrplot(cor(Prestige[,-6]),method = "number") #Permite visualizar con mayor facilidad
# la matriz de correlación. 

#### Importar data de página web ####

data1 <- read.table(file="http://courses.washington.edu/b517/Datasets/string.txt", header=T)
# El "file=" se puede omitir

data2 <- read.csv("https://catalogue.data.gov.bc.ca/dataset/1b32412c-a58c-420c-a9fe-5bee1641252d/resource/184e968e-a208-4639-bd43-9be19e4b051b/download/data_literacy_program_needs_assessment_survey_2019.csv", 
                  header = T)

#### Importar data de Excel ####

# Excel tiene data de formato xls, en sus veriones del 93 al 03, y xlsx en sus versiones más
# actuales. readxl es un paquete que nos permite leer estos dos fomatos pero no .ods

install.packages("readxl") #Instalamos el paquete
library(readxl)#Llamamos al paquete

excel_sheets("excel_prueba.xlsx") #Sirve para visualizar las pestañas de un mismo archivo excel.
# En este caso hay tres pestañas en excel_prueba.xlsx

excel_iris <- read_excel("excel_prueba.xlsx", sheet = "iris") #Importamos la pestaña iris
excel_women <- read_excel("excel_prueba.xlsx", sheet="women", col_names = F)
# El colnames es por defecto TRUE
excel_air <- read_excel("excel_prueba.xlsx", sheet = "airquality", skip = 3)

#### Problemas con airquality ####
View(excel_air) #Todos los aspectos problematicos estan en la página 15 del slide la clase 2
excel_airquality <- read_excel("excel_prueba.xlsx", sheet="airquality",skip = 3,na="-",
                               col_types = c("skip","numeric","numeric","numeric","numeric",
                                             "skip","date","numeric","numeric","numeric",
                                             "skip"))
# skip es para saltearse 3 filas, na="-" es para cambiar los - por na, con coltypes definimos 
# el tipo de variable, con skip dentro de coltype nos salteamos la columna que no tiene valores

colnames(excel_airquality)<-c("ozono","rad_solar","viento","temp","fecha",
                              "mes","día","año")
# Le damos nombres a las variables.

#### Paquete dplyr ####

# El paquete dplyr proporciona una gramática para la manipulación y operación con los dataframe
install.packages("dplyr")
library(dplyr) #Cargamos el paquete a nuestra sesión en R
?select #el resto está en la página 23

#### Visualización de datos ####

# El 90% de información transmitida al cerebro es visual. 
# ggplot2 es un paquete de visualización de datos para el lenguaje de programación R. 
# ggplot2 puede servir como un reemplazo para los gráficos base en R. 
# ggplot2 solo admite dataframes
library(ggplot2)

# PASO 1: DATOS
p <- ggplot(iris) #Se ha creado el objeto p que contiene los datos de iris que vamos a utilizar
# para realizar los gráficos. Se le llama protográfico. 

# PASO 2: ESTÉTICAS
p <- p + aes(x=Petal.Length, y=Petal.Width, colour=Species)
# Se esta dando información a p sobre la estética que tiene que utilizar y que variables de
# iris tiene que utilizar:
  # x -> la distancia horizontal
  # y -> la distancia vertical
  # el color esta dado por la especie
# La suma es el modo de añadir información al protográfico.

# PASO 3: CAPAS
p <- p + geom_point() #Las capas son los verbos en esta gramática, le indicamos al gráfico
# que hacer con los datos.
ggsave("gráfico.png") #guardamos el gráfico 

# Las capas pueden superponerse unas a otras 
ggplot(iris, aes(x=Petal.Length, y=Petal.Width,colour=Species))+geom_point()+geom_smooth()
# Esto añade al gráfico un curva suavizada (con sus intervalos de confianza en gris).

# ESTO YA NO ES UN PASO, PERO ES UN ELEMENTO DE GGPLOT: FACETAS
# Las facetas crean gráficos comparativos que comparten ejes.

ggplot(iris, aes(x=Petal.Length, y=Petal.Width))+geom_point()+
  geom_smooth() + facet_grid(~Species)

ggplot(iris, aes(x=Petal.Length, y=Petal.Width,colour=Species)) + 
  geom_point() + geom_smooth() + ggtitle("Ancho y largo del Pétalo") +
  labs(x="Largo del Pétalo", y="Ancho del Pétalo", colour="Especies")
# Le hemos agregado etiquetas a los ejes del gráfico, también un título y así como 
# una leyenda. 

# TEMAS
# Los temas en ggplot permiten modificar aspectos estéticos del gráfico que no tienen que 
# ver con los datos en sí. 

# El tema que utiliza ggplot por defecto es theme_grey()
ggplot(iris, aes(x=Petal.Length, y=Petal.Width,colour=Species)) + 
  geom_point() + geom_smooth() + ggtitle("Ancho y largo del Pétalo") +
  labs(x="Largo del Pétalo", y="Ancho del Pétalo", colour="Especies") + 
  theme_bw() #Fomdo blanco con lineas

ggplot(iris, aes(x=Petal.Length, y=Petal.Width,colour=Species)) + 
  geom_point() + geom_smooth() + ggtitle("Ancho y largo del Pétalo") +
  labs(x="Largo del Pétalo", y="Ancho del Pétalo", colour="Especies") + 
  theme_classic() #Fondo blanco sin lineas

ggplot(iris, aes(x=Petal.Length, y=Petal.Width,colour=Species)) + 
  geom_point() + geom_smooth() + ggtitle("Ancho y largo del Pétalo") +
  labs(x="Largo del Pétalo", y="Ancho del Pétalo", colour="Especies") + 
  theme_bw() + theme(panel.background = element_rect(fill="lightblue"),
                     panel.grid.minor = element_line(linetype = "dotted"))
