[Forma]
Clave=ArtVINAccesorioArt
Nombre=Componentes por Omisión
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=108
PosicionInicialArriba=182
PosicionInicialAlturaCliente=370
PosicionInicialAncho=807
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo, Info.Descripcion)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtVINAccesorioArt
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PermiteEditar=S
OtroOrden=S
ListaEnCaptura=(Lista)
FiltroGeneral=ArtVINAccesorioArt.Articulo=<T>{Info.Articulo}<T>

[Lista.Columnas]
Accesorio=124
Descripcion=266
PrecioDistribuidor=113
PrecioPublico=88
Modelo=43
Descripcion1=212
PrecioLista=103
CostoEstandar=120
Tipo=124
Precio2=89

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

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
ConfirmarAntes=S

[Lista.ArtVINAccesorioArt.Accesorio]
Carpeta=Lista
Clave=ArtVINAccesorioArt.Accesorio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Art.PrecioLista]
Carpeta=Lista
Clave=Art.PrecioLista
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Art.CostoEstandar]
Carpeta=Lista
Clave=Art.CostoEstandar
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ArtVINAccesorioArt.Tipo]
Carpeta=Lista
Clave=ArtVINAccesorioArt.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.VINTipoAccesorio]
Nombre=VINTipoAccesorio
Boton=91
NombreEnBoton=S
NombreDesplegar=&Tipos de Componentes
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VINTipoAccesorio
Activo=S
Visible=S

[Lista.Art.Precio2]
Carpeta=Lista
Clave=Art.Precio2
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Copiar]
Nombre=Copiar
Boton=65
NombreEnBoton=S
NombreDesplegar=&Copiar de Otro Artículo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
Expresion=Si(ConDatos(Info.ArticuloD), EjecutarSQL(<T>spCopiarArtVINAccesorio :tDel, :tAl<T>, Info.ArticuloD, Info.Articulo))<BR>Forma.ActualizarVista
EjecucionCondicion=Asigna(Info.ArticuloD, Nulo)<BR>Forma(<T>EspecificarArticuloD<T>)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=VINTipoAccesorio
VINTipoAccesorio=Copiar
Copiar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtVINAccesorioArt.Tipo
ArtVINAccesorioArt.Tipo=ArtVINAccesorioArt.Accesorio
ArtVINAccesorioArt.Accesorio=Art.Descripcion1
Art.Descripcion1=Art.CostoEstandar
Art.CostoEstandar=Art.PrecioLista
Art.PrecioLista=Art.Precio2
Art.Precio2=(Fin)
