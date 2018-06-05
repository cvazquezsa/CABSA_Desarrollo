
[Forma]
Clave=ProyClavePresupuestalReglaVig
Icono=0
Modulos=(Todos)
Nombre=Vigencia

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialAlturaCliente=273
PosicionInicialAncho=313
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=483
PosicionInicialArriba=250
ListaAcciones=Guardar
Comentarios=Lista(Info.Descripcion)
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyClavePresupuestalReglaVig
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

FiltroGeneral=ProyClavePresupuestalReglaVig.ID = {Info.ID}
[Lista.ProyClavePresupuestalReglaVig.FechaA]
Carpeta=Lista
Clave=ProyClavePresupuestalReglaVig.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ProyClavePresupuestalReglaVig.MascaraFecha]
Carpeta=Lista
Clave=ProyClavePresupuestalReglaVig.MascaraFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Lista.Columnas]
FechaA=94
MascaraFecha=94
RID=64

FechaD=94

[Lista.ProyClavePresupuestalReglaVig.FechaD]
Carpeta=Lista
Clave=ProyClavePresupuestalReglaVig.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[Lista.ListaEnCaptura]
(Inicio)=ProyClavePresupuestalReglaVig.FechaD
ProyClavePresupuestalReglaVig.FechaD=ProyClavePresupuestalReglaVig.FechaA
ProyClavePresupuestalReglaVig.FechaA=ProyClavePresupuestalReglaVig.MascaraFecha
ProyClavePresupuestalReglaVig.MascaraFecha=(Fin)
