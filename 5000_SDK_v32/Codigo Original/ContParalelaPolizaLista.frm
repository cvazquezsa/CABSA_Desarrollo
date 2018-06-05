
[Forma]
Clave=ContParalelaPolizaLista
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Contabilidad - Movimientos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Seleccionar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
Comentarios=Lista(Info.Ejercicio, Info.Periodo)
PosicionInicialIzquierda=310
PosicionInicialArriba=101
PosicionInicialAlturaCliente=487
PosicionInicialAncho=746
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContParalelaPolizaLista
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S



BusquedaRapidaControles=S
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroSucursales=S
FiltroListaEstatus=CONCLUIDO
FiltroEstatusDefault=CONCLUIDO
FiltroUsuarioDefault=(Usuario)
FiltroFechasCampo=ContParalelaPoliza.FechaEmision
FiltroFechasDefault=Este Mes
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
ListaEnCaptura=(Lista)
BusquedaRapida=S
BusquedaEnLinea=S
IconosNombre=ContParalelaPolizaLista:ContParalelaPoliza.Mov+<T> <T>+ContParalelaPolizaLista:ContParalelaPoliza.MovID
FiltroGeneral=ContParalelaPoliza.IDEmpresa = <T>{Info.Empresa}<T> AND ContParalelaPoliza.Mov = <T>{Info.Mov}<T> AND ContParalelaPoliza.Ejercicio = {Info.Ejercicio} AND ContParalelaPoliza.Periodo = {Info.Periodo}
[Lista.Columnas]
0=94

1=-2
2=-2
3=-2
4=-2
5=-2

[Lista.ContParalelaPoliza.FechaEmision]
Carpeta=Lista
Clave=ContParalelaPoliza.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ContParalelaPoliza.Concepto]
Carpeta=Lista
Clave=ContParalelaPoliza.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ContParalelaPoliza.OrigenTipo]
Carpeta=Lista
Clave=ContParalelaPoliza.OrigenTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.ContParalelaPoliza.Origen]
Carpeta=Lista
Clave=ContParalelaPoliza.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ContParalelaPoliza.OrigenID]
Carpeta=Lista
Clave=ContParalelaPoliza.OrigenID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Lista.ListaEnCaptura]
(Inicio)=ContParalelaPoliza.FechaEmision
ContParalelaPoliza.FechaEmision=ContParalelaPoliza.Concepto
ContParalelaPoliza.Concepto=ContParalelaPoliza.OrigenTipo
ContParalelaPoliza.OrigenTipo=ContParalelaPoliza.Origen
ContParalelaPoliza.Origen=ContParalelaPoliza.OrigenID
ContParalelaPoliza.OrigenID=(Fin)
