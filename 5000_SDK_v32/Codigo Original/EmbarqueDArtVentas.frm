[Forma]
Clave=EmbarqueDArtVentas
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
PosicionInicialAncho=645
PosicionInicialIzquierda=477
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
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmbarqueDArtVentas
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
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Asigna(Info.Porcentaje, (Suma(EmbarqueDArtVentas:EmbarqueDArt.Cantidad*EmbarqueDArtVentas:EmbarqueDArt.ImporteTotal)/Suma(EmbarqueDArtVentas:EmbarqueDArt.CantidadTotal*EmbarqueDArtVentas:EmbarqueDArt.ImporteTotal))*100)<BR>(Info.Porcentaje>=0) y (Info.Porcentaje<=100)
EjecucionMensaje=<T>Porcentaje Incorrecto<T>
EjecucionConError=S

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
Totalizadores1=Pendiente<BR>Importe Total<BR>Cantidad<BR>MovPorcentaje
Totalizadores2=Suma( EmbarqueDArtVentas:CantidadPendiente )<BR>Suma( EmbarqueDArtVentas:EmbarqueDArt.ImporteTotal )<BR>Suma( EmbarqueDArtVentas:EmbarqueDArt.Cantidad )<BR>(Suma(EmbarqueDArtVentas:EmbarqueDArt.Cantidad*EmbarqueDArtVentas:EmbarqueDArt.ImporteTotal)/Suma(EmbarqueDArtVentas:EmbarqueDArt.CantidadTotal*EmbarqueDArtVentas:EmbarqueDArt.ImporteTotal))*100
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

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Lista.CantidadPendiente]
Carpeta=Lista
Clave=CantidadPendiente
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00808040
Efectos=[Negritas]

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
AntesExpresiones=Asigna(Info.Articulo, EmbarqueDArtVentas:VentaD.Articulo)

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


[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe Total
Importe Total=Pendiente
Pendiente=Cantidad
Cantidad=MovPorcentaje
MovPorcentaje=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VentaD.Articulo
VentaD.Articulo=VentaD.SubCuenta
VentaD.SubCuenta=VentaD.Unidad
VentaD.Unidad=EmbarqueDArt.ImporteTotal
EmbarqueDArt.ImporteTotal=VentaD.Almacen
VentaD.Almacen=VentaD.FechaRequerida
VentaD.FechaRequerida=CantidadPendiente
CantidadPendiente=EmbarqueDArt.Cantidad
EmbarqueDArt.Cantidad=EmbarqueDArt.Tarima
EmbarqueDArt.Tarima=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=(Fin)

[Lista.ListaOrden]
(Inicio)=EmbarqueDArt.Renglon	(Acendente)
EmbarqueDArt.Renglon	(Acendente)=EmbarqueDArt.RenglonSub	(Acendente)
EmbarqueDArt.RenglonSub	(Acendente)=(Fin)

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
Aceptar=Cancelar
Cancelar=ArtInfo
ArtInfo=(Fin)
