
[Forma]
Clave=SabanaFiltro
Icono=0
BarraAcciones=S
Modulos=(Todos)
Nombre=Filtros
AccionesTamanoBoton=15x5

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=332
PosicionInicialAncho=527
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=419
PosicionInicialArriba=178
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
PosicionCol1=1135
VentanaBloquearAjuste=S
PosicionSec1=350
PosicionSec2=631
[Lista]
Estilo=Ficha
PestanaOtroNombre=S
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SabanaFiltro
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

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=SabanaFiltro.Estacion = {EstacionTrabajoFija}
[Lista.SabanaFiltro.OperadorVenta]
Carpeta=Lista
Clave=SabanaFiltro.OperadorVenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.SabanaFiltro.Venta]
Carpeta=Lista
Clave=SabanaFiltro.Venta
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Lista.SabanaFiltro.FechaD]
Carpeta=Lista
Clave=SabanaFiltro.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[Lista.SabanaFiltro.FechaA]
Carpeta=Lista
Clave=SabanaFiltro.FechaA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Lista.SabanaFiltro.OperadorExistencia]
Carpeta=Lista
Clave=SabanaFiltro.OperadorExistencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.SabanaFiltro.Existencia]
Carpeta=Lista
Clave=SabanaFiltro.Existencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Lista.SabanaFiltro.SucursalGrupo]
Carpeta=Lista
Clave=SabanaFiltro.SucursalGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=52
ColorFondo=Blanco

[Lista.SabanaFiltro.Proveedor]
Carpeta=Lista
Clave=SabanaFiltro.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=52
ColorFondo=Blanco

[Lista.SabanaFiltro.Departamento]
Carpeta=Lista
Clave=SabanaFiltro.Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=52
ColorFondo=Blanco

[Lista.SabanaFiltro.Seccion]
Carpeta=Lista
Clave=SabanaFiltro.Seccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=52
ColorFondo=Blanco

[Lista.SabanaFiltro.Articulo]
Carpeta=Lista
Clave=SabanaFiltro.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=52
ColorFondo=Blanco










[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreEnBoton=S
NombreDesplegar=Aceptar
EnBarraAcciones=S
TipoAccion=Expresion
Activo=S
Visible=S

GuardarAntes=S
Expresion=Asigna(Temp.Texto, SQL(<T>EXEC spPlanArtSabanaValidar :nEstacion, :nEstacionFija, 1<T>, EstacionTrabajo, EstacionTrabajoFija))<BR>Si<BR>  Temp.Texto = <T>OK<T><BR>Entonces<BR>  EjecutarSQL(<T>EXEC spSabanaFiltroSucursal :nEstacion, :tGrupo <T>, EstacionTrabajoFija, SabanaFiltro:SabanaFiltro.SucursalGrupo)<BR>  Asigna(Info.SucursalGrupo, SabanaFiltro:SabanaFiltro.SucursalGrupo)<BR>  Forma(<T>SabanaFiltroSucursal<T>)<BR>Sino<BR>  Informacion(Temp.Texto)<BR>  AbortarOperacion<BR>Fin
[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
NombreDesplegar=Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S




[Lista.Columnas]
Grupo=304
0=-2
1=-2
Categoria=234
Familia=263
Articulo=131
Descripcion1=244






















































Fabricante=282
[General.Columnas]
0=-2
1=-2
2=-2
3=-2

Articulo=88
Descripcion1=282
Artista=164
Fabricante=79
VentaTotal=62
ExistenciaTotal=76
GandhiCostoProveedor=60
GandhiCostoDescuento=64
GandhiDescuento=55
Orden=64
NombreArtista=184
UltimaEntrada=72
EstatusPlan=184
[Detalle.Columnas]
0=-2
1=-2
2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
10=-2
11=-2
















































































Prefijo=89
CantidadComprar=88
Sugerido=89
Venta=73
Existencia=77
Transito=70
Devuelto=73
Ordenado=79
Traspaso=55
PrimeraEntrada=92
UltimaEntrada=93
PVP=60
PrecioPromocion=85
TraspasoP=99
IDClasificacion=64
Almacen=64
[Acciones.Previo]
Nombre=Previo
Boton=0
NombreDesplegar=Ver Previo
EnBarraAcciones=S
TipoAccion=Expresion
Activo=S
Visible=S
























































































ConCondicion=S
EjecucionConError=S
GuardarAntes=S



Expresion=Forma(<T>Sabana<T>)
EjecucionCondicion=SQL(<T>SELECT COUNT(*) FROM Sabana WHERE Estacion = :nEstacion<T>, EstacionTrabajoFija) > 0
EjecucionMensaje=<T>No hay corrida Anterior<T>

[Lista.SabanaFiltro.Fabricante]
Carpeta=Lista
Clave=SabanaFiltro.Fabricante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=52
ColorFondo=Blanco








[Lista.SabanaFiltro.MostrarProvOmision]
Carpeta=Lista
Clave=SabanaFiltro.MostrarProvOmision
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco





Pegado=S






LineaNueva=S

[Lista.ListaEnCaptura]
(Inicio)=SabanaFiltro.FechaD
SabanaFiltro.FechaD=SabanaFiltro.FechaA
SabanaFiltro.FechaA=SabanaFiltro.OperadorVenta
SabanaFiltro.OperadorVenta=SabanaFiltro.Venta
SabanaFiltro.Venta=SabanaFiltro.OperadorExistencia
SabanaFiltro.OperadorExistencia=SabanaFiltro.Existencia
SabanaFiltro.Existencia=SabanaFiltro.SucursalGrupo
SabanaFiltro.SucursalGrupo=SabanaFiltro.Proveedor
SabanaFiltro.Proveedor=SabanaFiltro.Departamento
SabanaFiltro.Departamento=SabanaFiltro.Seccion
SabanaFiltro.Seccion=SabanaFiltro.Fabricante
SabanaFiltro.Fabricante=SabanaFiltro.Articulo
SabanaFiltro.Articulo=SabanaFiltro.MostrarProvOmision
SabanaFiltro.MostrarProvOmision=(Fin)





























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cerrar
Cerrar=Previo
Previo=(Fin)
