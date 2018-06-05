[Forma]
Clave=POSCliente
Nombre=Clientes
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=2386
PosicionInicialArriba=202
PosicionInicialAltura=477
PosicionInicialAncho=988
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
MovModulo=CXC
PosicionInicialAlturaCliente=606
Comentarios=Si(no Usuario.ConsultarClientesOtrosAgentes, e(<T>Agente<T>)+<T>: <T>+Usuario.DefAgente)
PosicionSec1=300
PosicionCol1=430
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0

[Lista]
Estilo=Hoja
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCliente
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=30
CarpetaVisible=S
FiltroFechasNormal=S
PermiteLocalizar=S
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroSituacion=S
FiltroSituacionTodo=S
OtroOrden=S
ListaOrden=POSCliente.Cliente<TAB>(Acendente)

HojaMostrarSeleccionColoresEsp=S
HojaColoresPorCampo=S
HojaCampoColor=POSCliente.Estatus


HojaColorFondo=Plata
BusquedaLocal=S
CaracteresBusqueda=3
FuenteBusqueda={MS Sans Serif, 8, Negro, []}
[Lista.Columnas]
Cliente=117
Nombre=293
0=121
1=280
RFC=107

Codigo=184
Estatus=94
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreDesplegar=&Seleccionar
TipoAccion=Ventana
ClaveAccion=Seleccionar/Aceptar
Visible=S
Activo=S
NombreEnBoton=S
EnBarraHerramientas=S

Antes=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=POSCliente:POSCliente.Estatus = <T>ALTA<T>
EjecucionMensaje=<T>No se puede Generar Movimientos a este Cliente, Verifique...<T>
AntesExpresiones=Asigna(Info.Cliente,POSCliente:POSCliente.Cliente)
[Acciones.CteInfo]
Nombre=CteInfo
Boton=34
NombreDesplegar=&Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CteInfo
Antes=S
Visible=S
ConCondicion=S



ActivoCondicion=Usuario.CteInfo
EjecucionCondicion=ConDatos(POSCliente:POSCliente.Cliente) y ((POSCliente:POSCliente.Tipo<><T>Deudor<T>) o Usuario.VerInfoDeudores)
AntesExpresiones=Asigna(Info.Cliente, POSCliente:POSCliente.Cliente)
[Art.Art.Articulo]
Carpeta=Art
Clave=Art.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Art.Art.Descripcion1]
Carpeta=Art
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Art.Columnas]
Articulo=124
Descripcion1=184




[Lista.POSCliente.Cliente]
Carpeta=Lista
Clave=POSCliente.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.POSCliente.Nombre]
Carpeta=Lista
Clave=POSCliente.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.POSCliente.Codigo]
Carpeta=Lista
Clave=POSCliente.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.POSCliente.RFC]
Carpeta=Lista
Clave=POSCliente.RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco







[Lista.]
Carpeta=Lista
ColorFondo=Negro
















[Lista.ListaEnCaptura]
(Inicio)=POSCliente.Cliente
POSCliente.Cliente=POSCliente.Nombre
POSCliente.Nombre=POSCliente.Codigo
POSCliente.Codigo=POSCliente.RFC
POSCliente.RFC=POSCliente.Estatus
POSCliente.Estatus=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQ_AVISO
BLOQ_AVISO=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=CteInfo
CteInfo=(Fin)
