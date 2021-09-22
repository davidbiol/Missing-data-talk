## Instalar paquetes de visualización de datos faltantes
install.packages("visdat")
install.packages("VIM")

## Instalar paquete en desarrollo de estimación de datos faltantes
# install.packages("remotes")
remotes::install_github("davidbiol/empire")

# library(visdat)
# library(VIM)
# Library(empire)

#-------------------------------------------------------------------------------

data(sleep, package = "VIM") #Cargar el dataset sleep

# Análisis descriptivo
summary(sleep) #Resumen del data set

#Correlación
visdat::vis_cor(sleep, na_action = "complete.obs")

#Gráficas
visdat::vis_dat(sleep, sort_type = FALSE)
visdat::vis_miss(sleep)
VIM::aggr(sleep)
VIM::matrixplot(sleep, sortby = 2)

empire::count_miss(data = sleep) #Número de datos faltantes
empire::pos_miss(data = sleep) #Posición fila-columna de los datos faltantes

#-------------------------------------------------------------------------------

## Técnicas de estimación de datos faltantes

# Eliminación de casos
new_sleep <- sleep[complete.cases(sleep),]
print(new_sleep)

summary(new_sleep)
VIM::aggr(new_sleep)

# Imputación con la media
new_sleep <- empire::impute_mean(data = sleep)

new_sleep$positions
new_sleep$imp_values
new_sleep$new_data

#Imputación con la mediana
new_sleep <- empire::impute_median(data = sleep)

new_sleep$imp_values
new_sleep$new_data

# Estimación por regresión lineal múltiple
new_airquality <- empire::estimate_mlr(data = airquality[,1:4], diff = 10e-8)
new_airquality$positions
new_airquality$est_values
new_airquality$new_data

# Ahora con el dataset sleep
new_sleep <- empire::estimate_mlr(data = sleep[,1:7])

# Estimación por regresión lineal múltiple penalizada
new_sleep <- empire::estimate_ridge(data = sleep[,1:7], diff = 10, ridge_alpha = 0)

new_sleep$est_values
new_sleep$new_dat

#-------------------------------------------------------------------------------
#' Cómo contactarme?
#'
#' @name David
#' @last-name Gutiérrez-Duque
#' @email davidgd2015@gmail.com
#' @github davidbiol
