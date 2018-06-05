[Forma]
Clave=VerSincroISLog
Nombre=Bitácora de Sincronización
Icono=0
Modulos=(Todos)

CarpetaPrincipal=Lista
PosicionInicialIzquierda=145
PosicionInicialArriba=135
PosicionInicialAlturaCliente=430
PosicionInicialAncho=990
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)


ListaCarpetas=Lista


FiltrarFechasSinHora=S
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

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
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

Carpeta=(Carpeta principal)
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


[Lista]
Estilo=Iconos
PestanaOtroNombre=S
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
ElementosPorPaginaEsp=200
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
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha

IconosConPaginas=S





IconosNombre=VerSincroISLog:VerSincroISLog.RID
FiltroFechasDefault=Hoy
[Lista.VerSincroISLog.FechaEnvio]
Carpeta=Lista
Clave=VerSincroISLog.FechaEnvio
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

[Lista.VerSincroISLog.PaqueteBajas]
Carpeta=Lista
Clave=VerSincroISLog.PaqueteBajas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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
(Inicio)=VerSincroISLog.ConversacionTabla
VerSincroISLog.ConversacionTabla=VerSincroISLog.FechaRecibo
VerSincroISLog.FechaRecibo=VerSincroISLog.FechaEnvio
VerSincroISLog.FechaEnvio=VerSincroISLog.SucursalOrigen
VerSincroISLog.SucursalOrigen=VerSincroISLog.SucursalDestino
VerSincroISLog.SucursalDestino=VerSincroISLog.PaqueteCambios
VerSincroISLog.PaqueteCambios=VerSincroISLog.PaqueteBajas
VerSincroISLog.PaqueteBajas=VerSincroISLog.Solicitud
VerSincroISLog.Solicitud=VerSincroISLog.Conversacion
VerSincroISLog.Conversacion=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Pesonalizar
Pesonalizar=Actualizar
Actualizar=(Fin)
