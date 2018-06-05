[Forma]
Clave=EmpresaConceptoValidar
Nombre=<T>Conceptos del Movimiento - <T>+Info.Mov
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=354
PosicionInicialArriba=213
PosicionInicialAltura=334
PosicionInicialAncho=316
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialAlturaCliente=307

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaConceptoValidar
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
FiltroGeneral=EmpresaConceptoValidar.Empresa=<T>{Info.Empresa}<T> AND <BR>EmpresaConceptoValidar.Modulo=<T>{Info.Modulo}<T> AND<BR>EmpresaConceptoValidar.Mov=<T>{Info.Mov}<T>

[Lista.EmpresaConceptoValidar.Concepto]
Carpeta=Lista
Clave=EmpresaConceptoValidar.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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
Concepto=256
CR=30

[Lista.EmpresaConceptoValidar.CR]
Carpeta=Lista
Clave=EmpresaConceptoValidar.CR
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=EmpresaConceptoValidar.Concepto
EmpresaConceptoValidar.Concepto=EmpresaConceptoValidar.CR
EmpresaConceptoValidar.CR=(Fin)
