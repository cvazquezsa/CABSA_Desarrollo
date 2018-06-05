
[Forma]
Clave=DineroCargosNoIdentificados
Icono=0
Modulos=(Todos)
Nombre=<T>Cargos No Identificados<T>

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=345
PosicionInicialArriba=210
PosicionInicialAlturaCliente=513
PosicionInicialAncho=590
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DineroPendiente
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Pendientes
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático


IconosSubTitulo=<T>Movimiento<T>
FiltroAutoCampo=DineroPendiente.Moneda
FiltroAutoValidar=DineroPendiente.Moneda
IconosNombre=DineroPendiente:DineroPendiente.Mov+<T> <T>+<BR>DineroPendiente:DineroPendiente.MovID
FiltroEstilo=Directorio
FiltroGeneral=DineroPendiente.Empresa=<T>{Empresa}<T> AND<BR>DineroPendiente.MovTipo=<T>{DIN.CNI}<T>
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S






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
ColorFondo=Blanco
ColorFuente=Negro

Totalizador=1
[Lista.DineroPendiente.Saldo]
Carpeta=Lista
Clave=DineroPendiente.Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro








Totalizador=1
[Lista.Columnas]
0=189
1=113
2=-2
3=62

4=76
















5=-2

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
