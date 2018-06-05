[Forma]
Clave=EmbarqueDArtCompraInfo
Nombre=Embarque Parcial - Detalle de Compra
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=412
PosicionInicialAncho=772
PosicionInicialIzquierda=80
PosicionInicialArriba=210
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Totalizadores=S
PosicionSeccion1=91
Comentarios=Lista(Info.Mov, Info.MovID)
VentanaExclusiva=S

PosicionSec1=316
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmbarqueDArtCompra
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
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
ListaCamposAValidar=(Lista)
OtroOrden=S
ListaOrden=(Lista)




FiltroGeneral=EmbarqueDArt2.ID={Info.ID} AND <BR>EmbarqueDArt2.EmbarqueMov={Info.EmbarqueMov}
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
Almacen=82
Articulo=91
SubCuenta=88
Precio=85
FechaRequerida=85
Cantidad=52
CantidadTotal=75
ImporteTotal=95
CantidadPendiente=55
Unidad=45


Tarima=124
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
Totalizadores1=Pendiente<BR>Importe Total<BR>Cantidad<BR>MovPorcentaje
Totalizadores2=Suma(EmbarqueDArtCompra:CantidadPendiente)<BR>Suma( EmbarqueDArtCompra:EmbarqueDArt2.ImporteTotal )<BR>Suma( EmbarqueDArtCompra:EmbarqueDArt2.Cantidad )<BR>(Suma(EmbarqueDArtCompra:EmbarqueDArt2.Cantidad*EmbarqueDArtCompra:EmbarqueDArt2.ImporteTotal)/Suma(EmbarqueDArtCompra:EmbarqueDArt2.CantidadTotal*EmbarqueDArtCompra:EmbarqueDArt2.ImporteTotal))*100
Totalizadores3=(Cantidades)<BR>(Monetario)<BR>(Cantidades)<BR>#.##%
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
ValidaNombre=N
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


[(Carpeta Totalizadores).Pendiente]
Carpeta=(Carpeta Totalizadores)
Clave=Pendiente
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

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

AntesExpresiones=Asigna(Info.Articulo, EmbarqueDArtCompra:CompraD.Articulo)
[(Carpeta Totalizadores).MovPorcentaje]
Carpeta=(Carpeta Totalizadores)
Clave=MovPorcentaje
Editar=S
3D=S
Pegado=N
Tamano=7
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]






[Lista.CompraD.Articulo]
Carpeta=Lista
Clave=CompraD.Articulo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CompraD.SubCuenta]
Carpeta=Lista
Clave=CompraD.SubCuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.CompraD.Unidad]
Carpeta=Lista
Clave=CompraD.Unidad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco







[Lista.EmbarqueDArt2.ImporteTotal]
Carpeta=Lista
Clave=EmbarqueDArt2.ImporteTotal
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CompraD.Almacen]
Carpeta=Lista
Clave=CompraD.Almacen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CompraD.FechaRequerida]
Carpeta=Lista
Clave=CompraD.FechaRequerida
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CantidadPendiente]
Carpeta=Lista
Clave=CantidadPendiente
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.EmbarqueDArt2.Cantidad]
Carpeta=Lista
Clave=EmbarqueDArt2.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco










[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe Total
Importe Total=Pendiente
Pendiente=Cantidad
Cantidad=MovPorcentaje
MovPorcentaje=(Fin)






[Lista.ListaEnCaptura]
(Inicio)=CompraD.Articulo
CompraD.Articulo=CompraD.SubCuenta
CompraD.SubCuenta=CompraD.Unidad
CompraD.Unidad=EmbarqueDArt2.ImporteTotal
EmbarqueDArt2.ImporteTotal=CompraD.Almacen
CompraD.Almacen=CompraD.FechaRequerida
CompraD.FechaRequerida=CantidadPendiente
CantidadPendiente=EmbarqueDArt2.Cantidad
EmbarqueDArt2.Cantidad=EmbarqueDArt2.Tarima
EmbarqueDArt2.Tarima=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=(Fin)

[Lista.ListaOrden]
(Inicio)=EmbarqueDArt2.Renglon	(Acendente)
EmbarqueDArt2.Renglon	(Acendente)=EmbarqueDArt2.RenglonSub	(Acendente)
EmbarqueDArt2.RenglonSub	(Acendente)=(Fin)

[Lista.EmbarqueDArt2.Tarima]
Carpeta=Lista
Clave=EmbarqueDArt2.Tarima
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
