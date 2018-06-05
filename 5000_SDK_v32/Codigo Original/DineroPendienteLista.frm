[Forma]
Clave=DineroPendienteLista
Nombre=Pendientes
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar<BR>Personalizar
PosicionInicialIzquierda=266
PosicionInicialArriba=261
PosicionInicialAltura=309
PosicionInicialAncho=748
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=475

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DineroPendiente
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroTipo=Automático
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
OtroOrden=S
ListaOrden=DineroPendiente.FechaProgramada<TAB>(Acendente)
MenuLocal=S
ListaAcciones=Actualizar
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSucursales=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroFechas=S
FiltroFechasCampo=DineroPendiente.FechaEmision
FiltroFechasDefault=(Todo)
FiltroAplicaEn=DineroPendiente.FormaPago
FiltroAutoCampo=DineroPendiente.FormaPago
FiltroAutoValidar=DineroPendiente.FormaPago
FiltroTodo=S
FiltroEstilo=Folder (1 línea)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
PestanaOtroNombre=S
IconosNombre=DineroPendiente:DineroPendiente.Mov+<T> <T>+DineroPendiente:DineroPendiente.MovID
FiltroGeneral=DineroPendiente.Empresa=<T>{Empresa}<T> AND<BR>DineroPendiente.Mov=<T>{Info.Mov}<T>

[Lista.DineroPendiente.FechaEmision]
Carpeta=Lista
Clave=DineroPendiente.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DineroPendiente.FechaProgramada]
Carpeta=Lista
Clave=DineroPendiente.FechaProgramada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DineroPendiente.Saldo]
Carpeta=Lista
Clave=DineroPendiente.Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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

AntesExpresiones=Asigna(Info.MovID, DineroPendiente:DineroPendiente.MovID)<BR>Asigna(Info.Importe, DineroPendiente:DineroPendiente.Saldo)<BR>Asigna(Info.Copiar, Verdadero)<BR>Asigna(Info.FormaPago, DineroPendiente:DineroPendiente.FormaPago)
[Lista.Columnas]
Mov=103
MovID=64
FechaEmision=75
FechaProgramada=96
Saldo=92
CtaDinero=80
Referencia=121
0=124
1=83

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

[Lista.DineroPendiente.CtaDinero]
Carpeta=Lista
Clave=DineroPendiente.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DineroPendiente.Referencia]
Carpeta=Lista
Clave=DineroPendiente.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=DineroPendiente.FechaEmision
DineroPendiente.FechaEmision=DineroPendiente.FechaProgramada
DineroPendiente.FechaProgramada=DineroPendiente.CtaDinero
DineroPendiente.CtaDinero=DineroPendiente.Referencia
DineroPendiente.Referencia=DineroPendiente.Saldo
DineroPendiente.Saldo=(Fin)















[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)
