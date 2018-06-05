
[Forma]
Clave=WebPaginaArticuloLista
Icono=0
CarpetaPrincipal=Ficha
Modulos=(Todos)
Nombre=Parámetros de Lista de Articulos

ListaCarpetas=(Lista)
BarraHerramientas=S
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=562
PosicionInicialAncho=1053
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=113
PosicionInicialArriba=102



PosicionCol1=516
VentanaBloquearAjuste=S
AccionesIzq=S
PosicionSec1=248
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S


[WebPaginaArticuloLista.Columnas]
Titulo=198
sp=199
URL_Imagenes=222
TituloLink=64
Imagen=304
Texto=304
Valor=304
ID=304
TextoLink=64
Borde=64
AltoImagen=64
AnchoImagen=70
Etiqueta=304
EtiquetaURL=304
RID=64
TituloColorTexto=304
TituloTamaño=68
TituloColorFondo=304
TituloNegrita=65
Ubicacion=304





[FichaArticuloLista.ListaEnCaptura]
(Inicio)=WebPaginaArticuloLista.Titulo
WebPaginaArticuloLista.Titulo=WebPaginaArticuloLista.sp
WebPaginaArticuloLista.sp=WebPaginaArticuloLista.URL_Imagenes
WebPaginaArticuloLista.URL_Imagenes=WebPaginaArticuloLista.TituloLink
WebPaginaArticuloLista.TituloLink=WebPaginaArticuloLista.Imagen
WebPaginaArticuloLista.Imagen=WebPaginaArticuloLista.Texto
WebPaginaArticuloLista.Texto=WebPaginaArticuloLista.Valor
WebPaginaArticuloLista.Valor=WebPaginaArticuloLista.ID
WebPaginaArticuloLista.ID=WebPaginaArticuloLista.RID
WebPaginaArticuloLista.RID=WebPaginaArticuloLista.TextoLink
WebPaginaArticuloLista.TextoLink=WebPaginaArticuloLista.Borde
WebPaginaArticuloLista.Borde=WebPaginaArticuloLista.AltoImagen
WebPaginaArticuloLista.AltoImagen=WebPaginaArticuloLista.AnchoImagen
WebPaginaArticuloLista.AnchoImagen=WebPaginaArticuloLista.Etiqueta
WebPaginaArticuloLista.Etiqueta=WebPaginaArticuloLista.EtiquetaURL
WebPaginaArticuloLista.EtiquetaURL=WebPaginaArticuloLista.TituloTamaño
WebPaginaArticuloLista.TituloTamaño=WebPaginaArticuloLista.TituloColorTexto
WebPaginaArticuloLista.TituloColorTexto=WebPaginaArticuloLista.TituloColorFondo
WebPaginaArticuloLista.TituloColorFondo=WebPaginaArticuloLista.TituloNegrita
WebPaginaArticuloLista.TituloNegrita=WebPaginaArticuloLista.Ubicacion
WebPaginaArticuloLista.Ubicacion=(Fin)





















[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=controles Captura
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



[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S









[WebPaginaArticuloLista.ListaEnCaptura]
(Inicio)=WebPaginaArticuloLista.Titulo
WebPaginaArticuloLista.Titulo=WebPaginaArticuloLista.sp
WebPaginaArticuloLista.sp=(Fin)







[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebPaginaArticuloLista
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Normal
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ListaOrden=WebPaginaArticuloLista.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroEstilo=Folder (1 línea)
FiltroRespetar=S
FiltroTipo=Automático
CarpetaVisible=S
FiltroTodo=S

HojaAjustarColumnas=S
FiltroGeneral=WebPaginaArticuloLista.Pagina=<T>{Info.Pagina}<T>
[Lista.WebPaginaArticuloLista.Titulo]
Carpeta=Lista
Clave=WebPaginaArticuloLista.Titulo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=200
ColorFondo=Blanco
ColorFuente=Negro


[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=WebPaginaArticuloLista
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Ficha.WebPaginaArticuloLista.Titulo]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

EspacioPrevio=S
[Ficha.WebPaginaArticuloLista.sp]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.sp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

EspacioPrevio=S
[Ficha.WebPaginaArticuloLista.URL_Imagenes]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.URL_Imagenes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebPaginaArticuloLista.TituloLink]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.TituloLink
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

Pegado=S
[Ficha.WebPaginaArticuloLista.Imagen]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.Imagen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebPaginaArticuloLista.Texto]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.Texto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebPaginaArticuloLista.Valor]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebPaginaArticuloLista.ID]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.ID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro


[Ficha.WebPaginaArticuloLista.TextoLink]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.TextoLink
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

Pegado=N
[Ficha.WebPaginaArticuloLista.Borde]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.Borde
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebPaginaArticuloLista.AltoImagen]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.AltoImagen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

EspacioPrevio=S
[Ficha.WebPaginaArticuloLista.AnchoImagen]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.AnchoImagen
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

LineaNueva=S
[Ficha.WebPaginaArticuloLista.Etiqueta]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.Etiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

EspacioPrevio=S
[Ficha.WebPaginaArticuloLista.EtiquetaURL]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.EtiquetaURL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebPaginaArticuloLista.TituloTamaño]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.TituloTamaño
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebPaginaArticuloLista.TituloColorTexto]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.TituloColorTexto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebPaginaArticuloLista.TituloColorFondo]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.TituloColorFondo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebPaginaArticuloLista.TituloNegrita]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.TituloNegrita
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebPaginaArticuloLista.Ubicacion]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.Ubicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro





[Lista.Columnas]
Titulo=411
sp=304
























Color=194
Hexadecimal=66







0=185
1=237
2=-2
Orden=64
[Acciones.Cerrar]
Nombre=Cerrar
Boton=36
NombreEnBoton=S
NombreDesplegar=Cerrar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


























[Ficha.WebPaginaArticuloLista.Posicion]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
















































[Ficha.WebPaginaArticuloLista.TituloURL]
Carpeta=Ficha
Clave=WebPaginaArticuloLista.TituloURL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro




























[Ficha.WebPaginaDetalle.Nombre]
Carpeta=Ficha
Clave=WebPaginaDetalle.Nombre
Editar=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=$00EFEFEF
ColorFuente=Negro

Pegado=S








[Ficha.WebPaginaDestino.Nombre]
Carpeta=Ficha
Clave=WebPaginaDestino.Nombre
Editar=N
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=$00E9E9E9
ColorFuente=Negro


Pegado=S












[Lista.WebPaginaArticuloLista.Orden]
Carpeta=Lista
Clave=WebPaginaArticuloLista.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

















[Lista.ListaEnCaptura]
(Inicio)=WebPaginaArticuloLista.Titulo
WebPaginaArticuloLista.Titulo=WebPaginaArticuloLista.Orden
WebPaginaArticuloLista.Orden=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=WebPaginaArticuloLista.Ubicacion
WebPaginaArticuloLista.Ubicacion=WebPaginaArticuloLista.Posicion
WebPaginaArticuloLista.Posicion=WebPaginaArticuloLista.Borde
WebPaginaArticuloLista.Borde=WebPaginaArticuloLista.URL_Imagenes
WebPaginaArticuloLista.URL_Imagenes=WebPaginaArticuloLista.Titulo
WebPaginaArticuloLista.Titulo=WebPaginaArticuloLista.TituloColorTexto
WebPaginaArticuloLista.TituloColorTexto=WebPaginaArticuloLista.TituloColorFondo
WebPaginaArticuloLista.TituloColorFondo=WebPaginaArticuloLista.TituloTamaño
WebPaginaArticuloLista.TituloTamaño=WebPaginaArticuloLista.TituloNegrita
WebPaginaArticuloLista.TituloNegrita=WebPaginaArticuloLista.TituloLink
WebPaginaArticuloLista.TituloLink=WebPaginaArticuloLista.TituloURL
WebPaginaArticuloLista.TituloURL=WebPaginaDetalle.Nombre
WebPaginaDetalle.Nombre=WebPaginaArticuloLista.sp
WebPaginaArticuloLista.sp=WebPaginaArticuloLista.Imagen
WebPaginaArticuloLista.Imagen=WebPaginaArticuloLista.Texto
WebPaginaArticuloLista.Texto=WebPaginaArticuloLista.Valor
WebPaginaArticuloLista.Valor=WebPaginaArticuloLista.ID
WebPaginaArticuloLista.ID=WebPaginaArticuloLista.AltoImagen
WebPaginaArticuloLista.AltoImagen=WebPaginaArticuloLista.AnchoImagen
WebPaginaArticuloLista.AnchoImagen=WebPaginaArticuloLista.Etiqueta
WebPaginaArticuloLista.Etiqueta=WebPaginaArticuloLista.TextoLink
WebPaginaArticuloLista.TextoLink=WebPaginaArticuloLista.EtiquetaURL
WebPaginaArticuloLista.EtiquetaURL=WebPaginaDestino.Nombre
WebPaginaDestino.Nombre=(Fin)















































[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=Cerrar
Cerrar=(Fin)
