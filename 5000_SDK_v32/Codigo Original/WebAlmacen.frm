[Forma]
Clave=WebAlmacen
Icono=0
CarpetaPrincipal=WebAlmacen
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ListaCarpetas=(Lista)
PosicionInicialIzquierda=495
PosicionInicialArriba=188
PosicionInicialAlturaCliente=445
PosicionInicialAncho=609
PosicionColumna1=31
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Sucursal
Nombre=Almacenes
PosicionCol1=188
[WebAlmacen]
Estilo=Iconos
Clave=WebAlmacen
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebAlmacen
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Almacén<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Negro
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroTipo=General
PestanaOtroNombre=S
PestanaNombre=Almacenes
IconosConRejilla=S
IconosNombre=WebAlmacen:WebAlmacen.Almacen
FiltroGeneral=WebAlmacen.Sucursal={Info.Sucursal} AND WebAlmacen.Almacen <> <T>(TRANSITO)<T>
[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=WebAlmacen
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=WebAlmacen.Nombre<BR>WebAlmacen.eCommerceSincroniza
CarpetaVisible=S
CondicionEdicion=Usuario.eCommerce
[Detalle.WebAlmacen.Nombre]
Carpeta=Detalle
Clave=WebAlmacen.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro
Pegado=S
[Detalle.WebAlmacen.eCommerceSincroniza]
Carpeta=Detalle
Clave=WebAlmacen.eCommerceSincroniza
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[WebAlmacen.Columnas]
0=166
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





[Forma.ListaCarpetas]
(Inicio)=WebAlmacen
WebAlmacen=Detalle
Detalle=(Fin)
