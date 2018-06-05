[Forma]
Clave=SerieLoteMov
Nombre=Info.ArtTipo+<T>s del Artículo: <T>+Info.Articulo+Si(Info.ArtTipo=TipoPartida,<T> - <T>+Info.SubCuenta)
Icono=5
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=462
PosicionInicialArriba=126
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
PosicionInicialAlturaCliente=436
SinTransacciones=S
Comentarios=Lista(Filtro.Espacio, Info.Tarima)
ExpresionesAlMostrar=Asigna(Info.Propiedades, Nulo)<BR>Asigna(Info.LotesFijos, SQL(<T>spSugerirSerieLoteMov :tEmpresa, :tModulo, :nID, :tMovTipo, :tAlm, :nRenglonID, :tArt, :tSub, :nSuc, :nCantidad, :nPaquete<T>, Empresa, Info.Modulo, Info.ID, Info.MovTipo, Info.Almacen, Info.RenglonID, Info.Articulo, Info.SubCuenta, Sucursal, Info.Cantidad, Info.Paquete))
ExpresionesAlCerrar=Asigna(Info.LotesFijos, Falso)<BR>Asigna(Filtro.Espacio, Nulo)
PosicionSec1=372

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

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Borrar todo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
RefrescarDespues=
Multiple=S
ConfirmarAntes=S
ListaAccionesMultiples=Cancelar<BR>sp<BR>Actualizar Forma
EspacioPrevio=

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
AntesExpresiones=Asigna(Info.SerieLote, SerieLoteMov:SerieLoteMov.SerieLote)

[Acciones.Eliminar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Asistente]
Nombre=Asistente
Boton=12
NombreEnBoton=S
NombreDesplegar=A&sistente
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Wizards
ClaveAccion=Asistente Series/Lotes
ListaParametros1=SerieLoteMov:SerieLoteMov.SerieLote
ListaParametros=S
Visible=S
EspacioPrevio=S

ActivoCondicion=(no Info.LotesFijos) y (Info.Modulo <> <T>TMA<T>)
[Lista.SerieLoteMov.Cantidad]
Carpeta=Lista
Clave=SerieLoteMov.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.SerieLoteMov.CantidadAlterna]
Carpeta=Lista
Clave=SerieLoteMov.CantidadAlterna
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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
AntesExpresiones=Asigna(Info.SumaSerieLote, Suma(SerieLoteMov:SerieLoteMov.Cantidad))<BR>Asigna(Info.SumaAlternaSerieLote, Suma(SerieLoteMov:SerieLoteMov.CantidadAlterna))<BR>Asigna(Info.SerieLote, SerieLoteMov:SerieLoteMov.SerieLote)
[Acciones.Rango]
Nombre=Rango
Boton=11
NombreEnBoton=S
NombreDesplegar=Asistente &Rangos
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S




Expresion=Si<BR>  Forma(<T>SerieLoteRango<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spSerieLoteRango :tEmpresa, :nSucursal, :tModulo, :nID, :nRenglonID, :tArticulo, :tSubCuenta, :tSerieLote, :nCantidad<T>, Empresa, Sucursal, Info.Modulo, Info.ID, Info.RenglonID, Info.Articulo, Info.SubCuenta, Info.SerieLote, Info.Cantidad)<BR>  Forma.ActualizarVista<BR>Fin
ActivoCondicion=(Info.Modulo <> <T>TMA<T>)

[Lista.SerieLoteMov.Tarima]
Carpeta=Lista
Clave=SerieLoteMov.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco








[Acciones.Eliminar.ListaAccionesMultiples]
(Inicio)=Cancelar
Cancelar=sp
sp=Actualizar Forma
Actualizar Forma=(Fin)








[Lista.ListaEnCaptura]
(Inicio)=SerieLoteMov.SerieLote
SerieLoteMov.SerieLote=SerieLoteMov.Cantidad
SerieLoteMov.Cantidad=SerieLoteMov.CantidadAlterna
SerieLoteMov.CantidadAlterna=SerieLoteMov.Propiedades
SerieLoteMov.Propiedades=SerieLoteMov.Tarima
SerieLoteMov.Tarima=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Asistente
Asistente=Rango
Rango=Eliminar
Eliminar=SerieLoteInfo
SerieLoteInfo=(Fin)
