[Forma]
Clave=InvFusionarBorradores
Nombre=Fusionar Inventarios Físicos
Icono=0
EsMovimiento=S
Modulos=NOM
MovModulo=NOM
TituloAuto=S
MovEspecificos=Todos
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=114
PosicionInicialArriba=149
PosicionInicialAlturaCliente=436
PosicionInicialAncho=796
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InvA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
CarpetaVisible=S
PestanaOtroNombre=S
IconosSeleccionMultiple=S
BusquedaRapidaControles=S
FiltroUsuarios=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroProyectos=S
FiltroSucursales=S
FiltroUENs=S
FiltroUENsCampo=Inv.UEN
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=Inv.FechaEmision
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroAplicaEn=Inv.Almacen
FiltroAutoCampo=Inv.Almacen
FiltroAutoValidar=Inv.Almacen
IconosNombre=InvA:Inv.Mov+<T> <T>+InvA:Inv.MovID
FiltroEstilo=Directorio
FiltroGeneral=Inv.Empresa=<T>{Empresa}<T> AND Inv.Estatus=<T>SINAFECTAR<T> AND Inv.Mov IN ({MovListaSQL(<T>INV<T>, INV.IF)})

[Lista.Inv.FechaEmision]
Carpeta=Lista
Clave=Inv.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Inv.Concepto]
Carpeta=Lista
Clave=Inv.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=125
1=79

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

[Acciones.Fusionar]
Nombre=Fusionar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Fusionar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Expresion<BR>Actualizar Vista

[Acciones.Fusionar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=RegistrarSeleccionID<BR>ProcesarSQL(<T>spInvFusionarBorradores :nEstacion<T>, EstacionTrabajo)

[Acciones.Fusionar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=55
NombreEnBoton=S
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S
EspacioPrevio=S

[Lista.Inv.Observaciones]
Carpeta=Lista
Clave=Inv.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Inv.Almacen]
Carpeta=Lista
Clave=Inv.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Seleccionar Todo
Seleccionar Todo=Fusionar
Fusionar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Inv.FechaEmision
Inv.FechaEmision=Inv.Almacen
Inv.Almacen=Inv.Concepto
Inv.Concepto=Inv.Observaciones
Inv.Observaciones=(Fin)
