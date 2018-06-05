
[Forma]
Clave=WebArtVariacionCombinacion
Icono=0
CarpetaPrincipal=Ficha
Modulos=(Todos)
Nombre=Combinaciones Artículos eCommerce

ListaCarpetas=Ficha
PosicionInicialAlturaCliente=525
PosicionInicialAncho=1019
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=275
PosicionInicialArriba=246
PosicionSec1=104
PosicionCol1=128
Comentarios=Lista(Info.Articulo,Info.Nombre2)

ExpresionesAlMostrar=Asigna(info.Copiar,Falso)
Menus=S
MenuPrincipal=&Edición
[WebArtVariacionCombinacion.Columnas]
Activa=64
IDOpciones=604
SKU=304
Imagen=604
UltimoCambio=94
OperacionPrecio=304
Precio=64
OperacionPeso=304
Peso=64

ID=96
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

[WebArtVariacionCombinacion.WebArtVariacionCombinacion.ID]
Carpeta=WebArtVariacionCombinacion
Clave=WebArtVariacionCombinacion.ID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha]
Estilo=Hoja
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtVariacionCombinacion
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=WebArtVariacionCombinacion.Activa<BR>WebArtVariacionCombinacion.Opciones<BR>WebArtVariacionCombinacion.SKU<BR>WebArtVariacionCombinacion.Articulo<BR>WebArtVariacionCombinacion.SubCuenta<BR>WebArtVariacionCombinacion.Unidad<BR>WebArtVariacionCombinacion.Cantidad<BR>WebArtVariacionCombinacion.Imagen
CarpetaVisible=S

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaMantenerSeleccion=S
FiltroGeneral=WebArtVariacionCombinacion.IDArt = {Info.ID} AND<BR>WebArtVariacionCombinacion.IDVariacion = {Info.RID }
[Ficha.WebArtVariacionCombinacion.SKU]
Carpeta=Ficha
Clave=WebArtVariacionCombinacion.SKU
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebArtVariacionCombinacion.Imagen]
Carpeta=Ficha
Clave=WebArtVariacionCombinacion.Imagen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebArtVariacionCombinacion.Activa]
Carpeta=Ficha
Clave=WebArtVariacionCombinacion.Activa
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro






[Ficha.Columnas]
SKU=110
Activa=36
Imagen=288
IDOpciones=82
OperacionPrecio=100
Precio=64
OperacionPeso=94
Peso=64

Opciones=221
SubCuenta=103
Articulo=95
Unidad=57
Cantidad=59
[Ficha.WebArtVariacionCombinacion.Opciones]
Carpeta=Ficha
Clave=WebArtVariacionCombinacion.Opciones
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebArtVariacionCombinacion.SubCuenta]
Carpeta=Ficha
Clave=WebArtVariacionCombinacion.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebArtVariacionCombinacion.Articulo]
Carpeta=Ficha
Clave=WebArtVariacionCombinacion.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebArtVariacionCombinacion.Unidad]
Carpeta=Ficha
Clave=WebArtVariacionCombinacion.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebArtVariacionCombinacion.Cantidad]
Carpeta=Ficha
Clave=WebArtVariacionCombinacion.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro


[Acciones.Agregar Imagen]
Nombre=Agregar Imagen
Boton=62
NombreEnBoton=S
NombreDesplegar=Agregar I&magen
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Antes=S
DespuesGuardar=S
Visible=S

Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
EsDefault=S
EnMenu=S
Expresion=FormaModal(<T>WebArtCombinacionImagenTemp<T>)<BR>ActualizarForma
ActivoCondicion=Vacio(WebArtVariacionCombinacion.Imagen)
AntesExpresiones=Asigna(Info.GID,WebArtVariacionCombinacion:WebArtVariacionCombinacion.ID)<BR>Asigna(Info.RID,WebArtVariacionCombinacion:WebArtVariacionCombinacion.IDVariacion)<BR>Asigna(Info.ID,WebArtVariacionCombinacion:WebArtVariacionCombinacion.IDArt)<BR>Asigna(Info.Pedimento,WebArtVariacionCombinacion:WebArtVariacionCombinacion.Opciones)
[Acciones.EliminarImagen.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

[Acciones.EliminarImagen]
Nombre=EliminarImagen
Boton=63
NombreEnBoton=S
NombreDesplegar=&Eliminar Imagen
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
Activo=S
Visible=S
TipoAccion=Expresion

Antes=S
DespuesGuardar=S
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+I
EsDefault=S
EnMenu=S
Expresion=Archivo.Eliminar(WebArtVariacionCombinacion:WebArtVariacionCombinacion.Imagen)<BR>EjecutarSQL(<T>spWebArtEliminarImagenCombinacion :ID<T>,WebArtVariacionCombinacion:WebArtVariacionCombinacion.ID)<BR><BR>ActualizarForma
AntesExpresiones=Asigna(Info.GID,WebArtVariacionCombinacion:WebArtVariacionCombinacion.ID)
[Acciones.Generar]
Nombre=Generar
Boton=92
NombreEnBoton=S
NombreDesplegar=&Generar Combinaciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=SI Confirmacion(<T>Esta seguro que desea Generar las Combinaciones?<T>+,BotonAceptar,BotonCancelar) = BotonAceptar Entonces   ProcesarSQL(<T>spWebArtGenerarCombinaciones :nIDArt ,:nIDVar<T>,Info.ID ,Info.RID))<BR>ActualizarForma
[Acciones.Registro Agregar]
Nombre=Registro Agregar
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
EspacioPrevio=S
[Acciones.Registro Eliminar]
Nombre=Registro Eliminar
Boton=5
NombreDesplegar=& Eliminar
EnBarraHerramientas=S
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
EspacioPrevio=S












[WebArtEstatusExistencia.Columnas]
Sucursal=64
ExistenciaMenorOIgual=114
WebEstatusExistencia=124

[Acciones.WebArtEstatusExistencia]
Nombre=WebArtEstatusExistencia
Boton=0
NombreDesplegar=Estatus Inventario
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Temp.Texto, <T>IDCO#<T>)<BR>Asigna(Temp.Texto, Temp.Texto+WebArtVariacionCombinacion:WebArtVariacionCombinacion.ID)<BR>FormaModal(<T>WebArtEstatusExistencia<T>)<BR>ActualizarForma




[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Registro Agregar
Registro Agregar=Registro Eliminar
Registro Eliminar=Generar
Generar=Agregar Imagen
Agregar Imagen=EliminarImagen
EliminarImagen=WebArtEstatusExistencia
WebArtEstatusExistencia=(Fin)
