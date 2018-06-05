[Forma]
Clave=GastoPendienteLista
Nombre=<T>Gastos Pendientes del <T>+Info.Tipo
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=397
PosicionInicialArriba=367
PosicionInicialAltura=289
PosicionInicialAncho=486
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
Comentarios=Si(ConDatos(Info.Acreedor),Info.Acreedor,<T><T>)
PosicionInicialAlturaCliente=262

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GastoPendiente
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>Movimiento<T>
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=GastoPendiente.Vencimiento<TAB>(Acendente)
PestanaOtroNombre=S
IconosNombre=GastoPendiente:GastoPendiente.Mov+<T> <T>+GastoPendiente:GastoPendiente.MovID
FiltroGeneral=GastoPendiente.Empresa=<T>{Empresa}<T> AND<BR>GastoPendiente.Acreedor=<T>{Info.Acreedor}<T> AND<BR>GastoPendiente.Mov NOT IN ({MovListaSQL(<T>GAS<T>, Info.MovTipo)})

[Lista.Columnas]
0=175
1=83

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.MovID, GastoPendiente:GastoPendiente.MovID)

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
NombreEnBoton=S
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Visible=S
EspacioPrevio=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(GastoPendiente:GastoPendiente.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, GastoPendiente:GastoPendiente.ID)

[Lista.GastoPendiente.FechaEmision]
Carpeta=Lista
Clave=GastoPendiente.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GastoPendiente.Vencimiento]
Carpeta=Lista
Clave=GastoPendiente.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GastoPendiente.Saldo]
Carpeta=Lista
Clave=GastoPendiente.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=MovPropiedades
MovPropiedades=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=GastoPendiente.FechaEmision
GastoPendiente.FechaEmision=GastoPendiente.Vencimiento
GastoPendiente.Vencimiento=GastoPendiente.Saldo
GastoPendiente.Saldo=(Fin)
