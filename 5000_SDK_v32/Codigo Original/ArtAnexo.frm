[Forma]
Clave=ArtAnexo
Icono=0
Modulos=(Todos)
Nombre=Anexos al Facturar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo, Info.Nombre)
PosicionInicialIzquierda=212
PosicionInicialArriba=321
PosicionInicialAlturaArticulo=361
PosicionInicialAncho=855
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=347

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtAnexo
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
FiltroGeneral=ArtAnexo.Articulo=<T>{Info.Articulo}<T>

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
Usuario=101
Nombre=326
Anexo=143
Cantidad=49
Unidad=68
Descripcion1=194
SubCuenta=124
TipoPrecio=83
Precio=116
TipoCantidad=76
UnidadEspecifica=89

[Lista.ArtAnexo.Anexo]
Carpeta=Lista
Clave=ArtAnexo.Anexo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtAnexo.Cantidad]
Carpeta=Lista
Clave=ArtAnexo.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtAnexo.Unidad]
Carpeta=Lista
Clave=ArtAnexo.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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

[Lista.ArtAnexo.SubCuenta]
Carpeta=Lista
Clave=ArtAnexo.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

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

[Lista.ArtAnexo.TipoPrecio]
Carpeta=Lista
Clave=ArtAnexo.TipoPrecio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtAnexo.Precio]
Carpeta=Lista
Clave=ArtAnexo.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtAnexo.TipoCantidad]
Carpeta=Lista
Clave=ArtAnexo.TipoCantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtAnexo.UnidadEspecifica]
Carpeta=Lista
Clave=ArtAnexo.UnidadEspecifica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CambiarVista
CambiarVista=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtAnexo.Anexo
ArtAnexo.Anexo=Art.Descripcion1
Art.Descripcion1=ArtAnexo.SubCuenta
ArtAnexo.SubCuenta=ArtAnexo.UnidadEspecifica
ArtAnexo.UnidadEspecifica=ArtAnexo.TipoCantidad
ArtAnexo.TipoCantidad=ArtAnexo.Cantidad
ArtAnexo.Cantidad=ArtAnexo.Unidad
ArtAnexo.Unidad=ArtAnexo.TipoPrecio
ArtAnexo.TipoPrecio=ArtAnexo.Precio
ArtAnexo.Precio=(Fin)
