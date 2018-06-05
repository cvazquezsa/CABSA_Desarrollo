[Forma]
Clave=ArtVINAccesorio
Nombre=Componentes por Omisión
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=317
PosicionInicialArriba=310
PosicionInicialAlturaCliente=370
PosicionInicialAncho=646
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
Vista=ArtVINAccesorio
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
FiltroTipo=Automático
CarpetaVisible=S
PermiteEditar=S
OtroOrden=S
ListaOrden=(Lista)
FiltroAutoCampo=ArtVINAccesorio.Modelo
FiltroAutoValidar=ArtVINAccesorio.Modelo
FiltroAutoOrden=ArtVINAccesorio.Modelo
FiltroGeneral=ArtVINAccesorio.Articulo=<T>{Info.Articulo}<T>

[Lista.ArtVINAccesorio.Accesorio]
Carpeta=Lista
Clave=ArtVINAccesorio.Accesorio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtVINAccesorio.Descripcion]
Carpeta=Lista
Clave=ArtVINAccesorio.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtVINAccesorio.PrecioDistribuidor]
Carpeta=Lista
Clave=ArtVINAccesorio.PrecioDistribuidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtVINAccesorio.PrecioPublico]
Carpeta=Lista
Clave=ArtVINAccesorio.PrecioPublico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Accesorio=95
Descripcion=266
PrecioDistribuidor=113
PrecioPublico=88
Modelo=43

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

[Lista.ArtVINAccesorio.Modelo]
Carpeta=Lista
Clave=ArtVINAccesorio.Modelo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=4
ColorFondo=Blanco
ColorFuente=Negro

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

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtVINAccesorio.Modelo
ArtVINAccesorio.Modelo=ArtVINAccesorio.Accesorio
ArtVINAccesorio.Accesorio=ArtVINAccesorio.Descripcion
ArtVINAccesorio.Descripcion=ArtVINAccesorio.PrecioDistribuidor
ArtVINAccesorio.PrecioDistribuidor=ArtVINAccesorio.PrecioPublico
ArtVINAccesorio.PrecioPublico=(Fin)

[Lista.ListaOrden]
(Inicio)=ArtVINAccesorio.Modelo<TAB>(Acendente)
ArtVINAccesorio.Modelo<TAB>(Acendente)=ArtVINAccesorio.Accesorio<TAB>(Acendente)
ArtVINAccesorio.Accesorio<TAB>(Acendente)=(Fin)
