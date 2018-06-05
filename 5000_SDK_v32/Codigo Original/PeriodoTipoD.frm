[Forma]
Clave=PeriodoTipoD
Nombre=Info.PeriodoTipo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=359
PosicionInicialArriba=234
PosicionInicialAltura=300
PosicionInicialAncho=305
Comentarios=NumEnTexto(Info.Ejercicio)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PeriodoTipoD
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
ListaOrden=PeriodoTipoD.Periodo<TAB>(Acendente)
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=PeriodoTipoD.PeriodoTipo=<T>{Info.PeriodoTipo}<T> AND<BR>PeriodoTipoD.Ejercicio={Info.Ejercicio}

[Lista.PeriodoTipoD.Periodo]
Carpeta=Lista
Clave=PeriodoTipoD.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PeriodoTipoD.FechaInicio]
Carpeta=Lista
Clave=PeriodoTipoD.FechaInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PeriodoTipoD.FechaFinal]
Carpeta=Lista
Clave=PeriodoTipoD.FechaFinal
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
Ejercicio=81
Periodo=68
FechaInicio=104
FechaFinal=103

[Acciones.Ejercicio]
Nombre=Ejercicio
Boton=53
NombreEnBoton=S
NombreDesplegar=&Ejercicio
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
AntesExpresiones=Forma(<T>EspecificarEjercicio<T>)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Ejercicio
Ejercicio=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=PeriodoTipoD.Periodo
PeriodoTipoD.Periodo=PeriodoTipoD.FechaInicio
PeriodoTipoD.FechaInicio=PeriodoTipoD.FechaFinal
PeriodoTipoD.FechaFinal=(Fin)
