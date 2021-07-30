# Scrapping_DustMega

En el siguiente repositorio, el cual consiste en la extracción de información de los precios de las tarjetas de video
de dos páginas web. Con el objetivo de si los precios de estos productos varian demasiado entre las dos páginas.

Las páginas de  las cuales se extrajo la información que se necesitan para la investigación son las siguientes:

La primeda de ellas es de [https://dust2.gg/categoria-producto/computacion-y-electronica/componentes-de-pc/tarjetas-de-video/]

La segunda página de donde se extrajo información es de [https://megadrivestore.cl/es/11-tarjetas-graficas]


# Inicio de investigación

Para poder iniciar de manera optima la investigación es necesario instalar o llamar algunas librerías tales como:

library(readxl)

library(dplyr)

library("rvest") 

install.packages("readxl")

install.packages("dplyr")

library(readxl) 

Después de haber instalado y llamado las librerías, el primer paso será relaizar la extracción de datos de las páginas web

# PRIMERA PÁGINA

Con el comando read_html y luego ejecutandolo se procede a abrir la página web 

dust<-read_html("https://dust2.gg/categoria-producto/computacion-y-electronica/componentes-de-pc/tarjetas-de-video/")

Luego se procede a asignar una clase a del prodcuto la cuál contiene los productos

dust_p<-".woocommerce-loop-product__title"

A continuación se prodecerá a obetener los nombres de cada uno de los productos que se encuentren en la página

producto_html<-html_nodes(dust,dust_p)
producto_dust<-html_text(producto_html)

Debido a que los nombres tienen basura se procede a limpiar los nombres extraidos para lograr tener
una mejor vista de lo extraido

dust_limpio<-gsub("\n","",producto_dust)
dust_limpio<-gsub("\t","",dust_limpio)
	
A continuación, despuén de haber obtenido los nombres de los productos de manera exitosa y limpia,
se procede a la extracción de los precios de cada producto que aparece en al página.

precios<-".priceT-DPB"

precios_html<-html_nodes(dust,precios)
precio_dust<-html_text(precios_html)


Debido a que los precios que se extrajerón de los sitios no poseen basura estos no son necesarios de limpiar,
pero si se hace necesario pasarlos a numericos.

precio_numdust<-as.numeric(precio_dust)


Ahora se procederá a generar la data frame de los prodcutos y sus respectivos precios.

Confeccion tabla (data frame)

productosdust<-data.frame(Producto = producto_dust,
                      Precio = precio_dust)
print(productosdust)



# SEGUNDA PÁGINA

Al igual que en la primera página con el comando read_html y luego ejecutandolo se procede a abrir la página web.

megadrivestore<-read_html("https://megadrivestore.cl/es/11-tarjetas-graficas")

Se repite el caso de la primera página se asignan las clases de los productos que se encuentran en la página web.

mega<-".h3.product-title"

A continuación se procede a hacer lo mismo que en la página 1, en donde nos ubicamos en la página para lograr acceder al código 
que contenga los nombres de los productos  

producto_html2<-html_nodes(megadrivestore,mega)
producto_mega<-html_text(producto_html2)

Luego que obtenemos de manera exitosa los diferentes nombres de los productos que posee la página en especifico,
nos disponemos a obtener los precios de cada uno de los productos que se ofrecen. 

precios2<-".price"

precios_html2<-html_nodes(megadrivestore,precios2)
precio_mega<-html_text(precios_html2)

Al igual que el caso anterior (página 1), debemos pasar los precios a caracter numerico.

preciosnum2<-as.numeric(precio_mega)

Luego de que se pasan a caracter numerico exitosamente procesdemos a generar la data frame con los productos
y sus respectivos precios.

Confeccion tabla (data frame)

productosmega<-data.frame(Producto = producto_mega,
                      Precio = precio_mega)

print(productosmega)


