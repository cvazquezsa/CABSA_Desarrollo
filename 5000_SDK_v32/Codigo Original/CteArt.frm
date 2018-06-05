[Forma]
Clave=CteArt
Nombre=Articulos del Cliente
Icono=0
Modulos=(Todos)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=110
PosicionInicialArriba=154
PosicionInicialAlturaCliente=426
PosicionInicialAncho=803
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Cliente, Info.Nombre)
ListaCarpetas=Lista

[Lista.ArtCte.Articulo]
Carpeta=Lista
Clave=ArtCte.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCte.SubCuenta]
Carpeta=Lista
Clave=ArtCte.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=124
SubCuenta=124
UltimoPrecio=85
UltimaVenta=94
Descripcion1=184
OpcionDesc=278
Estatus=94
Presentacion=103
Tamano=52
Cantidad=49

Codigo=159
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

[Acciones.CambiarVista]
Nombre=CambiarVista
Boton=0
NombreDesplegar=Cambiar Vista Hoja (Normal-Detalle)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
Activo=S
Visible=S

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtCte
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
ValidarCampos=S
ListaCamposAValidar=OpcionDesc

FiltroGeneral=ArtCte.Cliente=<T>{Info.Cliente}<T>
[Lista.ArtCte.Estatus]
Carpeta=Lista
Clave=ArtCte.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCte.Presentacion]
Carpeta=Lista
Clave=ArtCte.Presentacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCte.Tamano]
Carpeta=Lista
Clave=ArtCte.Tamano
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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

[Acciones.Comentarios]
Nombre=Comentarios
Boton=47
NombreEnBoton=S
NombreDesplegar=Co&mentarios
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteArtComentarios
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
ConCondicion=S
EjecucionCondicion=ConDatos(ArtCte:ArtCte.Articulo)
AntesExpresiones=Asigna(Info.Articulo, ArtCte:ArtCte.Articulo)<BR>Asigna(Info.SubCuenta, ArtCte:ArtCte.SubCuenta)

[Acciones.Competencia]
Nombre=Competencia
Boton=47
NombreEnBoton=S
NombreDesplegar=&Competencia
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteArtCompetencia
Activo=S
Visible=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(ArtCte:ArtCte.Articulo)
AntesExpresiones=Asigna(Info.Articulo, ArtCte:ArtCte.Articulo)<BR>Asigna(Info.SubCuenta, ArtCte:ArtCte.SubCuenta)

[Lista.ArtCte.Cantidad]
Carpeta=Lista
Clave=ArtCte.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=ArtCte.Articulo
ArtCte.Articulo=ArtCte.SubCuenta
ArtCte.SubCuenta=Art.Descripcion1
Art.Descripcion1=ArtCte.Presentacion
ArtCte.Presentacion=ArtCte.Tamano
ArtCte.Tamano=ArtCte.Cantidad
ArtCte.Cantidad=ArtCte.Codigo
ArtCte.Codigo=ArtCte.Estatus
ArtCte.Estatus=(Fin)

[Lista.ArtCte.Codigo]
Carpeta=Lista
Clave=ArtCte.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CambiarVista
CambiarVista=Comentarios
Comentarios=Competencia
Competencia=(Fin)
