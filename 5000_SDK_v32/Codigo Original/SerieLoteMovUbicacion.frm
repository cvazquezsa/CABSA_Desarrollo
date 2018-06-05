[Forma]
Clave=SerieLoteMovUbicacion
Nombre=Info.ArtTipo+<T>s del Artículo: <T>+Info.Articulo+Si(Info.ArtTipo=TipoPartida,<T> - <T>+Info.SubCuenta)
Icono=5
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=288
PosicionInicialArriba=291
PosicionInicialAltura=441
PosicionInicialAncho=703
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
ExpresionesAlMostrar=Asigna(Info.Propiedades, Nulo)
PosicionInicialAlturaCliente=414
PosicionSec1=350

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SerieLoteMovUbicacion
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
SerieLote=153
Propiedades=116
Cantidad=60
CantidadAlterna=59
Ubicacion=54
Nombre=237

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
Antes=S
ConCondicion=S
EjecucionConError=S
DespuesGuardar=S
EjecucionCondicion=Asigna(Info.SerieLote, ListaBuscarDuplicados(CampoEnLista(SerieLoteMovUbicacion:SerieLoteMov.SerieLote)))<BR>Vacio(Info.SerieLote)
EjecucionMensaje=<T>Número: <T>+Info.SerieLote+<T> Duplicado<T>
AntesExpresiones=Asigna(Info.SumaSerieLote, Suma(SerieLoteMovUbicacion:SerieLoteMov.Cantidad))<BR>Asigna(Info.SumaAlternaSerieLote, Suma(SerieLoteMovUbicacion:SerieLoteMov.CantidadAlterna))

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
Totalizadores2=Suma(SerieLoteMovUbicacion:SerieLoteMov.Cantidad) & <T>/<T> & Info.Cantidad<BR>Suma(SerieLoteMovUbicacion:SerieLoteMov.CantidadAlterna)
Totalizadores=S
TotCarpetaRenglones=Lista
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
Tamano=12
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
NombreEnBoton=S
AntesExpresiones=Asigna(Info.SerieLote, SerieLoteMovUbicacion:SerieLoteMov.SerieLote)

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
ListaParametros1=SerieLoteMovUbicacion:SerieLoteMov.SerieLote
ListaParametros=S
Activo=S
Visible=S
EspacioPrevio=S

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

[Lista.SerieLoteMov.Ubicacion]
Carpeta=Lista
Clave=SerieLoteMov.Ubicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteEnviarA.Nombre]
Carpeta=Lista
Clave=CteEnviarA.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Asistente
Asistente=Eliminar
Eliminar=SerieLoteInfo
SerieLoteInfo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SerieLoteMov.SerieLote
SerieLoteMov.SerieLote=SerieLoteMov.Cantidad
SerieLoteMov.Cantidad=SerieLoteMov.CantidadAlterna
SerieLoteMov.CantidadAlterna=SerieLoteMov.Propiedades
SerieLoteMov.Propiedades=SerieLoteMov.Ubicacion
SerieLoteMov.Ubicacion=CteEnviarA.Nombre
CteEnviarA.Nombre=(Fin)
