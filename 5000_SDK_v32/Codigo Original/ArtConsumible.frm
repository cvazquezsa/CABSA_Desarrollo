[Forma]
Clave=ArtConsumible
Nombre=Consumibles del Artículo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Articulo, Info.Descripcion)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=258
PosicionInicialArriba=238
PosicionInicialAltura=291
PosicionInicialAncho=508
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtConsumible
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
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
FiltroGeneral=ArtConsumible.Articulo=<T>{Info.Articulo}<T>

[Lista.ArtConsumible.Consumible]
Carpeta=Lista
Clave=ArtConsumible.Consumible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

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
Consumible=128
Descripcion1=284
Cantidad=66

[Lista.ArtConsumible.Cantidad]
Carpeta=Lista
Clave=ArtConsumible.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100

[Lista.ListaEnCaptura]
(Inicio)=ArtConsumible.Consumible
ArtConsumible.Consumible=Art.Descripcion1
Art.Descripcion1=ArtConsumible.Cantidad
ArtConsumible.Cantidad=(Fin)
