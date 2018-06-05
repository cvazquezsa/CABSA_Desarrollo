
[Forma]
Clave=ActivoFTipoServicio
Icono=0
Modulos=(Todos)
Nombre=Servicios a Generar

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialAlturaCliente=432
PosicionInicialAncho=1022
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=209
PosicionInicialArriba=220
ListaAcciones=(Lista)
Comentarios=Lista(Info.Tipo)
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoFTipoServicio
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
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
CarpetaVisible=S

FiltroGeneral=ActivoFTipoServicio.Tipo = {Comillas(Info.Tipo)}
[Lista.ActivoFTipoServicio.Servicio]
Carpeta=Lista
Clave=ActivoFTipoServicio.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoServicio.Descripcion]
Carpeta=Lista
Clave=ActivoFTipoServicio.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoServicio.Unico]
Carpeta=Lista
Clave=ActivoFTipoServicio.Unico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoServicio.Inspeccion]
Carpeta=Lista
Clave=ActivoFTipoServicio.Inspeccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoServicio.InspeccionUnidad]
Carpeta=Lista
Clave=ActivoFTipoServicio.InspeccionUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoServicio.InspeccionUsuarioEsp]
Carpeta=Lista
Clave=ActivoFTipoServicio.InspeccionUsuarioEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoServicio.ServicioTallerEsp]
Carpeta=Lista
Clave=ActivoFTipoServicio.ServicioTallerEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoServicio.ServicioUsuarioEsp]
Carpeta=Lista
Clave=ActivoFTipoServicio.ServicioUsuarioEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoServicio.ServicioMovEsp]
Carpeta=Lista
Clave=ActivoFTipoServicio.ServicioMovEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoServicio.ServicioConceptoEsp]
Carpeta=Lista
Clave=ActivoFTipoServicio.ServicioConceptoEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoServicio.ServicioClienteEsp]
Carpeta=Lista
Clave=ActivoFTipoServicio.ServicioClienteEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Servicio=79
Descripcion=198
Unico=35
Inspeccion=57
InspeccionUnidad=96
InspeccionUsuarioEsp=97
ServicioTallerEsp=49
ServicioUsuarioEsp=82
ServicioMovEsp=98
ServicioConceptoEsp=96
ServicioClienteEsp=99

Cliente=117
Nombre=293
RFC=107

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S






[Acciones.Condiciones]
Nombre=Condiciones
Boton=90
NombreEnBoton=S
NombreDesplegar=Condiciones
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ActivoFTipoServicioCondicion
Activo=S
Antes=S
Visible=S





EspacioPrevio=S





















AntesExpresiones=Asigna( Info.Servicio, ActivoFTipoServicio:ActivoFTipoServicio.Servicio )
[Lista.ListaEnCaptura]
(Inicio)=ActivoFTipoServicio.Servicio
ActivoFTipoServicio.Servicio=ActivoFTipoServicio.Descripcion
ActivoFTipoServicio.Descripcion=ActivoFTipoServicio.Unico
ActivoFTipoServicio.Unico=ActivoFTipoServicio.Inspeccion
ActivoFTipoServicio.Inspeccion=ActivoFTipoServicio.InspeccionUnidad
ActivoFTipoServicio.InspeccionUnidad=ActivoFTipoServicio.InspeccionUsuarioEsp
ActivoFTipoServicio.InspeccionUsuarioEsp=ActivoFTipoServicio.ServicioTallerEsp
ActivoFTipoServicio.ServicioTallerEsp=ActivoFTipoServicio.ServicioUsuarioEsp
ActivoFTipoServicio.ServicioUsuarioEsp=ActivoFTipoServicio.ServicioMovEsp
ActivoFTipoServicio.ServicioMovEsp=ActivoFTipoServicio.ServicioConceptoEsp
ActivoFTipoServicio.ServicioConceptoEsp=ActivoFTipoServicio.ServicioClienteEsp
ActivoFTipoServicio.ServicioClienteEsp=(Fin)


[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreDesplegar=&Detalle
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ActivoFTipoServicioD
Activo=S
Antes=S







NombreEnBoton=S




















AntesExpresiones=Asigna(Info.Servicio,ActivoFTipoServicio:ActivoFTipoServicio.Servicio)




[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Condiciones
Condiciones=Detalle
Detalle=(Fin)
