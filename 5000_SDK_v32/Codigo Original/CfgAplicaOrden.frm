[Forma]
Clave=CfgAplicaOrden
Nombre=Orden Aplicación Sugerida
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=465
PosicionInicialArriba=327
PosicionInicialAltura=300
PosicionInicialAncho=349
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialAlturaCliente=335
Comentarios=Info.Modulo

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgAplicaOrden
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=CfgAplicaOrden.Orden<TAB>(Acendente)
HojaTitulos=S
HojaMostrarColumnas=S
FiltroGeneral=CfgAplicaOrden.Modulo=<T>{Info.Modulo}<T>

[Lista.CfgAplicaOrden.Mov]
Carpeta=Lista
Clave=CfgAplicaOrden.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Mov=272
Orden=47

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

[Lista.CfgAplicaOrden.Orden]
Carpeta=Lista
Clave=CfgAplicaOrden.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=CfgAplicaOrden.Mov
CfgAplicaOrden.Mov=CfgAplicaOrden.Orden
CfgAplicaOrden.Orden=(Fin)
