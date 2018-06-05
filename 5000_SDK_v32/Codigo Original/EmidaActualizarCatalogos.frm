
[Forma]
Clave=EmidaActualizarCatalogos
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Emida - Nuevos Registros
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=260
PosicionInicialArriba=121
PosicionInicialAlturaCliente=447
PosicionInicialAncho=759
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmidaActualizarCatalogos
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>URL<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ListaOrden=(Lista)
CarpetaVisible=S
Filtros=S


FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=EmidaActualizarCatalogos:EmidaActualizarCatalogos.URL
FiltroGeneral=EmidaActualizarCatalogos.Estacion = {EstacionTrabajo}
[Lista.EmidaActualizarCatalogos.Catalogo]
Carpeta=Lista
Clave=EmidaActualizarCatalogos.Catalogo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.EmidaActualizarCatalogos.Clave]
Carpeta=Lista
Clave=EmidaActualizarCatalogos.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.EmidaActualizarCatalogos.Descripcion]
Carpeta=Lista
Clave=EmidaActualizarCatalogos.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.Columnas]
0=306
1=99
2=66
3=248



[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S


[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=&Presentación Preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S




[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=&Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S









[Lista.ListaEnCaptura]
(Inicio)=EmidaActualizarCatalogos.Catalogo
EmidaActualizarCatalogos.Catalogo=EmidaActualizarCatalogos.Clave
EmidaActualizarCatalogos.Clave=EmidaActualizarCatalogos.Descripcion
EmidaActualizarCatalogos.Descripcion=(Fin)

[Lista.ListaOrden]
(Inicio)=EmidaActualizarCatalogos.URL	(Acendente)
EmidaActualizarCatalogos.URL	(Acendente)=EmidaActualizarCatalogos.Catalogo	(Decendente)
EmidaActualizarCatalogos.Catalogo	(Decendente)=EmidaActualizarCatalogos.Clave	(Acendente)
EmidaActualizarCatalogos.Clave	(Acendente)=(Fin)

















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=(Fin)
