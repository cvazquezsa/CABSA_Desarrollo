[Forma]
Clave=EmpresaCfgMovImp
Nombre=Reportes Especificos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=190
PosicionInicialArriba=230
PosicionInicialAltura=300
PosicionInicialAncho=643
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Empresa
PosicionInicialAlturaCliente=273

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

[Ficha.Columnas]
Modulo=71
Mov=112
ReporteImpresora=187
ReportePantalla=185

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovImp
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
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=EmpresaCfgMovImp.Empresa=<T>{Info.Empresa}<T>

[Lista.EmpresaCfgMovImp.Modulo]
Carpeta=Lista
Clave=EmpresaCfgMovImp.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgMovImp.Mov]
Carpeta=Lista
Clave=EmpresaCfgMovImp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgMovImp.ReporteImpresora]
Carpeta=Lista
Clave=EmpresaCfgMovImp.ReporteImpresora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgMovImp.ReportePantalla]
Carpeta=Lista
Clave=EmpresaCfgMovImp.ReportePantalla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgMovImp.Estatus]
Carpeta=Lista
Clave=EmpresaCfgMovImp.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Modulo=42
Mov=107
Estatus=97
ReporteImpresora=176
ReportePantalla=188

[Lista.ListaEnCaptura]
(Inicio)=EmpresaCfgMovImp.Modulo
EmpresaCfgMovImp.Modulo=EmpresaCfgMovImp.Mov
EmpresaCfgMovImp.Mov=EmpresaCfgMovImp.Estatus
EmpresaCfgMovImp.Estatus=EmpresaCfgMovImp.ReporteImpresora
EmpresaCfgMovImp.ReporteImpresora=EmpresaCfgMovImp.ReportePantalla
EmpresaCfgMovImp.ReportePantalla=(Fin)
