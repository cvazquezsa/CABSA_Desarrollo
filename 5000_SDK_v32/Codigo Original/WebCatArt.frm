
[Forma]
Clave=WebCatArt
Nombre=Categorías Artículos eCommerce
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=427
PosicionInicialArriba=145
PosicionInicialAltura=540
PosicionInicialAncho=745
PosicionSeccion1=58
Menus=S
PosicionInicialAlturaCliente=532

VentanaEstadoInicial=Normal
PosicionSec1=238
PosicionCol1=376
MenuPrincipal=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebCatArt
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
CarpetaVisible=S
Filtros=S
ListaEnCaptura=WebCatArt.Nombre
FiltroPredefinido=S
FiltroAncho=30
FiltroTodoNombre=Todos
FiltroNullNombre=(sin agrupar)
FiltroRespetar=S
FiltroTipo=Arbol
HojaMantenerSeleccion=S
FiltroTodo=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=ALTA<BR>BLOQUEADO<BR>BAJA
FiltroEstatusDefault=ALTA
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S

FiltroGrupo1=WebCatArt.ID
FiltroValida1=WebCatArt.ID
FiltroListasAplicaEn=WebCatArt.Rama
FiltroArbolClave=WebCatArt.ID
FiltroArbolValidar=WebCatArt.Nombre
FiltroArbolRama=WebCatArt.Rama
OtroOrden=S
ListaOrden=WebCatArt.Orden<TAB>(Acendente)
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
EnMenu=S

GuardarAntes=S
Carpeta=(Carpeta principal)
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=SQL(<T>SELECT dbo.fneWebValidarNombre(:tNombre)<T>,WebCatArt:WebCatArt.Nombre)
EjecucionMensaje= <T>El Campo Nombre Debe Tener Valor<T>
[Lista.Columnas]
CentroCostos=125
Categoria=157
Grupo1=125
Grupo2=136
Grupo3=125
Grupo=304
SubGrupo=304
Rama=97
Descripcion=243
EsAcumulativo=77
TieneMovimientos=93



Nombre=477
0=49
1=567
2=210
[Detalle]
Estilo=Ficha
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=WebCatArt
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=WebCatArt.Nombre<BR>WebCatArt.Titulo<BR>WebCatArt.Visible
CarpetaVisible=S
PermiteEditar=S
PestanaNombre=Categorias Articulos



PestanaOtroNombre=S
[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S

[Grupos.CentroCostos.Grupo]
Carpeta=Grupos
Clave=CentroCostos.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Grupos.CentroCostos.SubGrupo]
Carpeta=Grupos
Clave=CentroCostos.SubGrupo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
Menu=&Archivo
EnMenu=S
NombreEnBoton=S
Antes=S

AntesExpresiones=Asigna(Def.Rama, WebCatArt:WebCatArt.Rama)<BR>Si(Vacio(Def.Rama), Asigna(Def.Rama, FiltroActual))
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
Menu=&Archivo
EnMenu=S
NombreEnBoton=S
Carpeta=Lista


Activo=S
ConCondicion=S
EjecucionConError=S
Multiple=S
ListaAccionesMultiples=Registro Eliminar<BR>Expresion<BR>Actualizar Arbol
RefrescarDespues=S
EjecucionCondicion=Asigna(Info.Estado,SQL(<T>SELECT dbo.fneWebVerificarWebCatArt(:nID)<T>,WebCatArt:WebCatArt.ID))<BR>Vacio(Info.Estado)
EjecucionMensaje=Info.Estado
[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Actualizar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S


[Grupos.CentroCostos.NivelAcceso]
Carpeta=Grupos
Clave=CentroCostos.NivelAcceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro




[Lista.WebCatArt.Nombre]
Carpeta=Lista
Clave=WebCatArt.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.WebCatArt.Nombre]
Carpeta=Detalle
Clave=WebCatArt.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70
ColorFondo=Blanco
ColorFuente=Negro


[Detalle.WebCatArt.Titulo]
Carpeta=Detalle
Clave=WebCatArt.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70
ColorFondo=Blanco
ColorFuente=Negro



[Detalle.WebCatArt.Visible]
Carpeta=Detalle
Clave=WebCatArt.Visible
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco


Tamano=50
ColorFuente=Negro
[Descripción.WebCatArt.Descripcion]
Carpeta=Descripción
Clave=WebCatArt.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Descripción.Columnas]
Descripcion=304


[MetaKeyWords.WebCatArt.MetaKeyWords]
Carpeta=MetaKeyWords
Clave=WebCatArt.MetaKeyWords
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Metadesc.WebCatArt.Metadesc]
Carpeta=Metadesc
Clave=WebCatArt.Metadesc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Cache.WebCatArt.Cache]
Carpeta=Cache
Clave=WebCatArt.Cache
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Orden]
Nombre=Orden
Boton=50
NombreDesplegar=Cambiar &Orden
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S
Antes=S
DespuesGuardar=S


AntesExpresiones=Asigna(Temp.Num,WebCatArt:WebCatArt.Rama)<BR>FormaModal(<T>WebCatArtOrdenar<T>)
[WebCatArt_Art.Columnas]
IDWebCatArt=89
Nombre_1=304

[Acciones.Eliminar.Registro Eliminar]
Nombre=Registro Eliminar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

Carpeta=(Carpeta principal)
[Acciones.Eliminar.Actualizar Arbol]
Nombre=Actualizar Arbol
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S


[Acciones.Eliminar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=GuardarCambios
Activo=S
Visible=S



































































[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=Actualizar
Actualizar=Cerrar
Cerrar=Orden
Orden=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=&Otros
&Otros=(Fin)
