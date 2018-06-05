[Forma]
Clave=ConsecutivoControl
Nombre=Control Consecutivos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=306
PosicionInicialArriba=337
PosicionInicialAlturaCliente=323
PosicionInicialAncho=478
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Tipo

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ConsecutivoControl
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
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=ConsecutivoControl.Tipo=<T>{Info.Tipo}<T>

[Lista.ConsecutivoControl.ConsecutivoD]
Carpeta=Lista
Clave=ConsecutivoControl.ConsecutivoD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConsecutivoControl.ConsecutivoA]
Carpeta=Lista
Clave=ConsecutivoControl.ConsecutivoA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConsecutivoControl.Referencia]
Carpeta=Lista
Clave=ConsecutivoControl.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConsecutivoControl.Estatus]
Carpeta=Lista
Clave=ConsecutivoControl.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
ConsecutivoD=91
ConsecutivoA=92
VigenciaD=94
VigenciaA=94
Referencia=160
Estatus=103

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

[Lista.ListaEnCaptura]
(Inicio)=ConsecutivoControl.ConsecutivoD
ConsecutivoControl.ConsecutivoD=ConsecutivoControl.ConsecutivoA
ConsecutivoControl.ConsecutivoA=ConsecutivoControl.Referencia
ConsecutivoControl.Referencia=ConsecutivoControl.Estatus
ConsecutivoControl.Estatus=(Fin)
