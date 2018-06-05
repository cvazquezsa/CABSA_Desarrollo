[Forma]
Clave=EjercicioEspecial
Nombre=<T>Ejercicios Especiales - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=327
PosicionInicialArriba=172
PosicionInicialAltura=423
PosicionInicialAncho=370
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Modulo.Nombre(Info.Modulo)

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
Vista=EjercicioEspecial
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
OtroOrden=S
ListaOrden=EjercicioEspecial.FechaD<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroGeneral=EjercicioEspecial.Empresa=<T>{Info.Empresa}<T> AND<BR>EjercicioEspecial.Modulo=<T>{Info.Modulo}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.EjercicioEspecial.FechaD]
Carpeta=Lista
Clave=EjercicioEspecial.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EjercicioEspecial.FechaA]
Carpeta=Lista
Clave=EjercicioEspecial.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EjercicioEspecial.Periodo]
Carpeta=Lista
Clave=EjercicioEspecial.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EjercicioEspecial.Ejercicio]
Carpeta=Lista
Clave=EjercicioEspecial.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
Modulo=61
FechaD=105
FechaA=109
Periodo=63
Ejercicio=61

[Lista.ListaEnCaptura]
(Inicio)=EjercicioEspecial.FechaD
EjercicioEspecial.FechaD=EjercicioEspecial.FechaA
EjercicioEspecial.FechaA=EjercicioEspecial.Periodo
EjercicioEspecial.Periodo=EjercicioEspecial.Ejercicio
EjercicioEspecial.Ejercicio=(Fin)
