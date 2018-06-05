
[Forma]
Clave=WebSitioDocListaA
Icono=0
Modulos=(Todos)
Nombre=Documentos de los Sitios

ListaCarpetas=WebSitioDocListaA
CarpetaPrincipal=WebSitioDocListaA
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialAlturaCliente=327
PosicionInicialAncho=675
PosicionInicialIzquierda=302
PosicionInicialArriba=219
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
ListaAcciones=(Lista)
[WebSitioDocListaA]
Estilo=Iconos
Clave=WebSitioDocListaA
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebSitioDocA
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco

CarpetaVisible=S

IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
PermiteLocalizar=S
IconosSubTitulo=<T>Clave<T>

ListaEnCaptura=(Lista)
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaAncho=40
BusquedaEnLinea=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=WebSitioDoc.Sitio
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroTipo=Múltiple (por Grupos)
IconosNombre=WebSitioDocA:WebSitioDoc.Documento
[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=WebSitioDoc
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S


PestanaOtroNombre=S
PestanaNombre=Sitios

IconosNombre=WebSitioDoc:WebSitioDoc.Sitio
[WebSitioDocListaA.Columnas]
0=122
1=227

Nombre=604
Archivo=604
2=167
3=-2
4=-2
[(Carpeta Abrir).Columnas]
0=123
1=243
2=379

3=-2



[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=WebSitio.Nombre
WebSitio.Nombre=WebSitio.URL_Documentos
WebSitio.URL_Documentos=(Fin)






[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=&Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
















[Acciones.SeleccionarAdjunto.Seleccionar]
Nombre=Seleccionar
Boton=0
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.SeleccionarAdjunto]
Nombre=SeleccionarAdjunto
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
Multiple=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
ListaAccionesMultiples=Seleccionar
Activo=S
Visible=S






[Acciones.SeleccionarArchivo.Seleccionar]
Nombre=Seleccionar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.SeleccionarArchivo.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=asigna(Anexo.Nombre,WebSitioDocA:WebSitio.URL_Documentos + WebSitioDocA:WebSitioDoc.Archivo)


[WebSitioDocListaA.WebSitioDoc.Descripcion]
Carpeta=WebSitioDocListaA
Clave=WebSitioDoc.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[WebSitioDocListaA.WebSitioDoc.Archivo]
Carpeta=WebSitioDocListaA
Clave=WebSitioDoc.Archivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco





[Acciones.SeleccionarArchivo.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Seleccionar
Seleccionar=(Fin)






[Acciones.Seleccionar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Seleccionar
Seleccionar=(Fin)




[Acciones.SeleccionarA]
Nombre=SeleccionarA
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
Activo=S
Visible=S





Multiple=S




ListaAccionesMultiples=Aceptar


[Acciones.SeleccionarA.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S





[Acciones.SeleccionarA.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)






























[WebSitioDocListaA.ListaEnCaptura]
(Inicio)=WebSitioDoc.Descripcion
WebSitioDoc.Descripcion=WebSitioDoc.Archivo
WebSitioDoc.Archivo=(Fin)

















[Forma.ListaAcciones]
(Inicio)=SeleccionarA
SeleccionarA=Personalizar
Personalizar=(Fin)
