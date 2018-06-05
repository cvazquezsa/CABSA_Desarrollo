[Forma]
Clave=VerSincroSSBSolicitud
Nombre=Solicitudes de Sincronización
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=555
PosicionInicialArriba=371
PosicionInicialAlturaCliente=422
PosicionInicialAncho=810
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerSincroSSBSolicitud
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Solicitud<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
IconosNombre=VerSincroSSBSolicitud:VerSincroSSBSolicitud.Solicitud

[Lista.VerSincroSSBSolicitud.Tipo]
Carpeta=Lista
Clave=VerSincroSSBSolicitud.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerSincroSSBSolicitud.SucursalOrigen]
Carpeta=Lista
Clave=VerSincroSSBSolicitud.SucursalOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerSincroSSBSolicitud.SucursalDestino]
Carpeta=Lista
Clave=VerSincroSSBSolicitud.SucursalDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerSincroSSBSolicitud.FechaEnvio]
Carpeta=Lista
Clave=VerSincroSSBSolicitud.FechaEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerSincroSSBSolicitud.FechaRecibo]
Carpeta=Lista
Clave=VerSincroSSBSolicitud.FechaRecibo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerSincroSSBSolicitud.Estatus]
Carpeta=Lista
Clave=VerSincroSSBSolicitud.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
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

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.Columnas]
0=61
1=144

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=&Actualizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Prueba]
Nombre=Prueba
Boton=105
NombreEnBoton=S
NombreDesplegar=Solicitar &Prueba
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Expresion=ProcesarSQL(<T>spSincroSSB_SolicitarPrueba<T>)<BR>Forma.ActualizarVista(<T>Lista<T>)
ActivoCondicion=SQL(<T>SELECT Sucursal FROM Version<T>)>0

[Acciones.Detalles]
Nombre=Detalles
Boton=47
NombreDesplegar=&Detalles
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerSincroSSBSolicitudLog
Activo=S
ConCondicion=S
Antes=S
Visible=S
NombreEnBoton=S
EjecucionCondicion=ConDatos(VerSincroSSBSolicitud:VerSincroSSBSolicitud.Solicitud)
AntesExpresiones=Asigna(Info.Clave, VerSincroSSBSolicitud:VerSincroSSBSolicitud.Solicitud)

[Acciones.Sincro]
Nombre=Sincro
Boton=112
NombreEnBoton=S
NombreDesplegar=&Sincronizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Expresion=EjecutarSQL(<T>spSincroSSB_Sincronizar<T>)<BR>Forma.ActualizarVista(<T>Lista<T>)
ActivoCondicion=SQL(<T>SELECT Sucursal FROM Version<T>)>0

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=Detalles
Detalles=Sincro
Sincro=Prueba
Prueba=Actualizar
Actualizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VerSincroSSBSolicitud.Tipo
VerSincroSSBSolicitud.Tipo=VerSincroSSBSolicitud.SucursalOrigen
VerSincroSSBSolicitud.SucursalOrigen=VerSincroSSBSolicitud.SucursalDestino
VerSincroSSBSolicitud.SucursalDestino=VerSincroSSBSolicitud.FechaEnvio
VerSincroSSBSolicitud.FechaEnvio=VerSincroSSBSolicitud.FechaRecibo
VerSincroSSBSolicitud.FechaRecibo=VerSincroSSBSolicitud.Estatus
VerSincroSSBSolicitud.Estatus=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=(Fin)
