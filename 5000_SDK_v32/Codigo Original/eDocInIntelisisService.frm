
[Forma]
Clave=eDocInIntelisisService
Icono=0
CarpetaPrincipal=eDocInIntelisisService
Modulos=(Todos)
Nombre=Documento Electrónico

ListaCarpetas=eDocInIntelisisService
PosicionInicialIzquierda=253
PosicionInicialArriba=159
PosicionInicialAlturaCliente=504
PosicionInicialAncho=1094
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)




VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[eDociInIntelisisService.Columnas]
Solicitud=304
Resultado=304
Estatus=94
Ok=64
OkRef=604




0=160
1=93
2=94
3=300

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.eDocInISDetalleTemp]
Nombre=eDocInISDetalleTemp
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=eDocInISDetalleTemp
Activo=S
Antes=S
Visible=S

























AntesExpresiones=Asigna(Info.RID,eDocInIntelisisService2:eDocInIntelisisService2.ID)<BR>EjecutarSQL(<T>speDocInISDetalle :nEstacion, :nID<T>,EstacionTrabajo,eDocInIntelisisService2:eDocInIntelisisService2.ID)<BR>Asigna(Info.Nombre2,eDocInIntelisisService2:eDocInIntelisisService2.eDocInArchivo)
[eDociInIntelisisService.ListaEnCaptura]
(Inicio)=eDociInIntelisisService.Estatus
eDociInIntelisisService.Estatus=eDociInIntelisisService.Ok
eDociInIntelisisService.Ok=eDociInIntelisisService.OkRef
eDociInIntelisisService.OkRef=(Fin)



[Acciones.eDocInArchivoTemp]
Nombre=eDocInArchivoTemp
Boton=124
NombreEnBoton=S
NombreDesplegar=&Archivo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=eDocInArchivoTemp
Activo=S
Antes=S
Visible=S








AntesExpresiones=EjecutarSQL(<T>speDocInArchivoTemp :nEstacion,:nID<T>,EstacionTrabajo,eDocInIntelisisService2:eDocInIntelisisService2.ID)

[eDocInIntelisisService]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Registros
Clave=eDocInIntelisisService
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocInIntelisisService2
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(Situación)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroFechas=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=eDocInIntelisisService2.FechaEstatus
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S








OtroOrden=S
ListaOrden=eDocInIntelisisService2.ID<TAB>(Acendente)
FiltroEstatus=S


IconosSubTitulo=<T>Fecha<T>
FiltroListaEstatus=(Lista)
FiltroFechasDefault=Hoy
FiltroEstatusDefault=CONCLUIDO
IconosNombre=eDocInIntelisisService2:eDocInIntelisisService2.FechaEstatus
FiltroGeneral=eDocInIntelisisService2.Referencia = <T>Intelisis.eDocInProcesar<T>
FiltroModificarEstatus=S
[eDocInIntelisisService.Columnas]
0=197
1=150
2=118
3=-2








4=-2




[eDocInIntelisisService.eDocInIntelisisService2.eDocInArchivo]
Carpeta=eDocInIntelisisService
Clave=eDocInIntelisisService2.eDocInArchivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[eDocInIntelisisService.eDocInIntelisisService2.Ok]
Carpeta=eDocInIntelisisService
Clave=eDocInIntelisisService2.Ok
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[eDocInIntelisisService.eDocInIntelisisService2.OkRef]
Carpeta=eDocInIntelisisService
Clave=eDocInIntelisisService2.OkRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco












[Acciones.ReProcesar]
Nombre=ReProcesar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Re-Procesar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S



ConfirmarAntes=S
DialogoMensaje=EstaSeguroPrecaucion








Expresion=EjecutarSQL(<T>speDocInReprocesarIS :nID,:tUsuario<T>,eDocInIntelisisService2:eDocInIntelisisService2.ID,Usuario)<BR> ActualizarForma
ActivoCondicion=eDocInIntelisisService2:eDocInIntelisisService2.Estatus = EstatusError

















































[Acciones.Actualizar Forma]
Nombre=Actualizar Forma
Boton=82
NombreEnBoton=S
NombreDesplegar=&Actualizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S




















[eDocInIntelisisService.ListaEnCaptura]
(Inicio)=eDocInIntelisisService2.eDocInArchivo
eDocInIntelisisService2.eDocInArchivo=eDocInIntelisisService2.Ok
eDocInIntelisisService2.Ok=eDocInIntelisisService2.OkRef
eDocInIntelisisService2.OkRef=(Fin)

[eDocInIntelisisService.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=ERROR
ERROR=(Fin)





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=eDocInISDetalleTemp
eDocInISDetalleTemp=eDocInArchivoTemp
eDocInArchivoTemp=Actualizar Forma
Actualizar Forma=ReProcesar
ReProcesar=(Fin)
