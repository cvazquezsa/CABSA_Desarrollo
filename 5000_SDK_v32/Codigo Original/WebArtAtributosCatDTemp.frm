[Forma]
Clave=WebArtAtributosCatDTemp
Icono=0
CarpetaPrincipal=WebArtAtributosCatDTemp
Modulos=(Todos)
Nombre=Tipo Atributos Artículos eCommerce

ListaCarpetas=WebArtAtributosCatDTemp
PosicionInicialAlturaCliente=395
PosicionInicialAncho=676
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=462
PosicionInicialArriba=233


ExpresionesAlMostrar=EjecutarSQL(<T>spWebArtImportarAtributosTemp :nEstacion<T>,EstacionTrabajo)



[WebArtCamposConfigurablesCatDTemp.Columnas]
0=216
1=-2

[WebArtAtributosCatDTemp]
Estilo=Iconos
Clave=WebArtAtributosCatDTemp
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtAtributosCatDTemp
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=WebArtAtributosCatDtemp.Valor
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Nombre<T>
ElementosPorPagina=200


IconosSeleccionMultiple=S
PestanaOtroNombre=S
PestanaNombre=Atributos
IconosNombre=WebArtAtributosCatDTemp:WebArtAtributosCatDtemp.Nombre
FiltroGeneral=WebArtAtributosCatDtemp.Estacion={EstacionTrabajo}
[WebArtAtributosCatDTemp.WebArtAtributosCatDtemp.Valor]
Carpeta=WebArtAtributosCatDTemp
Clave=WebArtAtributosCatDtemp.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[WebArtAtributosCatDTemp.Columnas]
0=222
1=416

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Si<BR>  CuantosSeleccionID(<T>Pendientes<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>Pendientes<T>)<BR>  EjecutarSQL(<BR>Fin
Activo=S
Visible=S

[Acciones.Seleccionar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Expresion<BR>Aceptar
Activo=S
Visible=S

[Acciones.Agregar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>  CuantosSeleccionID(<T>WebArtAtributosCatDTemp <T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>WebArtAtributosCatDTemp <T>)<BR>  EjecutarSQL( <T>spWebArtAgregarAtributos :nEstacion,:nIdArt<T>,EstacionTrabajo,Info.ID)<BR>Fin
[Acciones.Agregar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Agregar]
Nombre=Agregar
Boton=62
NombreEnBoton=S
NombreDesplegar=&Agregar
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
ListaAccionesMultiples=Expresion<BR>Aceptar
Activo=S
Visible=S

[Acciones.Seleccionar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Si<BR>  CuantosSeleccionID(<T>WebArtAtributosCatDTemp <T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>WebArtAtributosCatDTemp <T>)<BR>  EjecutarSQL( <T>spWebArtImportarAtributos :nEstacion,:nIdArt<T>,EstacionTrabajo,Info.ID)<BR>Fin

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Agregar
Agregar=(Fin)
