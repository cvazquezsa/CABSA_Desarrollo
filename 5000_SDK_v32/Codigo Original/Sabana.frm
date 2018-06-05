
[Forma]
Clave=Sabana
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Herramienta de Compras y Distribución

ListaCarpetas=(Lista)
CarpetaPrincipal=Editable
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=0
PosicionInicialArriba=0
PosicionInicialAlturaCliente=749
PosicionInicialAncho=1372
PosicionCol1=1135
ListaAcciones=(Lista)
PosicionSec1=350
SinTransacciones=S
AutoGuardar=S
Totalizadores=S
PosicionSec2=631
VentanaBloquearAjuste=N

[General]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Articulos
Clave=General
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Sabana
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S


HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaMantenerSeleccion=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaTitulos=S
HojaIndicador=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PermiteLocalizar=S
HojaAjustarColumnas=S

FiltroGeneral=Sabana.Estacion = {EstacionTrabajoFija}
[General.Sabana.VentaTotal]
Carpeta=General
Clave=Sabana.VentaTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[General.Sabana.ExistenciaTotal]
Carpeta=General
Clave=Sabana.ExistenciaTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Sucursales
Clave=Detalle
OtroOrden=S
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=SabanaD
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

VistaMaestra=Sabana
LlaveLocal=SabanaD.ID
LlaveMaestra=Sabana.ID
ListaEnCaptura=(Lista)
ListaOrden=Sucursal.Prefijo<TAB>(Acendente)

MenuLocal=S
ListaAcciones=Traspaso
PermiteEditar=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
ControlRenglon=S
CampoRenglon=SabanaD.Renglon
ValidarCampos=S
ListaCamposAValidar=(Lista)

[Detalle.SabanaD.PrimeraEntrada]
Carpeta=Detalle
Clave=SabanaD.PrimeraEntrada
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Detalle.SabanaD.UltimaEntrada]
Carpeta=Detalle
Clave=SabanaD.UltimaEntrada
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Detalle.SabanaD.Venta]
Carpeta=Detalle
Clave=SabanaD.Venta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Detalle.SabanaD.Existencia]
Carpeta=Detalle
Clave=SabanaD.Existencia
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Detalle.SabanaD.Transito]
Carpeta=Detalle
Clave=SabanaD.Transito
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Detalle.SabanaD.Devuelto]
Carpeta=Detalle
Clave=SabanaD.Devuelto
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Detalle.SabanaD.Ordenado]
Carpeta=Detalle
Clave=SabanaD.Ordenado
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Detalle.SabanaD.Sugerido]
Carpeta=Detalle
Clave=SabanaD.Sugerido
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Detalle.SabanaD.Traspaso]
Carpeta=Detalle
Clave=SabanaD.Traspaso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2




IgnoraFlujo=N
ColorFondo=Blanco
[General.Columnas]
0=-2
1=101
2=-2
3=-2

4=-2
5=-2
6=-2
Articulo=88
Descripcion1=282
Artista=159
Fabricante=79
VentaTotal=62
ExistenciaTotal=76
GandhiCostoProveedor=60
GandhiCostoDescuento=64
GandhiDescuento=55
UltimaEntrada=72
Orden=64
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










11=73


Sucursal=64
PrimeraEntrada=92
UltimaEntrada=93
Venta=73
Existencia=77
Transito=70
Devuelto=73
Ordenado=79
Sugerido=89
CantidadComprar=88
Traspaso=55
Prefijo=89
PVP=60
PrecioPromocion=85
TraspasoP=99
IDClasificacion=64
Almacen=64
[Detalle.SabanaD.CantidadComprar]
Carpeta=Detalle
Clave=SabanaD.CantidadComprar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S








ColorFondo=Blanco
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S



[Acciones.GenerarAmbas]
Nombre=GenerarAmbas
Boton=0
NombreEnBoton=S
NombreDesplegar=Generar Ordenes y Traspasos
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S









EspacioPrevio=S









Antes=S
GuardarAntes=S
DespuesGuardar=S
AntesExpresiones=Si<BR>  FormaModal(<T>SabanaLiberarOrdenes<T>)<BR>Entonces<BR>  ProcesarSQL(<T>EXEC spSabanaLiberar :nSuc, :tEmpresa, :tUsuario, :nEstacion, :nTipo<T>, Sucursal, Empresa, Usuario, EstacionTrabajoFija, 3)<BR>Fin
[General.Art.Descripcion1]
Carpeta=General
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco












[General.Sabana.Articulo]
Carpeta=General
Clave=Sabana.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=General
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S































[Editable]
Estilo=Ficha
Clave=Editable
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Sabana
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
ListaEnCaptura=(Lista)


CarpetaVisible=S
PermiteEditar=S






OtroOrden=S
ListaOrden=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=Sabana.Estacion = {EstacionTrabajoFija}
[Detalle.ListaAcciones]
(Inicio)=ActivarTraspaso
ActivarTraspaso=DesactivarTraspaso
DesactivarTraspaso=(Fin)





















[General.Artista]
Carpeta=General
Clave=Artista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[General.Art.Fabricante]
Carpeta=General
Clave=Art.Fabricante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Editable.Art.Grupo]
Carpeta=Editable
Clave=Art.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Editable.Art.Categoria]
Carpeta=Editable
Clave=Art.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Editable.Art.Familia]
Carpeta=Editable
Clave=Art.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[Acciones.Traspaso]
Nombre=Traspaso
Boton=0
NombreDesplegar=Traspasos
EnMenu=S
TipoAccion=Formas
ClaveAccion=SabanaTraspaso
Antes=S
Visible=S































UsaTeclaRapida=S
TeclaRapida=Ctrl+T
ActivoCondicion=SabanaD:SabanaD.Traspaso = <T>Si<T>
AntesExpresiones=Asigna(Info.Articulo, SabanaD:SabanaD.Articulo)<BR>Asigna(Info.Sucursal, SabanaD:SabanaD.Sucursal)<BR>Asigna(Info.Almacen, SabanaD:SabanaD.Almacen)<BR>Asigna(Info.Cantidad, SabanaD:SabanaD.Existencia)<BR>EjecutarSQL(<T>EXEC spSabanaTraspaso :nEstacion, :tArt, :nSucursal, :tAlm<T>, EstacionTrabajoFija, SabanaD:SabanaD.Articulo, SabanaD:SabanaD.Sucursal, SabanaD:SabanaD.Almacen)
[Detalle.LlaveLocal]
(Inicio)=SabanaD.Estacion
SabanaD.Estacion=SabanaD.Articulo
SabanaD.Articulo=(Fin)

[Detalle.LlaveMaestra]
(Inicio)=Sabana.Estacion
Sabana.Estacion=Sabana.Articulo
Sabana.Articulo=(Fin)










[Detalle.ListaOrden]
(Inicio)=SabanaD.Sucursal	(Acendente)
SabanaD.Sucursal	(Acendente)=SabanaD.Renglon	(Acendente)
SabanaD.Renglon	(Acendente)=(Fin)












[General.ListaOrden]
(Inicio)=Art.GandhiArtista	(Acendente)
Art.GandhiArtista	(Acendente)=Sabana.Articulo	(Acendente)
Sabana.Articulo	(Acendente)=Sabana.VentaTotal	(Decendente)
Sabana.VentaTotal	(Decendente)=(Fin)









[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Venta<BR>Existencia<BR>Total<BR>Compra
Totalizadores2=SQL(<T>SELECT SUM(VentaTotal) FROM Sabana WHERE Estacion=:nest<T>,EstacionTrabajoFija)<BR>SQL(<T>SELECT SUM(ExistenciaTotal) FROM Sabana WHERE Estacion=:nest<T>,EstacionTrabajoFija)<BR>SQL(<T>SELECT COUNT(ID) FROM Sabana WHERE Estacion=:nest<T>,EstacionTrabajoFija)<BR>Suma(SabanaD:SabanaD.CantidadComprar)
Totalizadores=S
TotCarpetaRenglones=Detalle
TotAlCambiar=N
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CarpetaVisible=S

TotExpresionesEnSumas=S
[(Carpeta Totalizadores).Venta]
Carpeta=(Carpeta Totalizadores)
Clave=Venta
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata

[(Carpeta Totalizadores).Existencia]
Carpeta=(Carpeta Totalizadores)
Clave=Existencia
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata



[(Carpeta Totalizadores).Compra]
Carpeta=(Carpeta Totalizadores)
Clave=Compra
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata




[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Total
Total=Venta
Venta=Existencia
Existencia=Compra
Compra=(Fin)

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata









[Editable.Sabana.FechaD]
Carpeta=Editable
Clave=Sabana.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

ColorFondo=Blanco
[Editable.Sabana.FechaA]
Carpeta=Editable
Clave=Sabana.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[Editable.Sabana.Grupo]
Carpeta=Editable
Clave=Sabana.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco











[Editable.Prov.Nombre]
Carpeta=Editable
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco













[Detalle.SabanaD.TraspasoP]
Carpeta=Detalle
Clave=SabanaD.TraspasoP
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata






















[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Compras
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=SabanaOrdenado
Activo=S
Visible=S

EspacioPrevio=S






GuardarAntes=S














































NombreEnBoton=S


[Acciones.Localizar]
Nombre=Localizar
Boton=78
NombreEnBoton=S
NombreDesplegar=Localizar
EnBarraHerramientas=S
Carpeta=General
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
EspacioPrevio=S


[Acciones.PreliminarTraspaso]
Nombre=PreliminarTraspaso
Boton=6
NombreEnBoton=S
NombreDesplegar=Traspasos
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=SabanaTraspaso
Activo=S
Visible=S










[General.Sabana.UltimaEntrada]
Carpeta=General
Clave=Sabana.UltimaEntrada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








[Editable.Prov.Condicion]
Carpeta=Editable
Clave=Prov.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco





















[General.Sabana.Orden]
Carpeta=General
Clave=Sabana.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








[Editable.ListaEnCaptura]
(Inicio)=Sabana.FechaD
Sabana.FechaD=Sabana.FechaA
Sabana.FechaA=Prov.Nombre
Prov.Nombre=Prov.Condicion
Prov.Condicion=Sabana.Grupo
Sabana.Grupo=Art.Categoria
Art.Categoria=Art.Familia
Art.Familia=Art.Grupo
Art.Grupo=(Fin)

[Editable.ListaOrden]
(Inicio)=Sabana.VentaTotal	(Decendente)
Sabana.VentaTotal	(Decendente)=Sabana.Articulo	(Acendente)
Sabana.Articulo	(Acendente)=(Fin)











[Detalle.SabanaD.Almacen]
Carpeta=Detalle
Clave=SabanaD.Almacen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco







[General.ListaEnCaptura]
(Inicio)=Sabana.Orden
Sabana.Orden=Sabana.Articulo
Sabana.Articulo=Art.Descripcion1
Art.Descripcion1=Art.Fabricante
Art.Fabricante=Sabana.VentaTotal
Sabana.VentaTotal=Sabana.ExistenciaTotal
Sabana.ExistenciaTotal=Sabana.UltimaEntrada
Sabana.UltimaEntrada=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=SabanaD.Almacen
SabanaD.Almacen=SabanaD.CantidadComprar
SabanaD.CantidadComprar=SabanaD.Sugerido
SabanaD.Sugerido=SabanaD.Venta
SabanaD.Venta=SabanaD.Existencia
SabanaD.Existencia=SabanaD.Transito
SabanaD.Transito=SabanaD.Devuelto
SabanaD.Devuelto=SabanaD.Ordenado
SabanaD.Ordenado=SabanaD.TraspasoP
SabanaD.TraspasoP=SabanaD.Traspaso
SabanaD.Traspaso=SabanaD.PrimeraEntrada
SabanaD.PrimeraEntrada=SabanaD.UltimaEntrada
SabanaD.UltimaEntrada=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=SabanaD.Articulo
SabanaD.Articulo=Art.Descripcion1
Art.Descripcion1=(Fin)









[Forma.ListaCarpetas]
(Inicio)=General
General=Editable
Editable=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=GenerarAmbas
GenerarAmbas=Excel
Excel=Preliminar
Preliminar=PreliminarTraspaso
PreliminarTraspaso=Localizar
Localizar=(Fin)
