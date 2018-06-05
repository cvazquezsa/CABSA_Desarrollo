[Forma]
Clave=EmpresaPedidosReservarEsp
Nombre=<T>Auto Reservar - Movimientos Especificos<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=357
PosicionInicialArriba=213
PosicionInicialAltura=334
PosicionInicialAncho=309
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialAlturaCliente=307
Comentarios=Info.Empresa

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaPedidosReservarEsp
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaTitulos=S
HojaMostrarColumnas=S
OtroOrden=S
ListaOrden=(Lista)
FiltroGeneral=EmpresaPedidosReservarEsp.Empresa=<T>{Info.Empresa}<T>

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Concepto=256
Modulo=84
Mov=195

[Lista.EmpresaPedidosReservarEsp.Modulo]
Carpeta=Lista
Clave=EmpresaPedidosReservarEsp.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaPedidosReservarEsp.Mov]
Carpeta=Lista
Clave=EmpresaPedidosReservarEsp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=EmpresaPedidosReservarEsp.Modulo
EmpresaPedidosReservarEsp.Modulo=EmpresaPedidosReservarEsp.Mov
EmpresaPedidosReservarEsp.Mov=(Fin)

[Lista.ListaOrden]
(Inicio)=EmpresaPedidosReservarEsp.Modulo<TAB>(Decendente)
EmpresaPedidosReservarEsp.Modulo<TAB>(Decendente)=EmpresaPedidosReservarEsp.Mov<TAB>(Acendente)
EmpresaPedidosReservarEsp.Mov<TAB>(Acendente)=(Fin)
