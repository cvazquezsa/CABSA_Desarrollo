
[Forma]
Clave=ArtZona
Icono=115
Modulos=(Todos)
Nombre=<T>Zonas del Artículo - <T> + Info.Articulo

ListaCarpetas=ArtZona
CarpetaPrincipal=ArtZona
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Descripcion
ListaAcciones=Aceptar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=249
PosicionInicialArriba=279
PosicionInicialAlturaCliente=273
PosicionInicialAncho=301
[ArtZona]
Estilo=Hoja
Clave=ArtZona
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtZona
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
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ArtZona.Articulo=<T>{Info.Articulo}<T>
[ArtZona.ArtZona.Zona]
Carpeta=ArtZona
Clave=ArtZona.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[ArtZona.ArtZona.Orden]
Carpeta=ArtZona
Clave=ArtZona.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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

[ArtZona.Columnas]
Zona=184
Orden=64



[ArtZona.ListaEnCaptura]
(Inicio)=ArtZona.Zona
ArtZona.Zona=ArtZona.Orden
ArtZona.Orden=(Fin)
