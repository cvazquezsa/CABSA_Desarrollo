[Forma]
Clave=VerSincroSSBSolicitudLog
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
Vista=VerSincroSSBLog
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
FiltroFechasCampo=VerSincroSSBLog.FechaRecibo
FiltroFechasDefault=Hoy
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
PestanaOtroNombre=S
Filtros=S
IconosNombre=VerSincroSSBLog:VerSincroSSBLog.RID
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=VerSincroSSBLog.Solicitud=<T>{Info.Clave}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.VerSincroSSBLog.Solicitud]
Carpeta=Lista
Clave=VerSincroSSBLog.Solicitud
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerSincroSSBLog.Conversacion]
Carpeta=Lista
Clave=VerSincroSSBLog.Conversacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerSincroSSBLog.SucursalOrigen]
Carpeta=Lista
Clave=VerSincroSSBLog.SucursalOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerSincroSSBLog.SucursalDestino]
Carpeta=Lista
Clave=VerSincroSSBLog.SucursalDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerSincroSSBLog.FechaEnvio]
Carpeta=Lista
Clave=VerSincroSSBLog.FechaEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerSincroSSBLog.FechaRecibo]
Carpeta=Lista
Clave=VerSincroSSBLog.FechaRecibo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.VerSincroSSBLog.PaqueteBajas]
Carpeta=Lista
Clave=VerSincroSSBLog.PaqueteBajas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerSincroSSBLog.PaqueteCambios]
Carpeta=Lista
Clave=VerSincroSSBLog.PaqueteCambios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerSincroSSBLog.ConversacionTabla]
Carpeta=Lista
Clave=VerSincroSSBLog.ConversacionTabla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Pesonalizar
Pesonalizar=Actualizar
Actualizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VerSincroSSBLog.Solicitud
VerSincroSSBLog.Solicitud=VerSincroSSBLog.Conversacion
VerSincroSSBLog.Conversacion=VerSincroSSBLog.SucursalOrigen
VerSincroSSBLog.SucursalOrigen=VerSincroSSBLog.SucursalDestino
VerSincroSSBLog.SucursalDestino=VerSincroSSBLog.FechaEnvio
VerSincroSSBLog.FechaEnvio=VerSincroSSBLog.FechaRecibo
VerSincroSSBLog.FechaRecibo=VerSincroSSBLog.ConversacionTabla
VerSincroSSBLog.ConversacionTabla=VerSincroSSBLog.PaqueteBajas
VerSincroSSBLog.PaqueteBajas=VerSincroSSBLog.PaqueteCambios
VerSincroSSBLog.PaqueteCambios=(Fin)
