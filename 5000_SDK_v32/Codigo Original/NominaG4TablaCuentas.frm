
[Forma]
Clave=NominaG4TablaCuentas
Icono=0
Modulos=(Todos)
Nombre=Tabla Cuentas
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=1870
PosicionInicialArriba=0
PosicionInicialAlturaCliente=367
PosicionInicialAncho=912
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaExclusiva=S
VentanaExclusivaOpcion=0
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaG4TablaCuentas
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S
BusquedaRapidaControles=S


FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroGeneral=NominaG4TablaCuentas.Clave = <T>{Info.Clave}<T> AND NominaG4TablaCuentas.Objeto = <T>{Info.Dato}<T> AND NominaG4TablaCuentas.IDNomX = {Info.ID} AND NominaG4TablaCuentas.TipoAgrupador = <T>{Info.Grupo}<T>
[Lista.NominaG4TablaCuentas.Valor]
Carpeta=Lista
Clave=NominaG4TablaCuentas.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.NominaG4TablaCuentas.Cuenta]
Carpeta=Lista
Clave=NominaG4TablaCuentas.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[Lista.Columnas]
Valor=209
Cuenta=171






Clave=203
Objeto=184
TipoAgrupador=97
IDNomX=74
[Lista.ListaCamposAValidar]
(Inicio)=NominaG4TablaCuentas.Clave
NominaG4TablaCuentas.Clave=NominaG4TablaCuentas.Objeto
NominaG4TablaCuentas.Objeto=NominaG4TablaCuentas.TipoAgrupador
NominaG4TablaCuentas.TipoAgrupador=(Fin)


[Lista.NominaG4TablaCuentas.Clave]
Carpeta=Lista
Clave=NominaG4TablaCuentas.Clave
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
Efectos=[Negritas]

[Lista.NominaG4TablaCuentas.Objeto]
Carpeta=Lista
Clave=NominaG4TablaCuentas.Objeto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
Efectos=[Negritas]


[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S



[Acciones.Cancelar]
Nombre=Cancelar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S


[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S





















[Lista.NominaG4TablaCuentas.IDNomX]
Carpeta=Lista
Clave=NominaG4TablaCuentas.IDNomX
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=$FFFFFFFF
Efectos=[Negritas]



[Lista.NominaG4TablaCuentas.TipoAgrupador]
Carpeta=Lista
Clave=NominaG4TablaCuentas.TipoAgrupador
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata





Efectos=[Negritas]

[Lista.ListaEnCaptura]
(Inicio)=NominaG4TablaCuentas.Clave
NominaG4TablaCuentas.Clave=NominaG4TablaCuentas.Objeto
NominaG4TablaCuentas.Objeto=NominaG4TablaCuentas.IDNomX
NominaG4TablaCuentas.IDNomX=NominaG4TablaCuentas.TipoAgrupador
NominaG4TablaCuentas.TipoAgrupador=NominaG4TablaCuentas.Valor
NominaG4TablaCuentas.Valor=NominaG4TablaCuentas.Cuenta
NominaG4TablaCuentas.Cuenta=(Fin)







[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cancelar
Cancelar=Nuevo
Nuevo=(Fin)
