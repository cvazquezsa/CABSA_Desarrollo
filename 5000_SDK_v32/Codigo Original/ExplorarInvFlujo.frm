[Forma]
Clave=ExplorarInvFlujo
Nombre=<T>Explorando - Flujo del Inventario<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=107
PosicionInicialArriba=153
PosicionInicialAltura=454
PosicionInicialAncho=810
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=427

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InvFlujo
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
FiltroListasRama=INV
FiltroListasAplicaEn=InvFlujo.Articulo
FiltroGrupo1=(Validaciones Memoria)
FiltroTodo=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
FiltroTodoFinal=S
MenuLocal=S
ListaAcciones=(Lista)
PestanaOtroNombre=S
PestanaNombre=Movimientos
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroMonedasCampo=Art.MonedaCosto
PermiteLocalizar=S
FiltroAplicaEn=Alm.Almacen
FiltroGrupo2=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=Fabricante
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Fabricante
FiltroListas=S
IconosNombre=InvFlujo:InvFlujo.Mov+<T> <T>+InvFlujo:InvFlujo.MovID
FiltroGeneral=InvFlujo.Empresa=<T>{Empresa}<T>

[Lista.Columnas]
Articulo=124
Descripcion1=256
Costo=95
Existencia=74
Valor=100
Existencias=68
0=112
1=83

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

[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreDesplegar=&Artículo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Antes=S
Visible=S
NombreEnBoton=S
ConCondicion=S
EjecucionCondicion=ConDatos(InvFlujo:InvFlujo.Articulo)
AntesExpresiones=Asigna( Info.Articulo, InvFlujo:InvFlujo.Articulo)

[Acciones.LocalInformacion]
Nombre=LocalInformacion
Boton=0
NombreDesplegar=Información del &Artículo
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Articulo, InvFlujo:InvFlujo.Articulo)

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

[Acciones.Presentacion preliminar]
Nombre=Presentacion preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Lista.InvFlujo.Articulo]
Carpeta=Lista
Clave=InvFlujo.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InvFlujo.FechaEmision]
Carpeta=Lista
Clave=InvFlujo.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Movimiento]
Nombre=Movimiento
Boton=35
NombreEnBoton=S
NombreDesplegar=<T>&Movimiento<T>
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(InvFlujo:InvFlujo.ID)
AntesExpresiones=Asigna(Info.Modulo, InvFlujo:InvFlujo.Modulo)<BR>Asigna(Info.ID, InvFlujo:InvFlujo.ID)

[Acciones.LocalMovimiento]
Nombre=LocalMovimiento
Boton=0
NombreDesplegar=Propiedades del &Movimiento
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(InvFlujo:InvFlujo.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, InvFlujo:InvFlujo.Modulo)<BR>Asigna(Info.ID, InvFlujo:InvFlujo.ID)
Visible=S

[Lista.InvFlujo.PorRecibir]
Carpeta=Lista
Clave=InvFlujo.PorRecibir
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InvFlujo.PorSurtir]
Carpeta=Lista
Clave=InvFlujo.PorSurtir
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InvFlujo.Disponible]
Carpeta=Lista
Clave=InvFlujo.Disponible
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=Informacion
Informacion=Movimiento
Movimiento=Mostrar Campos
Mostrar Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=InvFlujo.FechaEmision
InvFlujo.FechaEmision=InvFlujo.Articulo
InvFlujo.Articulo=Art.Descripcion1
Art.Descripcion1=InvFlujo.PorRecibir
InvFlujo.PorRecibir=InvFlujo.PorSurtir
InvFlujo.PorSurtir=InvFlujo.Disponible
InvFlujo.Disponible=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalInformacion
LocalInformacion=LocalMovimiento
LocalMovimiento=(Fin)
