[Forma]
Clave=ArtSolicitudPendiente
Nombre=Solicitudes Pendientes del Artículo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=328
PosicionInicialArriba=359
PosicionInicialAltura=299
PosicionInicialAncho=624
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
Comentarios=Info.Articulo
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=272

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InvSolicitudPendienteD
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Pendientes
IconosNombre=InvSolicitudPendienteD:InvSolicitudPendienteD.Mov+<T> <T>+InvSolicitudPendienteD:InvSolicitudPendienteD.MovID
FiltroGeneral=InvSolicitudPendienteD.Articulo = <T>{Info.Articulo}<T>

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
1=83

[Lista.InvSolicitudPendienteD.Referencia]
Carpeta=Lista
Clave=InvSolicitudPendienteD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InvSolicitudPendienteD.FechaEmision]
Carpeta=Lista
Clave=InvSolicitudPendienteD.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InvSolicitudPendienteD.ReservadaFactor]
Carpeta=Lista
Clave=InvSolicitudPendienteD.ReservadaFactor
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InvSolicitudPendienteD.OrdenadaFactor]
Carpeta=Lista
Clave=InvSolicitudPendienteD.OrdenadaFactor
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InvSolicitudPendienteD.PendienteFactor]
Carpeta=Lista
Clave=InvSolicitudPendienteD.PendienteFactor
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
NombreDesplegar=Presentación preliminar
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

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S


[Lista.ListaEnCaptura]
(Inicio)=InvSolicitudPendienteD.FechaEmision
InvSolicitudPendienteD.FechaEmision=InvSolicitudPendienteD.Referencia
InvSolicitudPendienteD.Referencia=InvSolicitudPendienteD.ReservadaFactor
InvSolicitudPendienteD.ReservadaFactor=InvSolicitudPendienteD.OrdenadaFactor
InvSolicitudPendienteD.OrdenadaFactor=InvSolicitudPendienteD.PendienteFactor
InvSolicitudPendienteD.PendienteFactor=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=(Fin)
