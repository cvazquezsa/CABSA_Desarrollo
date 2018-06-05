[Forma]
Clave=VerSincroISSolicitud
Nombre=Solicitudes de Sincronización
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=315
PosicionInicialArriba=220
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
Vista=VerSincroISSolicitud
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

IconosNombre=VerSincroISSolicitud:VerSincroISSolicitud.Solicitud
[Lista.VerSincroISSolicitud.Tipo]
Carpeta=Lista
Clave=VerSincroISSolicitud.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.VerSincroISSolicitud.SucursalOrigen]
Carpeta=Lista
Clave=VerSincroISSolicitud.SucursalOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VerSincroISSolicitud.SucursalDestino]
Carpeta=Lista
Clave=VerSincroISSolicitud.SucursalDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VerSincroISSolicitud.FechaEnvio]
Carpeta=Lista
Clave=VerSincroISSolicitud.FechaEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VerSincroISSolicitud.FechaRecibo]
Carpeta=Lista
Clave=VerSincroISSolicitud.FechaRecibo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VerSincroISSolicitud.Estatus]
Carpeta=Lista
Clave=VerSincroISSolicitud.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

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

2=-2
3=-2
4=-2
5=-2
6=-2
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

Expresion=ProcesarSQL(<T>spSincroIS_SolicitarPrueba :tUsuario<T>, Usuario)<BR>Forma.ActualizarVista(<T>Lista<T>)
ActivoCondicion=SQL(<T>SELECT Sucursal FROM Version<T>)>0
[Acciones.Detalles]
Nombre=Detalles
Boton=47
NombreDesplegar=&Detalles
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerSincroISSolicitudLog
Activo=S
ConCondicion=S
Antes=S
Visible=S
NombreEnBoton=S

EjecucionCondicion=ConDatos(VerSincroISSolicitud:VerSincroISSolicitud.Solicitud)
AntesExpresiones=Asigna(Info.Clave, VerSincroISSolicitud:VerSincroISSolicitud.Solicitud)


[Lista.ListaEnCaptura]
(Inicio)=VerSincroISSolicitud.Tipo
VerSincroISSolicitud.Tipo=VerSincroISSolicitud.SucursalOrigen
VerSincroISSolicitud.SucursalOrigen=VerSincroISSolicitud.SucursalDestino
VerSincroISSolicitud.SucursalDestino=VerSincroISSolicitud.FechaEnvio
VerSincroISSolicitud.FechaEnvio=VerSincroISSolicitud.FechaRecibo
VerSincroISSolicitud.FechaRecibo=VerSincroISSolicitud.Estatus
VerSincroISSolicitud.Estatus=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=(Fin)


































[Acciones.Sincronizar]
Nombre=Sincronizar
Boton=112
NombreEnBoton=S
NombreDesplegar=&Sincronizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=ADO.EjecutarSQL(<T>Sincronización...<T>,<T>EXEC spSincroIS_Sincronizar <T> & Comillas(Usuario))<BR>Forma.ActualizarVista(<T>Lista<T>)
Activo=S
Visible=S











[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=Detalles
Detalles=Sincronizar
Sincronizar=Prueba
Prueba=Actualizar
Actualizar=(Fin)
