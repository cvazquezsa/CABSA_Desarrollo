[Forma]
Clave=VerCtaTiempo
Nombre=e(<T>Tiempos<T>)+<T> - <T>+Info.Cuenta
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=292
PosicionInicialArriba=319
PosicionInicialAltura=379
PosicionInicialAncho=695
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialAlturaCliente=352

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerCtaTiempo
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
ValidarCampos=S
ListaCamposAValidar=(Lista)
FiltroGeneral=Rama=<T>{Info.Rama}<T> AND<BR>Cuenta=<T>{Info.Cuenta}<T>

[Lista.Columnas]
0=120
1=200
Estatus=94
Situacion=236
FechaInicio=133
FechaFinal=130
Tiempo=139
EstatusNombre=91
TiempoTranscurrido=133
TiempoAcumulado=132
TiempoTotal=132
Usuario=64

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

[Lista.EstatusNombre]
Carpeta=Lista
Clave=EstatusNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCtaTiempo.Situacion]
Carpeta=Lista
Clave=VerCtaTiempo.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Tiempo]
Carpeta=Lista
Clave=Tiempo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TiempoTotal]
Carpeta=Lista
Clave=TiempoTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCtaTiempo.Usuario]
Carpeta=Lista
Clave=VerCtaTiempo.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=VerCtaTiempo.Usuario
VerCtaTiempo.Usuario=EstatusNombre
EstatusNombre=VerCtaTiempo.Situacion
VerCtaTiempo.Situacion=Tiempo
Tiempo=TiempoTotal
TiempoTotal=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=VerCtaTiempo.FechaComenzo
VerCtaTiempo.FechaComenzo=VerCtaTiempo.FechaTermino
VerCtaTiempo.FechaTermino=(Fin)
