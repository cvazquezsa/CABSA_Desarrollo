[Forma]
Clave=JornadaD
Nombre=<T>Rutina - <T>+Info.Jornada
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=525
PosicionInicialArriba=359
PosicionInicialAltura=306
PosicionInicialAncho=230
VentanaExclusiva=S
PosicionInicialAlturaCliente=279

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=JornadaD
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
FiltroGeneral=JornadaD.Jornada=<T>{Info.Jornada}<T>

[Lista.JornadaD.Dia]
Carpeta=Lista
Clave=JornadaD.Dia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.JornadaD.Entrada]
Carpeta=Lista
Clave=JornadaD.Entrada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.JornadaD.Salida]
Carpeta=Lista
Clave=JornadaD.Salida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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
Dia=41
Entrada=81
Salida=77

[Lista.ListaEnCaptura]
(Inicio)=JornadaD.Dia
JornadaD.Dia=JornadaD.Entrada
JornadaD.Entrada=JornadaD.Salida
JornadaD.Salida=(Fin)
