
[Forma]
Clave=AgenteArt
Icono=0
BarraHerramientas=S
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S

Nombre=Artículos del Agente
ListaAcciones=Aceptar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
PosicionInicialIzquierda=433
PosicionInicialArriba=208
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Comentarios=Lista(Info.Agente, Info.Articulo)
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

ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(AgenteArt:Art.Articulo, ListaBuscarDuplicados(CampoEnLista(AgenteArt:AgenteArt.Articulo)))<BR>Vacio(AgenteArt:Art.Articulo)
EjecucionMensaje=Comillas(AgenteArt:Art.Articulo)+<T> Duplicado<T>
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AgenteArt
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

CarpetaVisible=S
PermiteEditar=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=AgenteArt.Agente=<T>{Info.Agente}<T>
[Lista.AgenteArt.Articulo]
Carpeta=Lista
Clave=AgenteArt.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
Articulo=124
Descripcion1=184





Agente=64








[Lista.ListaEnCaptura]
(Inicio)=AgenteArt.Articulo
AgenteArt.Articulo=Art.Descripcion1
Art.Descripcion1=(Fin)
