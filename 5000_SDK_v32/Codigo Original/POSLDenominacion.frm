
[Forma]
Clave=POSLDenominacion
Icono=0
CarpetaPrincipal=POSLDenominacion
Modulos=(Todos)
Nombre=Denominaciones

ListaCarpetas=POSLDenominacion
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=1909
PosicionInicialArriba=335
PosicionInicialAlturaCliente=354
PosicionInicialAncho=661
Totalizadores=S
ListaAcciones=Aceptar
Comentarios=Lista(<T>$<T>+Info.Cantidad,Info.FormaPago)
PosicionSec1=237
ExpresionesAlMostrar=Asigna(Info.Cantidad,SQL(<T>SELECT dbo.fnPOSValidarDenominacion(:tID,:tMoneda)<T>,Info.IDTexto,Info.Moneda))
[POSLDenominacion]
Estilo=Hoja
Clave=POSLDenominacion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSLDenominacion
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
FiltroAutoCampo=POSLDenominacion.Moneda
FiltroAutoValidar=POSLDenominacion.Moneda
FiltroAutoOrden=POSLDenominacion.Moneda
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=POSLDenominacion.ID = <T>{Info.IDTexto}<T> AND POSLDenominacion.Formapago = <T>{Info.Formapago}<T>
[POSLDenominacion.POSLDenominacion.Denominacion]
Carpeta=POSLDenominacion
Clave=POSLDenominacion.Denominacion
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSLDenominacion.POSLDenominacion.Cantidad]
Carpeta=POSLDenominacion
Clave=POSLDenominacion.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSLDenominacion.Columnas]
Denominacion=138
Cantidad=70


















TotalDenominacion=97
Nombre=304
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
Totalizadores2=Asigna(Info.Cantidad2,Suma(POSLDenominacion:POSLDenominacion.Denominacion*POSLDenominacion:POSLDenominacion.Cantidad))   Info.Cantidad2
Totalizadores3=(Monetario)
Totalizadores=S
TotAlCambiar=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total
CarpetaVisible=S

TotCarpetaRenglones=POSLDenominacion
TotExpresionesEnSumas=S
ExpAlRefrescar=Asigna(Info.Cantidad2, SumaTotal(POSLDenominacion:POSLDenominacion.Cantidad*POSLDenominacion:POSLDenominacion.Denominacion))
[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata


[POSLDenominacion.TotalDenominacion]
Carpeta=POSLDenominacion
Clave=TotalDenominacion
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[POSLDenominacion.POSLDenominacion.Nombre]
Carpeta=POSLDenominacion
Clave=POSLDenominacion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco







[POSLDenominacion.ListaEnCaptura]
(Inicio)=POSLDenominacion.Cantidad
POSLDenominacion.Cantidad=POSLDenominacion.Nombre
POSLDenominacion.Nombre=POSLDenominacion.Denominacion
POSLDenominacion.Denominacion=TotalDenominacion
TotalDenominacion=(Fin)
