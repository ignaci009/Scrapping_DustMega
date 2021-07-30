#Se cargan las librerias a utilizar

library("robotstxt")
library("tidyverse")
library("rvest")
library("readxl")
library("dplyr")
library("curl")

# A continuación en los siguientes sitios web se presentan la información
# de las tarjetas de video que se ocupan usualmente en los
# armados de computadoras de ecritorio, las cuales en el último tiempo se 
# encuentran con muy poco stock, debido a la pándemia como también 
# al explosivo aumento de mineros de criptomonedas.
# Mencionado lo anteriro las páginas con las que se trabajarán
# serán las siguientes:

dust<-read_html("https://dust2.gg/categoria-producto/computacion-y-electronica/componentes-de-pc/tarjetas-de-video/")
megadrivestore<-read_html("https://megadrivestore.cl/es/11-tarjetas-graficas")


##### Empezamos con la primera página web#####
########### DUST #########


# Asignamos la clase del prodcuto, en donde se encuentran ubicados los productos
# en la página web.

dust_p<-".woocommerce-loop-product__title"

#Luego de ubicar de manera exitosa los productos, se procede a obtener los nombres
#de cada uno de los prodcutos.


producto_html<-html_nodes(dust,dust_p)
producto_dust<-html_text(producto_html)



# Debido a que los nombres tienen basura se procede a limpiar
# los nombres extraidos para lograr tener una mejor vista de lo extraido

dust_limpio<-gsub("\n","",producto_dust)
dust_limpio<-gsub("\t","",dust_limpio)


# A continuación, despuén de haber obtenido los nombres de los productos 
# de manera exitosa y limpia, se procede a la extracción de los precios
# de cada producto que aparece en al página.


precios<-".priceT-DPB"

precios_html<-html_nodes(dust,precios)
precio_dust<-html_text(precios_html)

# Debido a que los precios que se extrajerón de los sitios no poseen basura
# estos no son necesarios de limpiar, pero si se hace necesario pasarlos 
# a numericos

precio_numdust<-as.numeric(precio_dust)

# Ahora se procederá a generar la data frame de los prodcutos
# y sus respectivos precios

#Confeccion tabla (data frame)

productosdust<-data.frame(Producto = producto_dust,
                      Precio = precio_dust)
print(productosdust)



###############################################################################

####### Ahora se trabajará con la página 2 ######
#########      MEGADRIVESTORE      #########
#

# Al igual que en la primera página se asignan las clases de los productos
# que se encuentran en la página web.

mega<-".h3.product-title"


# A continuación se procede a hacer lo mismo que en la página 1
# en donde nos ubicamos en la página para lograr acceder al código 
# que contenga los nombres de los productos  

producto_html2<-html_nodes(megadrivestore,mega)
producto_mega<-html_text(producto_html2)



# Luego que obtenemos de manera exitosa los diferentes nombres de los productos
# que posee la página en especifico, nos disponemos a obtener los precios
# de cada uno de los productos que se ofrecen. 

precios2<-".price"

precios_html2<-html_nodes(megadrivestore,precios2)
precio_mega<-html_text(precios_html2)


# Al igual que el caso anterior (página 1), debemos pasar los precios
# a caracter numerico.

preciosnum2<-as.numeric(precio_mega)


# Luego de que se pasan a caracter numerico exitosamente
# procesdemos a generar la data frame con los productos
# y sus respectivos precios.

# Confeccion tabla (data frame)

productosmega<-data.frame(Producto = producto_mega,
                      Precio = precio_mega)

print(productosmega)



########## RESPALDO DE ARCHIVO A FORMATO CSV ############

# Después de haber limpiado las datas y comprobar que todo anda de buena manera
# se procede a respaldar ambos archivos en formato CSV.


# DATA DE DUST

write.csv(productosdust, file = "DATA_PRODUCTOS_DUST.csv")

# DATA DE MEGADRIVESTORE 
 write.csv(productosmega, file = "DATA_PRODUCTOS_MEGA.csv")



