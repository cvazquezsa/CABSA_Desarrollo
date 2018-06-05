[Forma]
Clave=SerieLoteMovProp
Nombre=Info.ArtTipo+<T>s del Artículo: <T>+Info.Articulo+Si(Info.ArtTipo=TipoPartida,<T> - <T>+Info.SubCuenta)
Icono=5
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=619
PosicionInicialArriba=300
PosicionInicialAltura=441
PosicionInicialAncho=441
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
PosicionInicialAlturaCliente=415
ExpresionesAlMostrar=Asigna(Info.Propiedades, Nulo)
PosicionSec1=352

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
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
ValidarCampos=S
FiltroGeneral=SerieLoteMov.Empresa   = <T>{Empresa}<T>       AND<BR>SerieLoteMov.Modulo    = <T>{Info.Modulo}<T>   AND<BR>SerieLoteMov.ID        = {Info.ID}         AND<BR>SerieLoteMov.RenglonID = {Info.RenglonID}  AND<BR>SerieLoteMov.Articulo  = <T>{Info.Articulo}<T> AND<BR>SerieLoteMov.SubCuenta = <T>{Info.SubCuenta}<T>

[Lista.SerieLoteMov.SerieLote]
Carpeta=Lista
Clave=SerieLoteMov.SerieLote
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
IgnoraFlujo=S

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
SerieLote=153
Propiedades=124
Cantidad=60
CantidadAlterna=59
Cliente=68
Localizacion=65
Importe=85
PropiedadesSalida=154
Propiedades_1=141

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
Totalizadores1=Total<BR>Metros
Totalizadores2=Redondea(Suma(SerieLoteMov:SerieLoteMov.Cantidad), 4) & <T>/<T> & Redondea(Info.Cantidad, 4)<BR>Suma(SerieLoteMov:SerieLoteMov.CantidadAlterna)
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

[Acciones.Eliminar.sp]
Nombre=sp
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spSeriesLotesMayoreoLimpiar :tEmpresa, :tModulo, :nID, :nRenglonID, :tArticulo, :tSubCuenta<T>, Empresa, Info.Modulo, Info.ID, Info.RenglonID, Info.Articulo, Info.SubCuenta)

[Acciones.Eliminar.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.SerieLoteInfo]
Nombre=SerieLoteInfo
Boton=34
NombreDesplegar=&Información
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=SerieLoteInfo
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
NombreEnBoton=S
AntesExpresiones=Asigna(Info.SerieLote, SerieLoteMov:SerieLoteMov.SerieLote)

[Acciones.Eliminar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Lista.SerieLoteMov.Cantidad]
Carpeta=Lista
Clave=SerieLoteMov.Cantidad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SerieLoteMov.CantidadAlterna]
Carpeta=Lista
Clave=SerieLoteMov.CantidadAlterna
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
ConCondicion=S
EjecucionConError=S
Antes=S
DespuesGuardar=S
Visible=S
EjecucionCondicion=Asigna(Info.SerieLote, ListaBuscarDuplicados(CampoEnLista(SerieLoteMov:SerieLoteMov.SerieLote)))<BR>Vacio(Info.SerieLote)
EjecucionMensaje=<T>Número: <T>+Info.SerieLote+<T> Duplicado<T>
AntesExpresiones=Asigna(Info.SumaSerieLote, Suma(Redondea(SerieLoteMov:SerieLoteMov.Cantidad, General.DecimalesCantidades)))<BR>Asigna(Info.SumaAlternaSerieLote, Suma(Redondea(SerieLoteMov:SerieLoteMov.CantidadAlterna, General.DecimalesCantidades)))

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=SerieLoteInfo
SerieLoteInfo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SerieLoteMov.SerieLote
SerieLoteMov.SerieLote=SerieLoteMov.Cantidad
SerieLoteMov.Cantidad=SerieLoteMov.CantidadAlterna
SerieLoteMov.CantidadAlterna=SerieLoteMov.Propiedades
SerieLoteMov.Propiedades=(Fin)
