
[Forma]
Clave=EmbarqueDArtMovVCI
Icono=0
Modulos=(Todos)
Nombre=Info.Mov & <T> <T> & Info.MovID & <T> - Detalle por movimiento<T>

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=480
PosicionInicialAncho=1016
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=132
PosicionInicialArriba=114
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov,Info.MovID)
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmbarqueDArtMovVCI
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Articulo<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S
IconosConSenales=S

FiltroPredefinido=S
FiltroGrupo1=EmbarqueDArtMovVCI.ModuloNombre
FiltroValida1=EmbarqueDArtMovVCI.ModuloNombre
FiltroGrupo2=EmbarqueDArtMovVCI.Mov
FiltroValida2=EmbarqueDArtMovVCI.Mov
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
BusquedaRapidaControles=S
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
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
PestanaOtroNombre=S
PestanaNombre=Registros
IconosNombre=EmbarqueDArtMovVCI:EmbarqueDArtMovVCI.Articulo
FiltroGeneral=EmbarqueDArtMovVCI.ID = {Info.ID}
[Lista.EmbarqueDArtMovVCI.SubCuenta]
Carpeta=Lista
Clave=EmbarqueDArtMovVCI.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.EmbarqueDArtMovVCI.Descripcion]
Carpeta=Lista
Clave=EmbarqueDArtMovVCI.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.EmbarqueDArtMovVCI.Cantidad]
Carpeta=Lista
Clave=EmbarqueDArtMovVCI.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.EmbarqueDArtMovVCI.CantidadTotal]
Carpeta=Lista
Clave=EmbarqueDArtMovVCI.CantidadTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.EmbarqueDArtMovVCI.ImporteTotal]
Carpeta=Lista
Clave=EmbarqueDArtMovVCI.ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.Columnas]
0=65
1=97
2=137
3=78
4=106
5=110






6=-2
7=-2
8=-2
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.Excel]
Nombre=Excel
Boton=115
NombreEnBoton=S
NombreDesplegar=&Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S


[Acciones.VistaPrevia]
Nombre=VistaPrevia
Boton=6
NombreEnBoton=S
NombreDesplegar=&Presentación Preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S


EspacioPrevio=S
[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=&Personalizar vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

























[Lista.EmbarqueDArtMovVCI.ModuloNombre]
Carpeta=Lista
Clave=EmbarqueDArtMovVCI.ModuloNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.EmbarqueDArtMovVCI.Mov]
Carpeta=Lista
Clave=EmbarqueDArtMovVCI.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco


















[Lista.EmbarqueDArtMovVCI.Importe]
Carpeta=Lista
Clave=EmbarqueDArtMovVCI.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco












[Lista.ListaEnCaptura]
(Inicio)=EmbarqueDArtMovVCI.SubCuenta
EmbarqueDArtMovVCI.SubCuenta=EmbarqueDArtMovVCI.Descripcion
EmbarqueDArtMovVCI.Descripcion=EmbarqueDArtMovVCI.Cantidad
EmbarqueDArtMovVCI.Cantidad=EmbarqueDArtMovVCI.Importe
EmbarqueDArtMovVCI.Importe=EmbarqueDArtMovVCI.CantidadTotal
EmbarqueDArtMovVCI.CantidadTotal=EmbarqueDArtMovVCI.ImporteTotal
EmbarqueDArtMovVCI.ImporteTotal=EmbarqueDArtMovVCI.ModuloNombre
EmbarqueDArtMovVCI.ModuloNombre=EmbarqueDArtMovVCI.Mov
EmbarqueDArtMovVCI.Mov=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=SINCRO
SINCRO=VIGENTE
VIGENTE=PROCESAR
PROCESAR=CANCELADO
CANCELADO=CONCLUIDO
CONCLUIDO=SINAFECTAR
SINAFECTAR=BORRADOR
BORRADOR=CONFIRMAR
CONFIRMAR=AUTORIZAR
AUTORIZAR=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Excel
Excel=VistaPrevia
VistaPrevia=Personalizar
Personalizar=(Fin)
