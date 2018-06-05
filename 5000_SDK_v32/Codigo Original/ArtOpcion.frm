[Forma]
Clave=ArtOpcion
Nombre=Opciones del Artículo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=331
PosicionInicialArriba=351
PosicionInicialAltura=322
PosicionInicialAncho=618
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Articulo
PosicionInicialAlturaCliente=295

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtOpcion
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
OtroOrden=S
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaPermiteInsertar=S
FiltroGeneral=ArtOpcion.Articulo=<T>{Info.Articulo}<T>

[Lista.ArtOpcion.Opcion]
Carpeta=Lista
Clave=ArtOpcion.Opcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtOpcion.Requerido]
Carpeta=Lista
Clave=ArtOpcion.Requerido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtOpcion.ListaEspecifica]
Carpeta=Lista
Clave=ArtOpcion.ListaEspecifica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtOpcion.ValorOmision]
Carpeta=Lista
Clave=ArtOpcion.ValorOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtOpcion.Orden]
Carpeta=Lista
Clave=ArtOpcion.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Opcion=42
Descripcion=183
Requerido=56
ListaEspecifica=114
ValorOmision=62
Orden=36
Nombre=114
Asistente=90

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

[Lista.Opcion.Descripcion]
Carpeta=Lista
Clave=Opcion.Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ArtOpcion.Asistente]
Carpeta=Lista
Clave=ArtOpcion.Asistente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Opciones]
Nombre=Opciones
Boton=8
NombreDesplegar=&Opciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=OpcionInfo
Activo=S
Visible=S

[Acciones.Precios]
Nombre=Precios
Boton=64
NombreEnBoton=S
NombreDesplegar=&Precios Adicionales
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtOpcionPrecio
Activo=S
Visible=S

[Acciones.Especial]
Nombre=Especial
Boton=47
NombreEnBoton=S
NombreDesplegar=&Especial
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtOpcionD
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=ArtOpcion:ArtOpcion.ListaEspecifica=<T>(Especial)<T>
EjecucionCondicion=ConDatos(ArtOpcion:ArtOpcion.Opcion)
AntesExpresiones=Asigna(Info.Opcion, ArtOpcion:ArtOpcion.Opcion)<BR>Asigna(Info.Descripcion, ArtOpcion:Opcion.Descripcion)

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
ConfirmarAntes=S
EspacioPrevio=S
ActivoCondicion=no ArtOpcion:ArtOpcion.TieneMovimientos

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Eliminar
Eliminar=Opciones
Opciones=Precios
Precios=Especial
Especial=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtOpcion.Opcion
ArtOpcion.Opcion=Opcion.Descripcion
Opcion.Descripcion=ArtOpcion.Requerido
ArtOpcion.Requerido=ArtOpcion.ValorOmision
ArtOpcion.ValorOmision=ArtOpcion.ListaEspecifica
ArtOpcion.ListaEspecifica=ArtOpcion.Asistente
ArtOpcion.Asistente=ArtOpcion.Orden
ArtOpcion.Orden=(Fin)

[Lista.ListaOrden]
(Inicio)=ArtOpcion.Orden<TAB>(Acendente)
ArtOpcion.Orden<TAB>(Acendente)=ArtOpcion.Opcion<TAB>(Acendente)
ArtOpcion.Opcion<TAB>(Acendente)=(Fin)
