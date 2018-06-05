[Forma]
Clave=VerMovTiempo
Nombre=e(<T>Tiempos<T>)+<T> - <T>+Info.Mov+<T> <T>+Info.MovID
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=164
PosicionInicialArriba=191
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
Vista=VerMovTiempo
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
FiltroGeneral=Modulo=<T>{Info.Modulo}<T> AND<BR>ID={Info.ID}

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

[Lista.VerMovTiempo.Situacion]
Carpeta=Lista
Clave=VerMovTiempo.Situacion
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

[Lista.VerMovTiempo.Usuario]
Carpeta=Lista
Clave=VerMovTiempo.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=VerMovTiempo.Usuario
VerMovTiempo.Usuario=EstatusNombre
EstatusNombre=VerMovTiempo.Situacion
VerMovTiempo.Situacion=Tiempo
Tiempo=TiempoTotal
TiempoTotal=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=VerMovTiempo.FechaComenzo
VerMovTiempo.FechaComenzo=VerMovTiempo.FechaTermino
VerMovTiempo.FechaTermino=(Fin)
