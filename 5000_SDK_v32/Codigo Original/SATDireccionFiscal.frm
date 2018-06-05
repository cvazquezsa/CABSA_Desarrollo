
[Forma]
Clave=SATDireccionFiscal
Icono=4
BarraHerramientas=S
Modulos=(Todos)
Nombre=Direcciones Fiscales
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=Seleccionar
PosicionInicialIzquierda=178
PosicionInicialArriba=165
PosicionInicialAlturaCliente=469
PosicionInicialAncho=1058
VentanaExclusiva=S
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Registros
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATDireccionFiscal
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S

ListaOrden=SATCatCP.ClaveCP<TAB>(Acendente)
FiltroPredefinido=S
FiltroGrupo1=SATPais.Descripcion
FiltroGrupo2=SATEstado.Descripcion
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=25
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=25
BusquedaEnLinea=S
FiltroTodo=S
FiltroNull=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática

BusquedaRespetarFiltros=S




FiltroGrupo3=SATMunicipio.Descripcion
FiltroGrupo4=SATColonia.Descripcion
FiltroGrupo5=SATCatCP.ClaveCP
[Lista.Columnas]
ClaveMunicipio=83
MunicipioDescripcion=139
ClaveLocalidad=89
LocalidadDescripcion=133
ClaveColonia=78
ColoniaDescripcion=266
HusoHorario=63
Descripcion=118
VeranoMesInicio=82
VeranoDiaInicio=95
VeranoHoraInicio=99
VeranoDiferenciaHoraria=131
InviernoMesInicio=88
InviernoDiaInicio=100
InviernoHoraInicio=110
InviernoDiferenciaHoraria=127





ClaveCP=77

ClavePais=81
PaisDescripcion=604
ClaveEstado=88
EstadoDescripcion=604
Descripcion_1=102
Descripcion_2=132
SATCatCP.ClaveCP=104
SATCatCP.ClaveMunicipio=82
SATMunicipio.Descripcion=123
SATCatCP.ClaveLocalidad=83
SATLocalidad.Descripcion=137
SATColonia.ClaveColonia=82
SATColonia.Descripcion=296
SATEstado.Descripcion=129
[Lista.SATCatCP.ClaveCP]
Carpeta=Lista
Clave=SATCatCP.ClaveCP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco































[Lista.SATMunicipio.Descripcion]
Carpeta=Lista
Clave=SATMunicipio.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco




[Lista.SATColonia.Descripcion]
Carpeta=Lista
Clave=SATColonia.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco



[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Antes=S
Visible=S












ConCondicion=S
EjecucionCondicion=ConDatos(SATDireccionFiscal:SATCatCP.ClaveCP)
AntesExpresiones=Asigna(Info.Copiar, Verdadero)<BR>Asigna(Info.CodigoPostal, SATDireccionFiscal:SATCatCP.ClaveCP)<BR>Asigna(Info.Colonia, SATDireccionFiscal:SATColonia.Descripcion)<BR>Asigna(Info.Delegacion, SATDireccionFiscal:SATMunicipio.Descripcion)<BR>Asigna(Info.Estado, SATDireccionFiscal:SATEstado.Descripcion)<BR>Asigna(Info.Pais, SATDireccionFiscal:SATPais.Descripcion)<BR>Asigna(Info.Ruta, Nulo)<BR>Asigna(Info.Localidad, SATDireccionFiscal:SATLocalidad.Descripcion)<BR>Asigna(Afectar.ID, SATDireccionFiscal:SATCatCP.ID)
[Lista.SATEstado.Descripcion]
Carpeta=Lista
Clave=SATEstado.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[Lista.SATLocalidad.Descripcion]
Carpeta=Lista
Clave=SATLocalidad.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco





[Lista.ListaEnCaptura]
(Inicio)=SATEstado.Descripcion
SATEstado.Descripcion=SATMunicipio.Descripcion
SATMunicipio.Descripcion=SATColonia.Descripcion
SATColonia.Descripcion=SATCatCP.ClaveCP
SATCatCP.ClaveCP=SATLocalidad.Descripcion
SATLocalidad.Descripcion=(Fin)
