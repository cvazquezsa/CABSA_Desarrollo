[Forma]
Clave=RSSCanalCat
Nombre=Categorías Canales (Fuentes RSS)
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=607
PosicionInicialArriba=356
PosicionInicialAlturaCliente=451
PosicionInicialAncho=706
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionCol1=364

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RSSCanalCat
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaTitulos=S
HojaMostrarColumnas=S

[Lista.RSSCanalCat.Categoria]
Carpeta=Lista
Clave=RSSCanalCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Categoria=286
Imagen=45

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.RSSCanalCat.Imagen]
Carpeta=Lista
Clave=RSSCanalCat.Imagen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Imagen]
Estilo=Ficha
Clave=Imagen
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=RSSCanalCat
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Imagen
CondicionVisible=RSSCanalCat:RSSCanalCat.Imagen

[Imagen.RSSCanalCat.ImagenTitulo]
Carpeta=Imagen
Clave=RSSCanalCat.ImagenTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Imagen.RSSCanalCat.ImagenURL]
Carpeta=Imagen
Clave=RSSCanalCat.ImagenURL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Imagen.RSSCanalCat.ImagenHipervinculo]
Carpeta=Imagen
Clave=RSSCanalCat.ImagenHipervinculo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Imagen.RSSCanalCat.ImagenAlto]
Carpeta=Imagen
Clave=RSSCanalCat.ImagenAlto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Imagen.RSSCanalCat.ImagenAncho]
Carpeta=Imagen
Clave=RSSCanalCat.ImagenAncho
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Imagen
Imagen=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=RSSCanalCat.Categoria
RSSCanalCat.Categoria=RSSCanalCat.Imagen
RSSCanalCat.Imagen=(Fin)

[Imagen.ListaEnCaptura]
(Inicio)=RSSCanalCat.ImagenTitulo
RSSCanalCat.ImagenTitulo=RSSCanalCat.ImagenURL
RSSCanalCat.ImagenURL=RSSCanalCat.ImagenHipervinculo
RSSCanalCat.ImagenHipervinculo=RSSCanalCat.ImagenAlto
RSSCanalCat.ImagenAlto=RSSCanalCat.ImagenAncho
RSSCanalCat.ImagenAncho=(Fin)
