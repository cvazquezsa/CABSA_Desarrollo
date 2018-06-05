[Forma]
Clave=SerieLoteMovInfo
Nombre=Info.ArtTipo+<T>s del Artículo: <T>+Info.Articulo+Si(Info.ArtTipo=TipoPartida,<T> - <T>+Info.SubCuenta)
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=732
PosicionInicialArriba=374
PosicionInicialAltura=443
PosicionInicialAncho=456
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
Totalizadores=S
PosicionSeccion1=91
VentanaEscCerrar=S
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=416
ExpresionesAlMostrar=Asigna(Info.Propiedades, Nulo)
PosicionSec1=353
Comentarios=Info.Tarima

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SerieLoteMov
Fuente={Fixedsys, 9, Negro, []}
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
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
ConFuenteEspecial=S
OtroOrden=S
ListaOrden=SerieLoteMov.SerieLote<TAB>(Acendente)
FiltroGeneral=SerieLoteMov.Empresa   = <T>{Empresa}<T>       AND<BR>SerieLoteMov.Modulo    = <T>{Info.Modulo}<T>   AND<BR>SerieLoteMov.ID        = {Info.ID}         AND<BR>SerieLoteMov.RenglonID = {Info.RenglonID}  AND<BR>SerieLoteMov.Articulo  = <T>{Info.Articulo}<T> AND<BR>SerieLoteMov.SubCuenta = <T>{Info.SubCuenta}<T>

[Lista.SerieLoteMov.SerieLote]
Carpeta=Lista
Clave=SerieLoteMov.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SerieLoteMov.Propiedades]
Carpeta=Lista
Clave=SerieLoteMov.Propiedades
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
IgnoraFlujo=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
SerieLote=162
Propiedades=127
Cantidad=65
CantidadAlterna=60
Importe=84
PropiedadesSalida=154
Propiedades_1=131

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Total
Totalizadores2=Redondea(Suma(SerieLoteMov:SerieLoteMov.Cantidad), 4) & <T>/<T> & Redondea(Info.Cantidad, 4)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total
CarpetaVisible=S
Totalizadores3=

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Acciones.SerieLoteInfo]
Nombre=SerieLoteInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=&Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SerieLoteInfo
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(SerieLoteMov:SerieLoteMov.SerieLote)
AntesExpresiones=Asigna(Info.SubCuenta, SerieLoteMov:SerieLoteMov.SubCuenta)<BR>Asigna(Info.SerieLote, SerieLoteMov:SerieLoteMov.SerieLote)

[Lista.SerieLoteMov.Cantidad]
Carpeta=Lista
Clave=SerieLoteMov.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SerieLoteMov.CantidadAlterna]
Carpeta=Lista
Clave=SerieLoteMov.CantidadAlterna
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=SerieLoteInfo
SerieLoteInfo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SerieLoteMov.SerieLote
SerieLoteMov.SerieLote=SerieLoteMov.Cantidad
SerieLoteMov.Cantidad=SerieLoteMov.CantidadAlterna
SerieLoteMov.CantidadAlterna=SerieLoteMov.Propiedades
SerieLoteMov.Propiedades=(Fin)
