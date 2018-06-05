[Forma]
Clave=WebArt
Icono=0
CarpetaPrincipal=Articulo
Modulos=(Todos)
Nombre=Artículos eCommerce

ListaCarpetas=(Lista)
PosicionInicialAlturaCliente=720
PosicionInicialAncho=997
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=243
PosicionInicialArriba=0
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
DialogoAbrir=S
PosicionSec1=321
Menus=S
ExpresionesAlMostrar=Asigna(Info.Copiar,Falso)
PosicionSeccion1=50
MenuPrincipal=(Lista)
[Articulo]
Estilo=Ficha
Clave=Articulo
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArt
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)

PestanaNombre=Detalle
GuardarPorRegistro=S
[Articulo.WebArt.Nombre]
Carpeta=Articulo
Clave=WebArt.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=76
ColorFondo=Blanco



EspacioPrevio=S
[Articulo.WebArt.SKU]
Carpeta=Articulo
Clave=WebArt.SKU
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Articulo.WebArt.Articulo]
Carpeta=Articulo
Clave=WebArt.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=N

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=GuardarCambios
ConCondicion=S
EjecucionCondicion=SQL(<T>SELECT dbo.fneWebValidarNombre(:tNombre)<T>,WebArt:WebArt.Nombre)
EjecucionMensaje= <T>El Campo Nombre Debe Tener Valor<T>
EjecucionConError=S
[Lista.Columnas]
Articulo=131
Descripcion1=184

0=91
1=267
Nombre=304
Codigo=149
Cuenta=225
Unidad=86
Cantidad=64
SubCuenta=124
SerieLote=124
[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=WebArtA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>ID<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por grupos)
CarpetaVisible=S

BusquedaRapidaControles=S
FiltroArbolClave=WebArt.Categoria1
FiltroArbolValidar=WebCatArt.Nombre
FiltroTodo=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroAutoCampo=WebArt.Categoria1
FiltroAutoValidar=WebCatArt.Nombre
FiltroAutoOrden=WebArt.Orden
BusquedaRapida=S
BusquedaEnLinea=S
FiltroGrupo1=WebArt.Categoria1
FiltroValida1=WebCatArt.Nombre
OtroOrden=S
ListaOrden=WebArt.Orden<TAB>(Acendente)
RefrescarAlEntrar=S
PestanaOtroNombre=S
PestanaNombre=Artículos eCommerce
IconosConPaginas=S
MenuLocal=S
ListaAcciones=Campos
IconosNombre=WebArtA:WebArt.ID
[(Carpeta Abrir).WebArt.Articulo]
Carpeta=(Carpeta Abrir)
Clave=WebArt.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Descripcion.WebArt.DescripcionHTML]
Carpeta=Descripcion
Clave=WebArt.DescripcionHTML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).Columnas]
0=56
1=146

2=195
3=-2
4=-2
[Acciones.Documento Abrir]
Nombre=Documento Abrir
Boton=2
NombreDesplegar=&Abrir
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S



Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
EnMenu=S
[Acciones.Documento Nuevo]
Nombre=Documento Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S

Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
EnMenu=S
[Acciones.Documento Eliminar]
Nombre=Documento Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Activo=S
Visible=S


Menu=&Archivo
EnMenu=S
[Acciones.Orden]
Nombre=Orden
Boton=50
NombreDesplegar=Cambiar &Orden
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
DespuesGuardar=S
Visible=S

EspacioPrevio=S
Menu=&Edición
EnMenu=S
AntesExpresiones=FormaModal(<T>WebArtOrdenar<T>)
[Acciones.Categorias]
Nombre=Categorias
Boton=55
NombreDesplegar=&Categorías
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Antes=S
DespuesGuardar=S
Visible=S

NombreEnBoton=S
Expresion=FormaModal(<T>WebCatArt_Art<T>)<BR>ActualizarForma
AntesExpresiones=Asigna(Info.ID,WebArt:WebArt.ID)<BR>Asigna(Info.Articulo,WebArt:WebArt.SKU)
[WebCatArt_Art.Columnas]
IDWebCatArt=89
Nombre_1=304
NombreCategoria=304

Nombre=500

[Categorias.WebArt.CategoriaIDS]
Carpeta=Categorias
Clave=WebArt.CategoriaIDS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Acciones.Navegador 1 (Registros)]
Nombre=Navegador 1 (Registros)
Boton=0
NombreDesplegar=Navegador 1 (Registros)
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S

EspacioPrevio=S
[Acciones.HTML]
Nombre=HTML
Boton=75
NombreDesplegar=&Editor HTML
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S

Activo=S
NombreEnBoton=S
Expresion=Asigna(Info.ArticuloD,WebArt:WebArt.Nombre)<BR>Asigna(Info.ID,WebArt:WebArt.ID)<BR>Asigna(Info.Mensaje,WebArt:WebArt.DescripcionHTML)<BR>Asigna(WebArt:WebArt.DescripcionHTML,EditorHTML.Directo( Info.ArticuloD, Info.Mensaje,Falso))<BR>GuardarCambios<BR>EjecutarSQL(<T>spWebArtActualizarHTML :nID<T>,Info.ID)<BR>ActualizarForma
[Acciones.Imagen]
Nombre=Imagen
Boton=74
NombreDesplegar=&Imágenes
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=WebArtImagen
Activo=S
Visible=S

Antes=S
DespuesGuardar=S
NombreEnBoton=S
AntesExpresiones=Asigna(Info.ID,WebArt:WebArt.ID)<BR>Asigna(Info.Articulo,WebArt:WebArt.Nombre)
[Acciones.Videos]
Nombre=Videos
Boton=110
NombreEnBoton=S
NombreDesplegar=&Videos
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=WebArtVideo
Activo=S
Visible=S
Antes=S
DespuesGuardar=S

AntesExpresiones=Asigna(Info.ID,WebArt:WebArt.ID)<BR>Asigna(Info.Articulo,WebArt:WebArt.Nombre)
[Acciones.WebArtVariacionCombinacion]
Nombre=WebArtVariacionCombinacion
Boton=87
NombreEnBoton=S
NombreDesplegar=Com&binaciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=WebArtVariacionCombinacion
GuardarAntes=S
ConCondicion=S
Antes=S
DespuesGuardar=S













Visible=S
Multiple=S
ListaAccionesMultiples=(Lista)
ActivoCondicion=ConDatos(WebArt:WebArt.VariacionID)
EjecucionCondicion=ConDatos(WebArt:WebArt.VariacionID)
[Art.Columnas]
0=120
1=453

[Articulo.WebArt.Unidad]
Carpeta=Articulo
Clave=WebArt.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

[Articulo.WebArt.Cantidad]
Carpeta=Articulo
Clave=WebArt.Cantidad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20

[(Carpeta Abrir).WebArt.SKU]
Carpeta=(Carpeta Abrir)
Clave=WebArt.SKU
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco




[WebCatArt.Columnas]
Nombre=337

[WebCatArtTemp.Columnas]
0=-2

[Articulo.Art.Descripcion1]
Carpeta=Articulo
Clave=Art.Descripcion1
Editar=N
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Plata

[Articulo.WebArt.VariacionID]
Carpeta=Articulo
Clave=WebArt.VariacionID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Articulo.WebArtVariacion.Nombre]
Carpeta=Articulo
Clave=WebArtVariacion.Nombre
Editar=N
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Plata

[Articulo.WebArt.SubCuenta]
Carpeta=Articulo
Clave=WebArt.SubCuenta
Editar=S
ValidaNombre=S
3D=S
Tamano=33
ColorFondo=Blanco

[Acciones.WebArtAtributos]
Nombre=WebArtAtributos
Boton=70
NombreEnBoton=S
NombreDesplegar=A&tributos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=WebArtAtributos
Activo=S
Visible=S

GuardarAntes=S
Antes=S
DespuesGuardar=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.ID,WebArt:WebArt.ID)<BR>Asigna(Info.Articulo,WebArt:WebArt.Nombre)
[Acciones.WebArtCamposConfigurables]
Nombre=WebArtCamposConfigurables
Boton=93
NombreEnBoton=S
NombreDesplegar=Ca&mpos Configurables
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=WebArtCamposConfigurables
Activo=S
Visible=S
Antes=S
DespuesGuardar=S

AntesExpresiones=Asigna(Info.ID,WebArt:WebArt.ID)<BR>Asigna(Info.Articulo,WebArt:WebArt.Nombre)
[Acciones.WebArtVariacionCombinacion.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=GuardarCambios<BR>Asigna(Info.ID,WebArt:WebArt.ID)<BR>Asigna(Info.RID ,WebArt:WebArt.VariacionID)<BR>Asigna(Info.Articulo,WebArt:WebArt.Nombre)<BR>Asigna(Info.Nombre2, SQL(<T>SELECT Nombre FROM WebArtVariacion WHERE ID = :nID<T>,Info.RID) )
[Acciones.WebArtVariacionCombinacion.Combinacion]
Nombre=Combinacion
Boton=0
TipoAccion=Formas
ClaveAccion=WebArtVariacionCombinacion
Activo=S
Visible=S

[Descripcion]
Estilo=Ficha
Clave=Descripcion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=WebArt
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
ListaEnCaptura=WebArt.DescripcionHTML
CarpetaVisible=S
AlinearTodaCarpeta=S

[WebArtAtributosCatDTemp.Columnas]
0=222
1=-2

[WebArtCamposConfigurablesCatDTemp.Columnas]
0=216
1=-2
[Articulo.WebArt.MarcaID]
Carpeta=Articulo
Clave=WebArt.MarcaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
[Articulo.WebArtMarca.Nombre]
Carpeta=Articulo
Clave=WebArtMarca.Nombre
Editar=S
3D=S
Tamano=55
ColorFondo=Plata
ValidaNombre=S
[Acciones.WebCatArt]
Nombre=WebCatArt
Boton=0
Menu=&Maestros
NombreDesplegar=&Categorías Artículos eCommerce
EnMenu=S
TipoAccion=Formas
ClaveAccion=WebCatArt
Activo=S
Visible=S
GuardarAntes=S
[Acciones.WebArtMarca]
Nombre=WebArtMarca
Boton=0
Menu=&Maestros
NombreDesplegar=&Marcas Artículos Web
EnMenu=S
TipoAccion=Formas
ClaveAccion=WebArtMarca
Activo=S
Visible=S
GuardarAntes=S
[Acciones.WebArtVariacion]
Nombre=WebArtVariacion
Boton=0
Menu=&Maestros
NombreDesplegar=&Variaciones Artículos Web
EnMenu=S
TipoAccion=Formas
ClaveAccion=WebArtVariacion
Activo=S
Visible=S
GuardarAntes=S


































[Acciones.WebArtVariacionCombinacion.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Combinacion
Combinacion=(Fin)
























































[Articulo.WebArt.PermiteCompra]
Carpeta=Articulo
Clave=WebArt.PermiteCompra
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=15
[Articulo.WebArt.OcultarPrecio]
Carpeta=Articulo
Clave=WebArt.OcultarPrecio
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Editar=S
Tamano=15
[Articulo.WebArt.Destacado]
Carpeta=Articulo
Clave=WebArt.Destacado
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco













Tamano=15





[(Carpeta Abrir).WebArt.Nombre]
Carpeta=(Carpeta Abrir)
Clave=WebArt.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco











[Articulo.WebArt.Visible]
Carpeta=Articulo
Clave=WebArt.Visible
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco








[Articulo.WebArt.Peso]
Carpeta=Articulo
Clave=WebArt.Peso
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco

ValidaNombre=S




[Acciones.WebArtEstatusExistencia]
Nombre=WebArtEstatusExistencia
Boton=0
Menu=&Edición
NombreDesplegar=Estatus Existencia
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Antes=S
Visible=S














































Expresion=Asigna(Temp.Texto,<T>ID#<T>)<BR>Asigna(Temp.Texto,Temp.Texto+WebArt:WebArt.ID)<BR>FormaModal(<T>WebArtEstatusExistenciaSucursalLista<T>)<BR>ActualizarForma
AntesExpresiones=Asigna(Info.ID,WebArt:WebArt.ID)<BR>Asigna(Info.Articulo,Medio(WebArt:WebArt.Nombre, 1, 30))
[WebArtEstatusExistencia.Columnas]
Sucursal=64
ExistenciaMenorOIgual=114
WebEstatusExistencia=124










SKU=604


















































































































[WebArtEstatusExistenciaSucursalLista.Columnas]
0=-2
1=-2
2=-2
























































[Articulo.WebArt.OpcionesEnvoltura]
Carpeta=Articulo
Clave=WebArt.OpcionesEnvoltura
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Acciones.WebArtEnvoltura]
Nombre=WebArtEnvoltura
Boton=0
Menu=&Edición
NombreDesplegar=Opciones Envoltura
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=WebArtEnvoltura
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.ID, WebArt:WebArt.ID)
DespuesGuardar=S
Visible=S






[Articulo.ListaEnCaptura]
(Inicio)=WebArt.SKU
WebArt.SKU=WebArt.Articulo
WebArt.Articulo=Art.Descripcion1
Art.Descripcion1=WebArt.Unidad
WebArt.Unidad=WebArt.Cantidad
WebArt.Cantidad=WebArt.SubCuenta
WebArt.SubCuenta=WebArt.Nombre
WebArt.Nombre=WebArt.VariacionID
WebArt.VariacionID=WebArtVariacion.Nombre
WebArtVariacion.Nombre=WebArt.MarcaID
WebArt.MarcaID=WebArtMarca.Nombre
WebArtMarca.Nombre=WebArt.PermiteCompra
WebArt.PermiteCompra=WebArt.OcultarPrecio
WebArt.OcultarPrecio=WebArt.Destacado
WebArt.Destacado=WebArt.Visible
WebArt.Visible=WebArt.Peso
WebArt.Peso=WebArt.OpcionesEnvoltura
WebArt.OpcionesEnvoltura=(Fin)


















[Acciones.Campos]
Nombre=Campos
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
Activo=S
Visible=S

Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos




























[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=WebArt.Nombre
WebArt.Nombre=WebArt.SKU
WebArt.SKU=WebArt.Articulo
WebArt.Articulo=(Fin)




[Forma.ListaCarpetas]
(Inicio)=Articulo
Articulo=Descripcion
Descripcion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Documento Nuevo
Documento Nuevo=Documento Abrir
Documento Abrir=Aceptar
Aceptar=Documento Eliminar
Documento Eliminar=Orden
Orden=Categorias
Categorias=Imagen
Imagen=Videos
Videos=HTML
HTML=WebArtVariacionCombinacion
WebArtVariacionCombinacion=WebArtAtributos
WebArtAtributos=WebArtCamposConfigurables
WebArtCamposConfigurables=Navegador 1 (Registros)
Navegador 1 (Registros)=WebCatArt
WebCatArt=WebArtMarca
WebArtMarca=WebArtVariacion
WebArtVariacion=WebArtEstatusExistencia
WebArtEstatusExistencia=WebArtEnvoltura
WebArtEnvoltura=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=&Otros
&Otros=(Fin)
