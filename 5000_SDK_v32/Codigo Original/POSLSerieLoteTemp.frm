[Forma]
Clave=POSLSerieLoteTemp
Nombre=Info.ArtTipo+<T>s del Artículo: <T>+Info.Articulo+Si(Info.ArtTipo=TipoPartida,<T> - <T>+Info.SubCuenta)
Icono=5
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=579
PosicionInicialArriba=193
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
PosicionSec1=372

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSLSerieLoteTemp
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



FiltroGeneral=POSLSerieLoteTemp.ID       = <T>{Info.IDTexto}<T>   AND<BR>POSLSerieLoteTemp.RenglonID = {Info.RenglonID}  AND<BR>POSLSerieLoteTemp.Articulo  = <T>{Info.Articulo}<T> AND<BR>POSLSerieLoteTemp.Estacion = {EstacionTrabajo}
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

Existencia=75
Fecha1=97
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
Totalizadores2=Redondea(Suma(POSLSerieLoteTemp:POSLSerieLoteTemp.Cantidad), 4) & <T>/<T> & Redondea(Info.Cantidad, 4)
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

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Borrar todo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Multiple=S
ConfirmarAntes=S
ListaAccionesMultiples=(Lista)

[Acciones.Eliminar.sp]
Nombre=sp
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spPOSSerieLoteLimpiar :nEstacion, :tID, :nRenglonID, :tArticulo, :tSubCuenta<T>, EstacionTrabajo, POSLSerieLoteTemp:POSLSerieLoteTemp.ID,POSLSerieLoteTemp:POSLSerieLoteTemp.RenglonID,POSLSerieLoteTemp:POSLSerieLoteTemp.Articulo,POSLSerieLoteTemp:POSLSerieLoteTemp.SubCuenta)
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

AntesExpresiones=Asigna(Info.SerieLote, POSLSerieLoteTemp:POSLSerieLoteTemp.SerieLote)
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
ListaParametros1=POSLSerieLoteTemp:POSLSerieLoteTemp.SerieLote
ListaParametros=S
Visible=S
EspacioPrevio=S



ActivoCondicion=no Info.LotesFijos
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



Multiple=S
ListaAccionesMultiples=(Lista)
EjecucionCondicion=Asigna(Info.SerieLote, ListaBuscarDuplicados(CampoEnLista(POSLSerieLoteTemp:POSLSerieLoteTemp.SerieLote)))<BR>Vacio(Info.SerieLote)
EjecucionMensaje=<T>Número: <T>+Info.SerieLote+<T> Duplicado<T>
AntesExpresiones=Asigna(Info.SumaSerieLote, Suma(POSLSerieLoteTemp:POSLSerieLoteTemp.Cantidad))<BR>Asigna(Info.SerieLote, POSLSerieLoteTemp:POSLSerieLoteTemp.SerieLote)
[Lista.POSLSerieLoteTemp.SerieLote]
Carpeta=Lista
Clave=POSLSerieLoteTemp.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.POSLSerieLoteTemp.Cantidad]
Carpeta=Lista
Clave=POSLSerieLoteTemp.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





























[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

ConCondicion=S
EjecucionConError=S
Expresion=EjecutarSQL(<T>spPOSInsertarPOSLSerieLote :nEstacion,:tID,:nRenglonID<T>,EstacionTrabajo,POSLSerieLoteTemp:POSLSerieLoteTemp.ID,POSLSerieLoteTemp:POSLSerieLoteTemp.RenglonID)
EjecucionCondicion=Info.SumaSerieLote = Info.Cantidad
EjecucionMensaje=<T>La cantidad de Series/Lotes debe de ser igual a la cantidad de articulos<T>
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S












[Acciones.Cancelar/Cancelar Cambios]
Nombre=Cancelar/Cancelar Cambios
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S





EspacioPrevio=S

























[Lista.ListaEnCaptura]
(Inicio)=POSLSerieLoteTemp.SerieLote
POSLSerieLoteTemp.SerieLote=POSLSerieLoteTemp.Cantidad
POSLSerieLoteTemp.Cantidad=(Fin)






[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)




[Acciones.Eliminar.ListaAccionesMultiples]
(Inicio)=Cancelar
Cancelar=sp
sp=Actualizar Forma
Actualizar Forma=(Fin)









[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar/Cancelar Cambios
Cancelar/Cancelar Cambios=Asistente
Asistente=Eliminar
Eliminar=SerieLoteInfo
SerieLoteInfo=(Fin)
