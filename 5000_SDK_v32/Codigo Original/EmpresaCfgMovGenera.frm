[Forma]
Clave=EmpresaCfgMovGenera
Nombre=<T>Excepciones - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=438
PosicionInicialArriba=362
PosicionInicialAltura=300
PosicionInicialAncho=514
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
Comentarios=Info.Empresa
PosicionInicialAlturaCliente=273

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovGenera
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
FiltroGeneral=EmpresaCfgMovGenera.Empresa=<T>{Info.Empresa}<T>

[Lista.EmpresaCfgMovGenera.Modulo]
Carpeta=Lista
Clave=EmpresaCfgMovGenera.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgMovGenera.Mov]
Carpeta=Lista
Clave=EmpresaCfgMovGenera.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgMovGenera.GeneraModulo]
Carpeta=Lista
Clave=EmpresaCfgMovGenera.GeneraModulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgMovGenera.GeneraMov]
Carpeta=Lista
Clave=EmpresaCfgMovGenera.GeneraMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Modulo=58
Mov=121
GeneraModulo=82
GeneraMov=110
ArrastrarMovID=110

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

[Lista.EmpresaCfgMovGenera.ArrastrarMovID]
Carpeta=Lista
Clave=EmpresaCfgMovGenera.ArrastrarMovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=EmpresaCfgMovGenera.Modulo
EmpresaCfgMovGenera.Modulo=EmpresaCfgMovGenera.Mov
EmpresaCfgMovGenera.Mov=EmpresaCfgMovGenera.GeneraModulo
EmpresaCfgMovGenera.GeneraModulo=EmpresaCfgMovGenera.GeneraMov
EmpresaCfgMovGenera.GeneraMov=EmpresaCfgMovGenera.ArrastrarMovID
EmpresaCfgMovGenera.ArrastrarMovID=(Fin)
