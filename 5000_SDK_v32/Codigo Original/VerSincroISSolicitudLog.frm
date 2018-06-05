[Forma]
Clave=VerSincroISSolicitudLog
Nombre=Bitácora Solicitud
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=465
PosicionInicialArriba=367
PosicionInicialAlturaCliente=430
PosicionInicialAncho=990
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Clave

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerSincroISLog
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>ID<T>
IconosNombreNumerico=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=VerSincroISLog.FechaRecibo
FiltroFechasDefault=Hoy
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
PestanaOtroNombre=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

IconosNombre=VerSincroISLog:VerSincroISLog.RID
FiltroGeneral=VerSincroISLog.Solicitud=<T>{Info.Clave}<T>
[Lista.VerSincroISLog.Solicitud]
Carpeta=Lista
Clave=VerSincroISLog.Solicitud
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Blanco

[Lista.VerSincroISLog.Conversacion]
Carpeta=Lista
Clave=VerSincroISLog.Conversacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Blanco

[Lista.VerSincroISLog.SucursalOrigen]
Carpeta=Lista
Clave=VerSincroISLog.SucursalOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VerSincroISLog.SucursalDestino]
Carpeta=Lista
Clave=VerSincroISLog.SucursalDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VerSincroISLog.FechaEnvio]
Carpeta=Lista
Clave=VerSincroISLog.FechaEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VerSincroISLog.FechaRecibo]
Carpeta=Lista
Clave=VerSincroISLog.FechaRecibo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
0=-2
1=120

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
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

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

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Pesonalizar]
Nombre=Pesonalizar
Boton=45
NombreDesplegar=Pesonalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=Actualizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.VerSincroISLog.PaqueteBajas]
Carpeta=Lista
Clave=VerSincroISLog.PaqueteBajas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VerSincroISLog.PaqueteCambios]
Carpeta=Lista
Clave=VerSincroISLog.PaqueteCambios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VerSincroISLog.ConversacionTabla]
Carpeta=Lista
Clave=VerSincroISLog.ConversacionTabla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Lista.ListaEnCaptura]
(Inicio)=VerSincroISLog.Solicitud
VerSincroISLog.Solicitud=VerSincroISLog.Conversacion
VerSincroISLog.Conversacion=VerSincroISLog.SucursalOrigen
VerSincroISLog.SucursalOrigen=VerSincroISLog.SucursalDestino
VerSincroISLog.SucursalDestino=VerSincroISLog.FechaEnvio
VerSincroISLog.FechaEnvio=VerSincroISLog.FechaRecibo
VerSincroISLog.FechaRecibo=VerSincroISLog.ConversacionTabla
VerSincroISLog.ConversacionTabla=VerSincroISLog.PaqueteBajas
VerSincroISLog.PaqueteBajas=VerSincroISLog.PaqueteCambios
VerSincroISLog.PaqueteCambios=(Fin)















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Pesonalizar
Pesonalizar=Actualizar
Actualizar=(Fin)
