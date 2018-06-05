
[Forma]
Clave=DineroDenominacion
Icono=0
CarpetaPrincipal=DineroDenominacion
Modulos=(Todos)
Nombre=Denominaciones

ListaCarpetas=DineroDenominacion
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=620
PosicionInicialArriba=268
PosicionInicialAlturaCliente=326
PosicionInicialAncho=662
Totalizadores=S
ListaAcciones=Aceptar
PosicionSec1=259
Comentarios=Info.FormaPago
[DineroDenominacion]
Estilo=Hoja
Clave=DineroDenominacion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DineroDenominacion
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
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaFondoGris=S
FiltroGeneral=DineroDenominacion.ID = {Info.ID} AND DineroDenominacion.FormaPago =<T>{Info.Formapago}<T>
[DineroDenominacion.DineroDenominacion.Denominacion]
Carpeta=DineroDenominacion
Clave=DineroDenominacion.Denominacion
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[DineroDenominacion.DineroDenominacion.Cantidad]
Carpeta=DineroDenominacion
Clave=DineroDenominacion.Cantidad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[DineroDenominacion.Columnas]
Denominacion=138
Cantidad=70


















TotalDenominacion=97
Nombre=304
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
Totalizadores2=Asigna(Info.Cantidad2,Suma(DineroDenominacion:DineroDenominacion.Denominacion*DineroDenominacion:DineroDenominacion.Cantidad))   Info.Cantidad2
Totalizadores3=(Monetario)
Totalizadores=S
TotAlCambiar=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total
CarpetaVisible=S

TotCarpetaRenglones=DineroDenominacion
TotExpresionesEnSumas=S
ExpAlRefrescar=Asigna(Info.Cantidad2, SumaTotal(DineroDenominacion:DineroDenominacion.Cantidad*DineroDenominacion:DineroDenominacion.Denominacion))
[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata


[DineroDenominacion.TotalDenominacion]
Carpeta=DineroDenominacion
Clave=TotalDenominacion
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




















[DineroDenominacion.DineroDenominacion.Nombre]
Carpeta=DineroDenominacion
Clave=DineroDenominacion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[DineroDenominacion.ListaEnCaptura]
(Inicio)=DineroDenominacion.Cantidad
DineroDenominacion.Cantidad=DineroDenominacion.Nombre
DineroDenominacion.Nombre=DineroDenominacion.Denominacion
DineroDenominacion.Denominacion=TotalDenominacion
TotalDenominacion=(Fin)
