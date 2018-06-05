
[Forma]
Clave=MesInvTransferSerieLote
Icono=0
Modulos=(Todos)
Nombre=Serie/Lote
MovModulo=(Todos)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=1864
PosicionInicialArriba=207
PosicionInicialAlturaCliente=316
PosicionInicialAncho=289
ListaAcciones=Aceptar
Totalizadores=S
PosicionSec1=255
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MesInvTransferSerieLote
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
FiltroGeneral=MesInvTransferSerieLote.Usuario = <T>{Usuario}<T> AND<BR>MesInvTransferSerieLote.ID = {Info.ID}
FiltroRespetar=S
FiltroTipo=General
[Lista.MesInvTransferSerieLote.SerieLote]
Carpeta=Lista
Clave=MesInvTransferSerieLote.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MesInvTransferSerieLote.Cantidad]
Carpeta=Lista
Clave=MesInvTransferSerieLote.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
SerieLote=159
Cantidad=75

Existencia=75
Fecha1=97
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
Totalizadores2=Redondea(Suma(MesInvTransferSerieLote:MesInvTransferSerieLote.Cantidad), 4) & <T>/<T> & Redondea(Info.Cantidad, 4)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
ListaEnCaptura=Total

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
Efectos=[Negritas]

[Lista.ListaEnCaptura]
(Inicio)=MesInvTransferSerieLote.SerieLote
MesInvTransferSerieLote.SerieLote=MesInvTransferSerieLote.Cantidad
MesInvTransferSerieLote.Cantidad=(Fin)
