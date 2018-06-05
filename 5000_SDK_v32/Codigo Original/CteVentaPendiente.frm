[Forma]
Clave=CteVentaPendiente
Nombre=<T>Ventas Pendientes del Cliente<T>
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=111
PosicionInicialArriba=199
PosicionInicialAltura=369
PosicionInicialAncho=802
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Cliente
VentanaEscCerrar=S
EsConsultaExclusiva=S

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaPendienteD
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
Filtros=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
FiltroAutoCampo=VentaPendienteD.Cliente
FiltroAutoValidar=VentaPendienteD.Cliente
FiltroGrupo1=Cliente
FiltroValida1=Nombre
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
MenuLocal=S
ListaAcciones=Actualizar
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroFechasNormal=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
IconosNombre=VentaPendienteD:VentaPendienteD.Mov+<T> <T>+VentaPendienteD:VentaPendienteD.MovID
FiltroGeneral=VentaPendienteD.Empresa=<T>{Empresa}<T> AND <BR>VentaPendienteD.Cliente=<T>{Info.Cliente}<T>
FiltroFechasCampo=VentaPendienteD.FechaEmision

[Lista.CantidadReservada]
Carpeta=Lista
Clave=CantidadReservada
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.Columnas]
0=102
1=81
Mov=103
MovID=65
FechaEmision=75
FechaRequerida=87
Articulo=99
CantidadPendiente=56

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

[Lista.]
Carpeta=Lista
ColorFondo=Negro

[Lista.VentaPendienteD.FechaEmision]
Carpeta=Lista
Clave=VentaPendienteD.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.FechaRequerida]
Carpeta=Lista
Clave=VentaPendienteD.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.Articulo]
Carpeta=Lista
Clave=VentaPendienteD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.ArtDescripcion]
Carpeta=Lista
Clave=VentaPendienteD.ArtDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
EspacioPrevio=S

[Lista.ImportePendiente]
Carpeta=Lista
Clave=ImportePendiente
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
NombreDesplegar=<T>&Movimiento<T>
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S
NombreEnBoton=S
EjecucionCondicion=ConDatos(VentaPendienteD:VentaPendienteD.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaPendienteD:VentaPendienteD.ID)

[Lista.VentaPendienteD.PendienteFactor]
Carpeta=Lista
Clave=VentaPendienteD.PendienteFactor
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.OrdenadaFactor]
Carpeta=Lista
Clave=VentaPendienteD.OrdenadaFactor
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.ReservadaFactor]
Carpeta=Lista
Clave=VentaPendienteD.ReservadaFactor
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
(Inicio)=VentaPendienteD.FechaEmision
VentaPendienteD.FechaEmision=VentaPendienteD.FechaRequerida
VentaPendienteD.FechaRequerida=VentaPendienteD.Articulo
VentaPendienteD.Articulo=VentaPendienteD.ArtDescripcion
VentaPendienteD.ArtDescripcion=VentaPendienteD.ReservadaFactor
VentaPendienteD.ReservadaFactor=VentaPendienteD.OrdenadaFactor
VentaPendienteD.OrdenadaFactor=VentaPendienteD.PendienteFactor
VentaPendienteD.PendienteFactor=ImportePendiente
ImportePendiente=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=PENDIENTE
PENDIENTE=CONFIRMAR
CONFIRMAR=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=MovPropiedades
MovPropiedades=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=(Fin)
