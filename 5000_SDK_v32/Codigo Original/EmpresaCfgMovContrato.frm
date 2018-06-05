[Forma]
Clave=EmpresaCfgMovContrato
Nombre=Flujo Movimientos Contratos (por omisión)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Empresa
PosicionInicialIzquierda=352
PosicionInicialArriba=230
PosicionInicialAlturaCliente=273
PosicionInicialAncho=320
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovContrato
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=EmpresaCfgMovContrato.Empresa=<T>{Info.Empresa}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.EmpresaCfgMovContrato.Modulo]
Carpeta=Lista
Clave=EmpresaCfgMovContrato.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgMovContrato.MovOrigen]
Carpeta=Lista
Clave=EmpresaCfgMovContrato.MovOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgMovContrato.MovDestino]
Carpeta=Lista
Clave=EmpresaCfgMovContrato.MovDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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
Modulo=53
MovOrigen=118
MovDestino=118

[Lista.ListaEnCaptura]
(Inicio)=EmpresaCfgMovContrato.Modulo
EmpresaCfgMovContrato.Modulo=EmpresaCfgMovContrato.MovOrigen
EmpresaCfgMovContrato.MovOrigen=EmpresaCfgMovContrato.MovDestino
EmpresaCfgMovContrato.MovDestino=(Fin)
