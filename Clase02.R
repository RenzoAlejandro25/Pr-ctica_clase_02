rm(list=ls())
getwd()
setwd("c:/Users/Usuario/Desktop/Clases_de_R/Pr�cticas/Clase_2/")
dir()

#### Data lista para trabajar ####

#Las bases de datos de datasets ya esta lista para el an�lisis, no se tiene que limpiar.

library(datasets) #Cargar el paquete que quiero utilizar
library(help="datasets") #Muestra informaci�n del paquete que quiero utilizar
data("cars") #Para cargar la data cars de la libreria datasets
head(cars)

library(car)
library(help="car")
data("Prestige")
head(Prestige)
str(Prestige)
summary(Prestige)

#### Matriz de correlaci�n ####
str(Prestige) #La variable type, orden seis, es de tipo cualitativa ordinal. 
cor(Prestige[,-6]) #Le quiero quitar la sexta columna (type) a Prestige para hacer la 
# la matriz de correlaci�n. 
library(corrplot) #Cargar el paquete corrplot
library(help="corrplot") #Sirve para tener un gr�fico de visualizaci�n  de la correlaci�n
corrplot(cor(Prestige[,-6]),method = "number") #Permite visualizar con mayor facilidad
# la matriz de correlaci�n. 

#### Importar data de p�gina web ####

data1 <- read.table(file="http://courses.washington.edu/b517/Datasets/string.txt", header=T)
# El "file=" se puede omitir

data2 <- read.csv("https://catalogue.data.gov.bc.ca/dataset/1b32412c-a58c-420c-a9fe-5bee1641252d/resource/184e968e-a208-4639-bd43-9be19e4b051b/download/data_literacy_program_needs_assessment_survey_2019.csv", 
                  header = T)

#### Importar data de Excel ####

# Excel tiene data de formato xls, en sus veriones del 93 al 03, y xlsx en sus versiones m�s
# actuales. readxl es un paquete que nos permite leer estos dos fomatos pero no .ods

install.packages("readxl") #Instalamos el paquete
library(readxl)#Llamamos al paquete

excel_sheets("excel_prueba.xlsx") #Sirve para visualizar las pesta�as de un mismo archivo excel.
# En este caso hay tres pesta�as en excel_prueba.xlsx

excel_iris <- read_excel("excel_prueba.xlsx", sheet = "iris") #Importamos la pesta�a iris
excel_women <- read_excel("excel_prueba.xlsx", sheet="women", col_names = F)
# El colnames es por defecto TRUE
excel_air <- read_excel("excel_prueba.xlsx", sheet = "airquality", skip = 3)

#### Problemas con airquality ####
View(excel_air) #Todos los aspectos problematicos estan en la p�gina 15 del slide la clase 2
excel_airquality <- read_excel("excel_prueba.xlsx", sheet="airquality",skip = 3,na="-",
                               col_types = c("skip","numeric","numeric","numeric","numeric",
                                             "skip","date","numeric","numeric","numeric",
                                             "skip"))
# skip es para saltearse 3 filas, na="-" es para cambiar los - por na, con coltypes definimos 
# el tipo de variable, con skip dentro de coltype nos salteamos la columna que no tiene valores

colnames(excel_airquality)<-c("ozono","rad_solar","viento","temp","fecha",
                              "mes","d�a","a�o")
# Le damos nombres a las variables.

#### Paquete dplyr ####

# El paquete dplyr proporciona una gram�tica para la manipulaci�n y operaci�n con los dataframe
install.packages("dplyr")
library(dplyr) #Cargamos el paquete a nuestra sesi�n en R
?select #el resto est� en la p�gina 23

#### Visualizaci�n de datos ####

# El 90% de informaci�n transmitida al cerebro es visual. 
# ggplot2 es un paquete de visualizaci�n de datos para el lenguaje de programaci�n R. 
# ggplot2 puede servir como un reemplazo para los gr�ficos base en R. 
# ggplot2 solo admite dataframes
library(ggplot2)

# PASO 1: DATOS
p <- ggplot(iris) #Se ha creado el objeto p que contiene los datos de iris que vamos a utilizar
# para realizar los gr�ficos. Se le llama protogr�fico. 

# PASO 2: EST�TICAS
p <- p + aes(x=Petal.Length, y=Petal.Width, colour=Species)
# Se esta dando informaci�n a p sobre la est�tica que tiene que utilizar y que variables de
# iris tiene que utilizar:
  # x -> la distancia horizontal
  # y -> la distancia vertical
  # el color esta dado por la especie
# La suma es el modo de a�adir informaci�n al protogr�fico.

# PASO 3: CAPAS
p <- p + geom_point() #Las capas son los verbos en esta gram�tica, le indicamos al gr�fico
# que hacer con los datos.
ggsave("gr�fico.png") #guardamos el gr�fico 

# Las capas pueden superponerse unas a otras 
ggplot(iris, aes(x=Petal.Length, y=Petal.Width,colour=Species))+geom_point()+geom_smooth()
# Esto a�ade al gr�fico un curva suavizada (con sus intervalos de confianza en gris).

# ESTO YA NO ES UN PASO, PERO ES UN ELEMENTO DE GGPLOT: FACETAS
# Las facetas crean gr�ficos comparativos que comparten ejes.

ggplot(iris, aes(x=Petal.Length, y=Petal.Width))+geom_point()+
  geom_smooth() + facet_grid(~Species)

ggplot(iris, aes(x=Petal.Length, y=Petal.Width,colour=Species)) + 
  geom_point() + geom_smooth() + ggtitle("Ancho y largo del P�talo") +
  labs(x="Largo del P�talo", y="Ancho del P�talo", colour="Especies")
# Le hemos agregado etiquetas a los ejes del gr�fico, tambi�n un t�tulo y as� como 
# una leyenda. 

# TEMAS
# Los temas en ggplot permiten modificar aspectos est�ticos del gr�fico que no tienen que 
# ver con los datos en s�. 

# El tema que utiliza ggplot por defecto es theme_grey()
ggplot(iris, aes(x=Petal.Length, y=Petal.Width,colour=Species)) + 
  geom_point() + geom_smooth() + ggtitle("Ancho y largo del P�talo") +
  labs(x="Largo del P�talo", y="Ancho del P�talo", colour="Especies") + 
  theme_bw() #Fomdo blanco con lineas

ggplot(iris, aes(x=Petal.Length, y=Petal.Width,colour=Species)) + 
  geom_point() + geom_smooth() + ggtitle("Ancho y largo del P�talo") +
  labs(x="Largo del P�talo", y="Ancho del P�talo", colour="Especies") + 
  theme_classic() #Fondo blanco sin lineas

ggplot(iris, aes(x=Petal.Length, y=Petal.Width,colour=Species)) + 
  geom_point() + geom_smooth() + ggtitle("Ancho y largo del P�talo") +
  labs(x="Largo del P�talo", y="Ancho del P�talo", colour="Especies") + 
  theme_bw() + theme(panel.background = element_rect(fill="lightblue"),
                     panel.grid.minor = element_line(linetype = "dotted"))
