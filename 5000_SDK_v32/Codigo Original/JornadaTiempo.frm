[Forma]
Clave=JornadaTiempo
Nombre=Info.Jornada
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=486
PosicionInicialArriba=294
PosicionInicialAltura=435
PosicionInicialAncho=307
Comentarios=NumEnTexto(Info.Ejercicio)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=408
ExpresionesAlMostrar=Asigna(Info.Ejercicio, Año(Hoy))

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=JornadaTiempo
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
ListaOrden=JornadaTiempo.Entrada<TAB>(Acendente)
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=JornadaTiempo.Jornada=<T>{Info.Jornada}<T> AND DATEPART(year, JornadaTiempo.Entrada) = {Info.Ejercicio}

[Lista.JornadaTiempo.Entrada]
Carpeta=Lista
Clave=JornadaTiempo.Entrada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.JornadaTiempo.Salida]
Carpeta=Lista
Clave=JornadaTiempo.Salida
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
Entrada=148
Salida=129

[Acciones.Ejercicio]
Nombre=Ejercicio
Boton=53
NombreDesplegar=<T>&Ejercicio<T>
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
Visible=S
NombreEnBoton=S
EjecucionCondicion=Forma(<T>EspecificarEjercicio<T>)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Ejercicio
Ejercicio=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=JornadaTiempo.Entrada
JornadaTiempo.Entrada=JornadaTiempo.Salida
JornadaTiempo.Salida=(Fin)
