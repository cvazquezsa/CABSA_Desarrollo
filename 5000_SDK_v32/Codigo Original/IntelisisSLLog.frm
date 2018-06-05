
[Forma]
Clave=IntelisisSLLog
Icono=0
Modulos=(Todos)
Nombre=Bitácora Acceso Licencia

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=662
PosicionInicialArriba=330
PosicionInicialAlturaCliente=496
PosicionInicialAncho=766
Comentarios=Lista(Info.Cliente, Info.Clave, Info.Nombre)
[Lista]
Estilo=Iconos
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=IntelisisSLLog
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Fecha<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=IntelisisSLLog.Fecha
FiltroFechasDefault=Esta Semana
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=registros
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
IconosNombre=IntelisisSLLog:IntelisisSLLog.Fecha
ListaOrden=IntelisisSLLog.Fecha<TAB>(Decendente)
FiltroGeneral=IntelisisSLLog.Licencia=<T>{Info.Clave}<T>
[Lista.IntelisisSLLog.Usuario]
Carpeta=Lista
Clave=IntelisisSLLog.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IntelisisSLLog.Equipo]
Carpeta=Lista
Clave=IntelisisSLLog.Equipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IntelisisSLLog.Dominio]
Carpeta=Lista
Clave=IntelisisSLLog.Dominio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro


[Lista.IntelisisSLLog.Ok]
Carpeta=Lista
Clave=IntelisisSLLog.Ok
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IntelisisSLLog.OkRef]
Carpeta=Lista
Clave=IntelisisSLLog.OkRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MensajeLista.Descripcion]
Carpeta=Lista
Clave=MensajeLista.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro


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

[Lista.Columnas]
0=146
1=66
2=51
3=98
4=67
5=-2
6=251
7=-2
8=-2








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








[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S


[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentacion preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S








[Lista.ListaEnCaptura]
(Inicio)=IntelisisSLLog.Usuario
IntelisisSLLog.Usuario=IntelisisSLLog.Equipo
IntelisisSLLog.Equipo=IntelisisSLLog.Dominio
IntelisisSLLog.Dominio=IntelisisSLLog.Ok
IntelisisSLLog.Ok=IntelisisSLLog.OkRef
IntelisisSLLog.OkRef=MensajeLista.Descripcion
MensajeLista.Descripcion=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Excel
Excel=Preliminar
Preliminar=Personalizar
Personalizar=(Fin)
