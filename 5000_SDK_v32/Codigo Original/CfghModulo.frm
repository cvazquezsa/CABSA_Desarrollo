
[Forma]
Clave=CfghModulo
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Configuración Histórico Módulos

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=2068
PosicionInicialArriba=48
PosicionInicialAlturaCliente=261
PosicionInicialAncho=503
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionCol1=248
PosicionSec1=164
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfghModulo
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
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General


GuardarAlSalir=S
HojaColorFondo=Plata
FiltroGeneral=CfghModulo.Nombre in (<T>Ventas<T>, <T>Compras<T>, <T>Nomina<T>, <T>Cuentas por Cobrar<T>, <T>Cuentas por Pagar<T>, <T>Asistencias<T>)
[Lista.Columnas]
Modulo=68
Nombre=304














[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S

GuardarAntes=S
ClaveAccion=Aceptar
[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S



EspacioPrevio=S









[Detalle]
Estilo=Ficha
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CfghModulo
Fuente={Tahoma, 8, Negro, []}

CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S


ListaEnCaptura=(Lista)


FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S




PermiteEditar=S
[Detalle.Columnas]
Hist=64



















[Lista.CfghModulo.Modulo]
Carpeta=Lista
Clave=CfghModulo.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.CfghModulo.Nombre]
Carpeta=Lista
Clave=CfghModulo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco







[Detalle.CfghModulo.Hist]
Carpeta=Detalle
Clave=CfghModulo.Hist
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=50
[Detalle.CfghModulo.HistMin]
Carpeta=Detalle
Clave=CfghModulo.HistMin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

Pegado=S
[Detalle.CfghModulo.HistMinUnidad]
Carpeta=Detalle
Clave=CfghModulo.HistMinUnidad
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco



Pegado=S
[Detalle.LlaveLocal]
(Inicio)=CfghModulo.Modulo
CfghModulo.Modulo=CfghModulo.Nombre
CfghModulo.Nombre=(Fin)

[Detalle.LlaveMaestra]
(Inicio)=CfghModulo.Modulo
CfghModulo.Modulo=CfghModulo.Nombre
CfghModulo.Nombre=(Fin)














[Acciones.CrearTrabajo]
Nombre=CrearTrabajo
Boton=76
NombreEnBoton=S
NombreDesplegar=Crear Trabajo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
Activo=S
Visible=S









ClaveAccion=HistTrabajo

















[Detalle.ListaEnCaptura]
(Inicio)=CfghModulo.Hist
CfghModulo.Hist=CfghModulo.HistMin
CfghModulo.HistMin=CfghModulo.HistMinUnidad
CfghModulo.HistMinUnidad=(Fin)




















[Acciones.SysTablaHist]
Nombre=SysTablaHist
Boton=55
NombreDesplegar=Tablas Historico
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SysTablaHist
Visible=S





NombreEnBoton=S
Antes=S






ActivoCondicion=CfghModulo:CfghModulo.Hist
AntesExpresiones=Asigna( Info.Modulo, CfghModulo:CfghModulo.Modulo )




















































[Lista.ListaEnCaptura]
(Inicio)=CfghModulo.Modulo
CfghModulo.Modulo=CfghModulo.Nombre
CfghModulo.Nombre=(Fin)





[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=CrearTrabajo
CrearTrabajo=SysTablaHist
SysTablaHist=(Fin)
