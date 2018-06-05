[Forma]
Clave=EmbarqueDArtVentasInfo
Nombre=Embarque Parcial - Detalle del Movimiento
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=412
PosicionInicialAncho=574
PosicionInicialIzquierda=513
PosicionInicialArriba=210
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Totalizadores=S
PosicionSeccion1=91
Comentarios=Lista(Info.Mov, Info.MovID)

PosicionSec1=316
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmbarqueDArtVentas
Fuente={Tahoma, 8, Negro, []}
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
ValidarCampos=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática

FiltroGeneral=EmbarqueDArt.ID={Info.ID} AND <BR>EmbarqueDArt.EmbarqueMov={Info.EmbarqueMov}
[Lista.VentaD.Almacen]
Carpeta=Lista
Clave=VentaD.Almacen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VentaD.Articulo]
Carpeta=Lista
Clave=VentaD.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.VentaD.SubCuenta]
Carpeta=Lista
Clave=VentaD.SubCuenta
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.VentaD.Unidad]
Carpeta=Lista
Clave=VentaD.Unidad
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.VentaD.FechaRequerida]
Carpeta=Lista
Clave=VentaD.FechaRequerida
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.EmbarqueDArt.Cantidad]
Carpeta=Lista
Clave=EmbarqueDArt.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Efectos=[Negritas]

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Almacen=82
Articulo=90
SubCuenta=73
Precio=85
FechaRequerida=85
Cantidad=52
CantidadTotal=75
ImporteTotal=95
CantidadPendiente=55
0=48
1=45
Unidad=61

Tarima=124
[Lista.EmbarqueDArt.ImporteTotal]
Carpeta=Lista
Clave=EmbarqueDArt.ImporteTotal
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Pendiente<BR>Importe Total<BR>Cantidad
Totalizadores2=Suma( EmbarqueDArtVentas:CantidadPendiente )<BR>Suma( EmbarqueDArtVentas:EmbarqueDArt.ImporteTotal )<BR>Suma( EmbarqueDArtVentas:EmbarqueDArt.Cantidad )
Totalizadores3=(Cantidades)<BR>(Monetario)<BR>(Cantidades)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Carpeta Totalizadores).Importe Total]
Carpeta=(Carpeta Totalizadores)
Clave=Importe Total
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[(Carpeta Totalizadores).Cantidad]
Carpeta=(Carpeta Totalizadores)
Clave=Cantidad
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreDesplegar=Información del Artículo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Articulo, EmbarqueDArtVentas:VentaD.Articulo)


[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe Total
Importe Total=Cantidad
Cantidad=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VentaD.Articulo
VentaD.Articulo=VentaD.SubCuenta
VentaD.SubCuenta=VentaD.Unidad
VentaD.Unidad=EmbarqueDArt.ImporteTotal
EmbarqueDArt.ImporteTotal=VentaD.Almacen
VentaD.Almacen=VentaD.FechaRequerida
VentaD.FechaRequerida=EmbarqueDArt.Cantidad
EmbarqueDArt.Cantidad=EmbarqueDArt.Tarima
EmbarqueDArt.Tarima=(Fin)

[Lista.EmbarqueDArt.Tarima]
Carpeta=Lista
Clave=EmbarqueDArt.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco













[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=ArtInfo
ArtInfo=(Fin)
