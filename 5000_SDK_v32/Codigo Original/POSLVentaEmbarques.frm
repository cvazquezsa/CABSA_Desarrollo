
[Forma]
Clave=POSLVentaEmbarques
Icono=0
Modulos=(Todos)
Nombre=Embarques

ListaCarpetas=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
VentanaColor=Plata
CarpetaPrincipal=Lista
PosicionInicialIzquierda=1626
PosicionInicialAlturaCliente=327
PosicionInicialAncho=828
PosicionInicialArriba=109
Totalizadores=S
PosicionSec1=295
PosicionSec2=295
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
BarraBotones=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSLVentaEmbarques
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaColorFondo=Plata
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
BarraBtnFuente={MS Sans Serif, 8, Blanco, []}
BarraBtnFondo=$00804000
CarpetaVisible=S

BarraBtnPosicion=Abajo
ListaAccionesBB=(Lista)
BarraBtnSize=80
BarraBtnSeparacion=2
BarraBtnSinBisel=S
BarraBtnBisel=0
BarraBtnPaginas=5
ValidarCampos=S
ListaCamposAValidar=POSLVentaEmbarques.Articulo
FuenteDesplegar={MS Sans Serif, 8, Negro, []}
FiltroGeneral=POSLVentaEmbarques.ID = <T>{Info.IDTexto}<T>   AND<BR>POSLVentaEmbarques.RenglonID = {Info.RenglonID}  AND<BR>POSLVentaEmbarques.Articulo  = <T>{Info.Articulo}<T> AND<BR>POSLVentaEmbarques.Renglon = {Info.Renglon}
[Lista.POSLVentaEmbarques.TipoDireccion]
Carpeta=Lista
Clave=POSLVentaEmbarques.TipoDireccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.POSLVentaEmbarques.Cantidad]
Carpeta=Lista
Clave=POSLVentaEmbarques.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.Columnas]
TipoDireccion=90
Cantidad=64
Direccion=618
















Ubicacion=621
[Acciones.Separador]
Nombre=Separador
Boton=0
NombreDesplegar=Separador
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=5
BarraBtnAlto=75
BarraBtnFondo=Plata
BarraBtnPagina=1






[Acciones.Guardar]
Nombre=Guardar
Boton=0
NombreDesplegar=<T>Guardar<T>
GuardarAntes=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Seleccionar.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





ConCondicion=S
EjecucionConError=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
EjecucionCondicion=Suma(POSLVentaEmbarques:POSLVentaEmbarques.Cantidad)=Info.Cantidad
EjecucionMensaje=<T>No Cuadran las Cantidades a Embercar<T>
[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
Totalizadores1=Cantidad Embarcada<BR>Cantidad Compra
Totalizadores2=Suma(POSLVentaEmbarques:POSLVentaEmbarques.Cantidad)<BR>Info.Cantidad
Totalizadores3=0.00<BR>0.00
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S


[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=<T>Cancelar<T>
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Eliminar.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado








[Lista.ListaCamposAValidar]
(Inicio)=POSLVentaEmbarques.Articulo
POSLVentaEmbarques.Articulo=POSLVentaEmbarques.Cantidad
POSLVentaEmbarques.Cantidad=(Fin)


[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Cantidad Compra
Cantidad Compra=Cantidad Embarcada
Cantidad Embarcada=(Fin)

[(Carpeta Totalizadores).Cantidad Compra]
Carpeta=(Carpeta Totalizadores)
Clave=Cantidad Compra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata

[(Carpeta Totalizadores).Cantidad Embarcada]
Carpeta=(Carpeta Totalizadores)
Clave=Cantidad Embarcada
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata







[Lista.POSLVentaEmbarques.Ubicacion]
Carpeta=Lista
Clave=POSLVentaEmbarques.Ubicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco



[Lista.ListaEnCaptura]
(Inicio)=POSLVentaEmbarques.TipoDireccion
POSLVentaEmbarques.TipoDireccion=POSLVentaEmbarques.Cantidad
POSLVentaEmbarques.Cantidad=POSLVentaEmbarques.Ubicacion
POSLVentaEmbarques.Ubicacion=(Fin)

[Lista.ListaAccionesBB]
(Inicio)=Separador
Separador=Guardar
Guardar=Cancelar
Cancelar=(Fin)
