[Forma]
Clave=ProvCompraPendiente
Nombre=<T>Compras Pendientes del Proveedor<T>
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=107
PosicionInicialArriba=226
PosicionInicialAltura=315
PosicionInicialAncho=809
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Proveedor
VentanaEscCerrar=S

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
Vista=CompraPendienteD
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
Filtros=S
FiltroTipo=Múltiple (por Grupos)
FiltroEnOrden=S
FiltroTodoNombre=Todos los artículos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=20
FiltroPredefinido=S
FiltroAutoCampo=CompraPendienteD.Articulo
FiltroAutoValidar=CompraPendienteD.ArtDescripcion
FiltroAplicaEn=
FiltroGrupo1=CompraPendienteD.Articulo
FiltroValida1=CompraPendienteD.Articulo
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
FiltroTodo=S
MenuLocal=S
ListaAcciones=Actualizar
IconosNombre=CompraPendienteD:CompraPendienteD.Mov+<T> <T>+CompraPendienteD:CompraPendienteD.MovID
FiltroGeneral=CompraPendienteD.Empresa=<T>{Empresa}<T> AND <BR>CompraPendienteD.Proveedor=<T>{Info.Proveedor}<T>

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
0=124
1=81
Mov=103
MovID=65
FechaEmision=75
FechaRequerida=87
Articulo=99
Almacen=68
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

[Lista.CompraPendienteD.FechaEmision]
Carpeta=Lista
Clave=CompraPendienteD.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15

[Lista.CompraPendienteD.CantidadPendiente]
Carpeta=Lista
Clave=CompraPendienteD.CantidadPendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
Totalizador=1

[Lista.CompraPendienteD.FechaRequerida]
Carpeta=Lista
Clave=CompraPendienteD.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15

[Lista.CompraPendienteD.Almacen]
Carpeta=Lista
Clave=CompraPendienteD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.CompraPendienteD.Articulo]
Carpeta=Lista
Clave=CompraPendienteD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

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

[Lista.CompraPendienteD.Referencia]
Carpeta=Lista
Clave=CompraPendienteD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

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
EjecucionCondicion=ConDatos(CompraPendienteD:CompraPendienteD.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, CompraPendienteD:CompraPendienteD.ID)

[Acciones.Mostrar Campos]
Nombre=Mostrar Campos
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
(Inicio)=CompraPendienteD.Referencia
CompraPendienteD.Referencia=CompraPendienteD.FechaEmision
CompraPendienteD.FechaEmision=CompraPendienteD.FechaRequerida
CompraPendienteD.FechaRequerida=CompraPendienteD.Articulo
CompraPendienteD.Articulo=CompraPendienteD.Almacen
CompraPendienteD.Almacen=CompraPendienteD.CantidadPendiente
CompraPendienteD.CantidadPendiente=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=MovPropiedades
MovPropiedades=Mostrar Campos
Mostrar Campos=(Fin)
