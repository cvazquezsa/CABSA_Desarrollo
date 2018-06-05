[Forma]
Clave=ArtVentaPendiente
Nombre=<T>Ventas Pendientes del Artículo<T>
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=73
PosicionInicialArriba=197
PosicionInicialAltura=374
PosicionInicialAncho=877
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo, Si(Ver.Semana<>Nulo, e(<T>Semana<T>)+<T>: <T>+Ver.Semana))
VentanaEscCerrar=S
EsConsultaExclusiva=S
VentanaExclusiva=S
EsMovimiento=S
TituloAuto=S
MovModulo=VTAS

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
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMovDefault=(Todos)
FiltroFechasNormal=S
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
IconosNombre=VentaPendienteD:VentaPendienteD.Mov+<T> <T>+VentaPendienteD:VentaPendienteD.MovID
FiltroGeneral=VentaPendienteD.Empresa=<T>{Empresa}<T> AND <BR>VentaPendienteD.Articulo=<T>{Info.Articulo}<T><BR>{Si(Ver.Semana<>Nulo, <T> AND VentaPendienteD.Semana=<T>+Ver.Semana, <T><T>)}

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
0=103
1=74
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

[Lista.VentaPendienteD.Cliente]
Carpeta=Lista
Clave=VentaPendienteD.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.CteNombre]
Carpeta=Lista
Clave=VentaPendienteD.CteNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreEnBoton=S
NombreDesplegar=<T>&Movimiento<T>
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(VentaPendienteD:VentaPendienteD.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaPendienteD:VentaPendienteD.ID)
Visible=S

[Lista.VentaPendienteD.Almacen]
Carpeta=Lista
Clave=VentaPendienteD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
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

[Lista.ImportePendiente]
Carpeta=Lista
Clave=ImportePendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

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

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Propiedades
Propiedades=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VentaPendienteD.Almacen
VentaPendienteD.Almacen=VentaPendienteD.Cliente
VentaPendienteD.Cliente=VentaPendienteD.CteNombre
VentaPendienteD.CteNombre=VentaPendienteD.FechaEmision
VentaPendienteD.FechaEmision=VentaPendienteD.FechaRequerida
VentaPendienteD.FechaRequerida=VentaPendienteD.ReservadaFactor
VentaPendienteD.ReservadaFactor=VentaPendienteD.OrdenadaFactor
VentaPendienteD.OrdenadaFactor=VentaPendienteD.PendienteFactor
VentaPendienteD.PendienteFactor=ImportePendiente
ImportePendiente=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=PENDIENTE
PENDIENTE=CONFIRMAR
CONFIRMAR=(Fin)
