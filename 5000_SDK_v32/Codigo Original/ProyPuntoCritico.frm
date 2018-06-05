
[Forma]
Clave=ProyPuntoCritico
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Puntos Críticos
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=266
PosicionInicialArriba=230
PosicionInicialAlturaCliente=273
PosicionInicialAncho=492
Comentarios=Info.Proyecto
ListaAcciones=Aceptar
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyPuntoCritico
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
PermiteEditar=S

FiltroGeneral=ProyPuntoCritico.Proyecto = <T>{Info.Proyecto}<T>
[Lista.ProyPuntoCritico.PuntoCritico]
Carpeta=Lista
Clave=ProyPuntoCritico.PuntoCritico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyPuntoCritico.Descripcion]
Carpeta=Lista
Clave=ProyPuntoCritico.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyPuntoCritico.Estado]
Carpeta=Lista
Clave=ProyPuntoCritico.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyPuntoCritico.Avance]
Carpeta=Lista
Clave=ProyPuntoCritico.Avance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
PuntoCritico=88
Descripcion=198
Estado=93
Avance=81

[Lista.ListaEnCaptura]
(Inicio)=ProyPuntoCritico.PuntoCritico
ProyPuntoCritico.PuntoCritico=ProyPuntoCritico.Descripcion
ProyPuntoCritico.Descripcion=ProyPuntoCritico.Estado
ProyPuntoCritico.Estado=ProyPuntoCritico.Avance
ProyPuntoCritico.Avance=(Fin)

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
