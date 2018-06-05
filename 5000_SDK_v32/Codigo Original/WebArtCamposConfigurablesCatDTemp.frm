
[Forma]
Clave=WebArtCamposConfigurablesCatDTemp
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=WebArtCamposConfigurablesCatDTemp
CarpetaPrincipal=WebArtCamposConfigurablesCatDTemp
PosicionInicialIzquierda=516
PosicionInicialArriba=294
PosicionInicialAlturaCliente=273
PosicionInicialAncho=567
ListaAcciones=(Lista)
Nombre=Campos Configurables Artículo eCommerce
[WebArtCamposConfigurablesCatDTemp]
Estilo=Iconos
Clave=WebArtCamposConfigurablesCatDTemp
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtCamposConfigurablesCatDTemp
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
IconosSubTitulo=<T>Nombre<T>
ListaEnCaptura=WebArtCamposConfigurablesCatDTemp.TipoCampo


IconosSeleccionMultiple=S
PestanaOtroNombre=S
PestanaNombre=Campos Configurables
MenuLocal=S
ListaAcciones=Seleccionar Todo<BR>Quitar Seleccion
IconosNombre=WebArtCamposConfigurablesCatDTemp:WebArtCamposConfigurablesCatDTemp.Nombre
FiltroGeneral=WebArtCamposConfigurablesCatDTemp.Estacion = {EstacionTrabajo}
[WebArtCamposConfigurablesCatDTemp.WebArtCamposConfigurablesCatDTemp.TipoCampo]
Carpeta=WebArtCamposConfigurablesCatDTemp
Clave=WebArtCamposConfigurablesCatDTemp.TipoCampo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[WebArtCamposConfigurablesCatDTemp.Columnas]
0=216
1=-2
2=-2


[Acciones.Agregar]
Nombre=Agregar
Boton=62
NombreEnBoton=S
NombreDesplegar=&Agregar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

EspacioPrevio=S
Multiple=S
ListaAccionesMultiples=Expresion<BR>Aceptar
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=Expresion<BR>Aceptar
[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.Seleccionar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>  CuantosSeleccionID(<T>WebArtCamposConfigurablesCatDTemp<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>Pendientes<T>)<BR>  EjecutarSQL(<T>spWebArtImportarCamposConfigurables :nEstacion, :nIDArt<T>,EstacionTrabajo,Info.ID)<BR>Fin
[Acciones.Seleccionar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Agregar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>  CuantosSeleccionID(<T>WebArtCamposConfigurablesCatDTemp<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>Pendientes<T>)<BR>  EjecutarSQL(<T>spWebArtAgregarCamposConfigurables :nEstacion, :nIDArt<T>,EstacionTrabajo,Info.ID)<BR>Fin
[Acciones.Agregar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Agregar
Agregar=(Fin)
