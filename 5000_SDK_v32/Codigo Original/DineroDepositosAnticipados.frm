[Forma]
Clave=DineroDepositosAnticipados
Icono=6
Modulos=(Todos)
Nombre=<T>Depósitos Anticipados Pendientes<T>
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=667
PosicionInicialArriba=326
PosicionInicialAltura=300
PosicionInicialAncho=585
PosicionInicialAlturaCliente=511
VentanaEstadoInicial=Normal

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Pendientes
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DineroPendiente
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
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
FiltroAutoCampo=DineroPendiente.Moneda
FiltroAutoValidar=DineroPendiente.Moneda
FiltroEstilo=Directorio
OtroOrden=S
ListaOrden=DineroPendiente.FechaEmision<TAB>(Acendente)
IconosNombre=DineroPendiente:DineroPendiente.Mov+<T> <T>+<BR>DineroPendiente:DineroPendiente.MovID
FiltroGeneral=DineroPendiente.Empresa=<T>{Empresa}<T> AND<BR>DineroPendiente.MovTipo=<T>{DIN.DA}<T>

[Lista.DineroPendiente.FechaEmision]
Carpeta=Lista
Clave=DineroPendiente.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.DineroPendiente.Importe]
Carpeta=Lista
Clave=DineroPendiente.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador=1
ColorFondo=Blanco
ColorFuente=Negro

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
0=164
1=81

[Lista.DineroPendiente.Saldo]
Carpeta=Lista
Clave=DineroPendiente.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DineroPendiente.Moneda]
Carpeta=Lista
Clave=DineroPendiente.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=DineroPendiente.FechaEmision
DineroPendiente.FechaEmision=DineroPendiente.CtaDinero
DineroPendiente.CtaDinero=DineroPendiente.Importe
DineroPendiente.Importe=DineroPendiente.Saldo
DineroPendiente.Saldo=DineroPendiente.Moneda
DineroPendiente.Moneda=(Fin)
