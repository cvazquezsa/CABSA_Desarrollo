[Forma]
Clave=EmpresaCfgMovEsp
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=262
PosicionInicialArriba=208
PosicionInicialAltura=351
PosicionInicialAncho=500
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Nombre=Info.Descripcion
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovEsp
Fuente={MS Sans Serif, 8, Negro, []}
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
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=EmpresaCfgMovEsp.Empresa=<T>{Info.Empresa}<T> AND <BR>EmpresaCfgMovEsp.Asunto=<T>{Info.Asunto}<T>

[Lista.EmpresaCfgMovEsp.Modulo]
Carpeta=Lista
Clave=EmpresaCfgMovEsp.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgMovEsp.Mov]
Carpeta=Lista
Clave=EmpresaCfgMovEsp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Modulo=68
Mov=156
Accion=138

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.EmpresaCfgMovEsp.Accion]
Carpeta=Lista
Clave=EmpresaCfgMovEsp.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=EmpresaCfgMovEsp.Modulo
EmpresaCfgMovEsp.Modulo=EmpresaCfgMovEsp.Mov
EmpresaCfgMovEsp.Mov=EmpresaCfgMovEsp.Accion
EmpresaCfgMovEsp.Accion=(Fin)
