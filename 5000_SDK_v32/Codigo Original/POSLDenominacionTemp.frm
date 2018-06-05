

[Forma]
Clave=POSLDenominacionTemp
Icono=0
CarpetaPrincipal=POSLDenominacionTemp
Modulos=(Todos)
Nombre=Denominaciones

ListaCarpetas=POSLDenominacionTemp
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=1958
PosicionInicialArriba=319
PosicionInicialAlturaCliente=316
PosicionInicialAncho=563
Totalizadores=S
ListaAcciones=Aceptar
Comentarios=Info.FormaPago
PosicionSec1=237
[POSLDenominacionTemp]
Estilo=Hoja
Clave=POSLDenominacionTemp
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSLDenominacionTemp
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroAutoCampo=POSLDenominacionTemp.Moneda
FiltroAutoValidar=POSLDenominacionTemp.Moneda
FiltroAutoOrden=POSLDenominacionTemp.Moneda
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=POSLDenominacionTemp.ID = <T>{Info.IDTexto}<T> AND POSLDenominacionTemp.Estacion = {EstacionTrabajo}
[POSLDenominacionTemp.POSLDenominacionTemp.Denominacion]
Carpeta=POSLDenominacionTemp
Clave=POSLDenominacionTemp.Denominacion
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSLDenominacionTemp.POSLDenominacionTemp.Cantidad]
Carpeta=POSLDenominacionTemp
Clave=POSLDenominacionTemp.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSLDenominacionTemp.Columnas]
Denominacion=138
Cantidad=70


















TotalDenominacion=97
Nombre=207
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S







GuardarAntes=S

Multiple=S
ListaAccionesMultiples=(Lista)
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
Totalizadores1=Total
Totalizadores2=Asigna(Info.Cantidad2,Suma(POSLDenominacionTemp:POSLDenominacionTemp.Denominacion*POSLDenominacionTemp:POSLDenominacionTemp.Cantidad))   Info.Cantidad2
Totalizadores3=(Monetario)
Totalizadores=S
TotAlCambiar=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total
CarpetaVisible=S

TotCarpetaRenglones=POSLDenominacionTemp
TotExpresionesEnSumas=S
ExpAlRefrescar=Asigna(Info.Cantidad2, SumaTotal(POSLDenominacionTemp:POSLDenominacionTemp.Cantidad*POSLDenominacionTemp:POSLDenominacionTemp.Denominacion))
[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata


[POSLDenominacionTemp.TotalDenominacion]
Carpeta=POSLDenominacionTemp
Clave=TotalDenominacion
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[POSLDenominacionTemp.POSLDenominacionTemp.Nombre]
Carpeta=POSLDenominacionTemp
Clave=POSLDenominacionTemp.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Cantidad2, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>EjecutarSQL(<T>spPOSInsertarPOSLDenominacion :nEstacion,:tID<T>,EstacionTrabajo,Info.IDTexto)
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)

[POSLDenominacionTemp.ListaEnCaptura]
(Inicio)=POSLDenominacionTemp.Cantidad
POSLDenominacionTemp.Cantidad=POSLDenominacionTemp.Denominacion
POSLDenominacionTemp.Denominacion=POSLDenominacionTemp.Nombre
POSLDenominacionTemp.Nombre=TotalDenominacion
TotalDenominacion=(Fin)
