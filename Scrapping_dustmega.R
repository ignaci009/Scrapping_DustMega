#Se cargan las librerias a utilizar

library("robotstxt")
library("tidyverse")
library("rvest")
library("readxl")
library("dplyr")
library("curl")

# A continuaci�n en los siguientes sitios web se presentan la informaci�n
# de las tarjetas de video que se ocupan usualmente en los
# armados de computadoras de ecritorio, las cuales en el �ltimo tiempo se 
# encuentran con muy poco stock, debido a la p�ndemia como tambi�n 
# al explosivo aumento de mineros de criptomonedas.
# Mencionado lo anteriro las p�ginas con las que se trabajar�n
# ser�n las siguientes:

dust<-read_html("https://dust2.gg/categoria-producto/computacion-y-electronica/componentes-de-pc/tarjetas-de-video/")
megadrivestore<-read_html("https://megadrivestore.cl/es/11-tarjetas-graficas")


##### Empezamos con la primera p�gina web#####
########### DUST #########


# Asignamos la clase del prodcuto, en donde se encuentran ubicados los productos
# en la p�gina web.

dust_p<-".woocommerce-loop-product__title"

#Luego de ubicar de manera exitosa los productos, se procede a obtener los nombres
#de cada uno de los prodcutos.


producto_html<-html_nodes(dust,dust_p)
producto_dust<-html_text(producto_html)



# Debido a que los nombres tienen basura se procede a limpiar
# los nombres extraidos para lograr tener una mejor vista de lo extraido

dust_limpio<-gsub("\n","",producto_dust)
dust_limpio<-gsub("\t","",dust_limpio)


# A continuaci�n, despu�n de haber obtenido los nombres de los productos 
# de manera exitosa y limpia, se procede a la extracci�n de los precios
# de cada producto que aparece en al p�gina.


precios<-".priceT-DPB"

precios_html<-html_nodes(dust,precios)
precio_dust<-html_text(precios_html)

# Debido a que los precios que se extrajer�n de los sitios no poseen basura
# estos no son necesarios de limpiar, pero si se hace necesario pasarlos 
# a numericos

precio_numdust<-as.numeric(precio_dust)

# Ahora se proceder� a generar la data frame de los prodcutos
# y sus respectivos precios

#Confeccion tabla (data frame)

productosdust<-data.frame(Producto = producto_dust,
                      Precio = precio_dust)
print(productosdust)



###############################################################################

####### Ahora se trabajar� con la p�gina 2 ######
#########      MEGADRIVESTORE      #########
#

# Al igual que en la primera p�gina se asignan las clases de los productos
# que se encuentran en la p�gina web.

mega<-".h3.product-title"


# A continuaci�n se procede a hacer lo mismo que en la p�gina 1
# en donde nos ubicamos en la p�gina para lograr acceder al c�digo 
# que contenga los nombres de los productos  

producto_html2<-html_nodes(megadrivestore,mega)
producto_mega<-html_text(producto_html2)



# Luego que obtenemos de manera exitosa los diferentes nombres de los productos
# que posee la p�gina en especifico, nos disponemos a obtener los precios
# de cada uno de los productos que se ofrecen. 

precios2<-".price"

precios_html2<-html_nodes(megadrivestore,precios2)
precio_mega<-html_text(precios_html2)


# Al igual que el caso anterior (p�gina 1), debemos pasar los precios
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

# Despu�s de haber limpiado las datas y comprobar que todo anda de buena manera
# se procede a respaldar ambos archivos en formato CSV.


# DATA DE DUST

write.csv(productosdust, file = "DATA_PRODUCTOS_DUST.csv")

# DATA DE MEGADRIVESTORE 
 write.csv(productosmega, file = "DATA_PRODUCTOS_MEGA.csv")



