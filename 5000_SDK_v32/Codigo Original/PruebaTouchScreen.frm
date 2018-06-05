[Forma]
Clave=PruebaTouchScreen
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Clientes
PosicionInicialIzquierda=0
PosicionInicialArriba=7
PosicionInicialAlturaCliente=718
PosicionInicialAncho=1036
PosicionCol1=398
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSec1=354
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Clientes]
Estilo=Hoja
Pestana=S
Clave=Clientes
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteA
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
PestanaOtroNombre=S
PestanaNombre=Clientes
HojaMantenerSeleccion=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S

[Clientes.Cte.Cliente]
Carpeta=Clientes
Clave=Cte.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Clientes.Cte.Nombre]
Carpeta=Clientes
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Catalogo]
Estilo=Catalogo
PestanaOtroNombre=S
PestanaNombre=Catálogo
Clave=Catalogo
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CteA
Fuente={Tahoma, 8, Negro, []}
CarpetaVisible=S
CatalogoInicial=CatGral
CatalogoActualizarCarpeta=ArtA
CatalogoNoActualizar=S
CatalogoInicioEsp=1

[Clientes.Columnas]
Cliente=91
Nombre=267

[Acciones.SinCatalogo]
Nombre=SinCatalogo
Boton=25
NombreDesplegar=Expresion
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
Expresion=Forma.Catalogo(<T>Catalogo<T>, <T><T>)

[Acciones.Expresion]
Nombre=Expresion
Boton=24
NombreDesplegar=Expresion
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Expresion=Forma.Catalogo(<T>Catalogo<T>, <T>CatGral<T>)

[ArtA.Art.Articulo]
Carpeta=ArtA
Clave=Art.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[ArtA.Art.Descripcion1]
Carpeta=ArtA
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[ArtA.Columnas]
Articulo=124
Descripcion1=184

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Clientes
Clientes=Catalogo
Catalogo=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Expresion
Expresion=SinCatalogo
SinCatalogo=(Fin)

[Clientes.ListaEnCaptura]
(Inicio)=Cte.Cliente
Cte.Cliente=Cte.Nombre
Cte.Nombre=(Fin)
