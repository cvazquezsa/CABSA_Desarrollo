[Forma]
Clave=RSSCanal
Nombre=Canales (Fuentes RSS)
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=601
PosicionInicialArriba=415
PosicionInicialAlturaCliente=334
PosicionInicialAncho=718
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionCol1=313

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RSSCanal
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=RSSCanal.Canal
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.RSSCanal.Canal]
Carpeta=Lista
Clave=RSSCanal.Canal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Canal=281
Titulo=193

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

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=RSSCanal
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
CarpetaVisible=S
PestanaNombre=Datos Generales

[Ficha.RSSCanal.Canal]
Carpeta=Ficha
Clave=RSSCanal.Canal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.RSSCanal.Estatus]
Carpeta=Ficha
Clave=RSSCanal.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.RSSCanal.Titulo]
Carpeta=Ficha
Clave=RSSCanal.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.RSSCanal.Hipervinculo]
Carpeta=Ficha
Clave=RSSCanal.Hipervinculo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.RSSCanal.Descripcion]
Carpeta=Ficha
Clave=RSSCanal.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.RSSCanal.ArchivoXML]
Carpeta=Ficha
Clave=RSSCanal.ArchivoXML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.RSSCanal.Categoria]
Carpeta=Ficha
Clave=RSSCanal.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Imagen.RSSCanal.ImagenTitulo]
Carpeta=Imagen
Clave=RSSCanal.ImagenTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[Imagen.RSSCanal.ImagenURL]
Carpeta=Imagen
Clave=RSSCanal.ImagenURL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[Imagen.RSSCanal.ImagenHipervinculo]
Carpeta=Imagen
Clave=RSSCanal.ImagenHipervinculo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[Imagen.RSSCanal.ImagenAlto]
Carpeta=Imagen
Clave=RSSCanal.ImagenAlto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[Imagen.RSSCanal.ImagenAncho]
Carpeta=Imagen
Clave=RSSCanal.ImagenAncho
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
ActivoCondicion=no RSSCanal:RSSCanal.TieneMovimientos

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S

[Ficha.RSSCanal.Tipo]
Carpeta=Ficha
Clave=RSSCanal.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Categorias]
Nombre=Categorias
Boton=91
NombreEnBoton=S
NombreDesplegar=Categorías
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=RSSCanalCat
Activo=S
Visible=S

[Acciones.Tipos]
Nombre=Tipos
Boton=87
NombreEnBoton=S
NombreDesplegar=Tipos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=RSSCanalTipo
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=Categorias
Categorias=Tipos
Tipos=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=RSSCanal.Canal
RSSCanal.Canal=RSSCanal.Estatus
RSSCanal.Estatus=RSSCanal.ArchivoXML
RSSCanal.ArchivoXML=RSSCanal.Titulo
RSSCanal.Titulo=RSSCanal.Hipervinculo
RSSCanal.Hipervinculo=RSSCanal.Descripcion
RSSCanal.Descripcion=RSSCanal.Categoria
RSSCanal.Categoria=RSSCanal.Tipo
RSSCanal.Tipo=(Fin)
