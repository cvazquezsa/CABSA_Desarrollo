
[Forma]
Clave=NominaProrrateoD
Icono=0
BarraHerramientas=S
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Prorrateo
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=2

ListaAcciones=Aceptar
Comentarios=Info.Concepto
ListaCarpetas=Lista
CarpetaPrincipal=Lista
Totalizadores=S
PosicionInicialIzquierda=433
PosicionInicialArriba=208
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
PosicionSec1=214
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

ConCondicion=S
EjecucionCondicion=Suma(NominaProrrateoD:NominaProrrateoD.Porcentaje) = 100
EjecucionMensaje=<T>Suma de Porcentaje Incorrecto<T>
EjecucionConError=S
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Prorrateo
Clave=Lista
Filtros=S
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaProrrateoD
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

ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=NominaProrrateoD.Prorrateo = <T>{Info.Concepto}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
[Lista.ListaEnCaptura]
(Inicio)=NominaProrrateoD.Empresa
NominaProrrateoD.Empresa=NominaProrrateoD.CentroCostos
NominaProrrateoD.CentroCostos=NominaProrrateoD.Sucursal
NominaProrrateoD.Sucursal=NominaProrrateoD.Porcentaje
NominaProrrateoD.Porcentaje=(Fin)

[Lista.ListaOrden]
(Inicio)=NominaProrrateoD.Empresa	(Acendente)
NominaProrrateoD.Empresa	(Acendente)=NominaProrrateoD.CentroCostos	(Acendente)
NominaProrrateoD.CentroCostos	(Acendente)=NominaProrrateoD.Sucursal	(Acendente)
NominaProrrateoD.Sucursal	(Acendente)=(Fin)

[Lista.NominaProrrateoD.Empresa]
Carpeta=Lista
Clave=NominaProrrateoD.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.NominaProrrateoD.CentroCostos]
Carpeta=Lista
Clave=NominaProrrateoD.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.NominaProrrateoD.Sucursal]
Carpeta=Lista
Clave=NominaProrrateoD.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.NominaProrrateoD.Porcentaje]
Carpeta=Lista
Clave=NominaProrrateoD.Porcentaje
Editar=S
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
Totalizadores1=Total
Totalizadores2=Suma(NominaProrrateoD:NominaProrrateoD.Porcentaje)
Totalizadores3=(Cantidades)
Totalizadores=S
TotCarpetaRenglones=Lista
TotExpresionesEnSumas=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total
CarpetaVisible=S

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata

[Lista.Columnas]
Empresa=45
CentroCostos=124
Sucursal=64
Porcentaje=64
