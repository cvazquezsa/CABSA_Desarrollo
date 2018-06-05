
[Forma]
Clave=WebArtEstatusExistenciaSucursalLista
Icono=0
Modulos=(Todos)
Nombre=Seleccione una Sucursal

ListaCarpetas=WebArtEstatusExistenciaSucursalLista
CarpetaPrincipal=WebArtEstatusExistenciaSucursalLista
PosicionInicialIzquierda=729
PosicionInicialArriba=432
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
BarraHerramientas=S


Comentarios=Lista(Info.Articulo)
[WebEstatusExistenciaSucursalLista.Columnas]
0=-2
1=-2
2=-2



[WebEstatusExistenciaSucursalLista.ListaEnCaptura]
(Inicio)=WebSucursal.Sucursal
WebSucursal.Sucursal=WebSucursal.Nombre
WebSucursal.Nombre=(Fin)

[Acciones.Configurar]
Nombre=Configurar
Boton=45
NombreEnBoton=S
NombreDesplegar=Configurar &Estatus
TipoAccion=Expresion
Activo=S
Visible=S
EnBarraHerramientas=S

EspacioPrevio=S
Expresion=Asigna(Info.Sucursal, WebSucursal:WebSucursal.Sucursal)<BR>FormaModal(<T>WebArtEstatusExistencia<T>)
[WebArtEstatusExistenciaSucursalLista]
Estilo=Iconos
Clave=WebArtEstatusExistenciaSucursalLista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebSucursal
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosNombre=<T><T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=WebSucursal.eCommerce = <T>1<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
[WebArtEstatusExistenciaSucursalLista.ListaEnCaptura]
(Inicio)=WebSucursal.Sucursal
WebSucursal.Sucursal=WebSucursal.Nombre
WebSucursal.Nombre=(Fin)

[WebArtEstatusExistenciaSucursalLista.WebSucursal.Sucursal]
Carpeta=WebArtEstatusExistenciaSucursalLista
Clave=WebSucursal.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[WebArtEstatusExistenciaSucursalLista.WebSucursal.Nombre]
Carpeta=WebArtEstatusExistenciaSucursalLista
Clave=WebSucursal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[WebArtEstatusExistenciaSucursalLista.Columnas]
0=-2
1=-2
2=-2

[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S



























[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Configurar
Configurar=(Fin)
