[Forma]
Clave=VerJornadaTiempo
Nombre=Jornada Laboral
Icono=5
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAltura=364
PosicionInicialAncho=594
PosicionInicialIzquierda=395
PosicionInicialArriba=326
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
Comentarios=Info.Jornada
PosicionInicialAlturaCliente=337

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerJornadaTiempo
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroGrupo1=VerJornadaTiempo.Ano
FiltroValida1=VerJornadaTiempo.Ano
FiltroGrupo2=VerJornadaTiempo.Semana
FiltroValida2=VerJornadaTiempo.Semana
FiltroAncho=17
FiltroTodoNombre=Todos los Años
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
FiltroTodo=S
FiltroTodoFinal=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
OtroOrden=S
ListaOrden=(Lista)
FiltroEnOrden=S
FiltroGeneral=VerJornadaTiempo.Jornada=<T>{Info.Jornada}<T>

[Lista.DiaSemana]
Carpeta=Lista
Clave=DiaSemana
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
DiaSemana=67
Dia=42
Entrada=121
Salida=120
HoraEntrada=72
HoraSalida=65
Fecha=79
0=82
1=63
Semana=48

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.VerJornadaTiempo.Semana]
Carpeta=Lista
Clave=VerJornadaTiempo.Semana
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Fecha]
Carpeta=Lista
Clave=Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerJornadaTiempo.Entrada]
Carpeta=Lista
Clave=VerJornadaTiempo.Entrada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerJornadaTiempo.Salida]
Carpeta=Lista
Clave=VerJornadaTiempo.Salida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=Fecha
Fecha=VerJornadaTiempo.Semana
VerJornadaTiempo.Semana=DiaSemana
DiaSemana=VerJornadaTiempo.Entrada
VerJornadaTiempo.Entrada=VerJornadaTiempo.Salida
VerJornadaTiempo.Salida=(Fin)

[Lista.ListaOrden]
(Inicio)=VerJornadaTiempo.Ano<TAB>(Acendente)
VerJornadaTiempo.Ano<TAB>(Acendente)=VerJornadaTiempo.Semana<TAB>(Acendente)
VerJornadaTiempo.Semana<TAB>(Acendente)=(Fin)
