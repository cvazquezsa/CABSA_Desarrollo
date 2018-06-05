
[Forma]
Clave=ContParalelaContLista
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
Comentarios=Info.Mov
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
Vista=ContParalelaContLista
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
FiltroUsuarios=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroSucursales=S
FiltroListaEstatus=CONCLUIDO
FiltroEstatusDefault=CONCLUIDO
FiltroUsuarioDefault=(Usuario)
FiltroFechasCampo=Cont.FechaEmision
FiltroFechasDefault=Este Mes
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
ListaEnCaptura=(Lista)
IconosNombre=ContParalelaContLista:Cont.Mov+<T> <T>+ContParalelaContLista:Cont.MovID
FiltroGeneral=Cont.Empresa = <T>{Empresa}<T> AND Cont.Mov = <T>{Info.Mov}<T> AND Cont.FechaEmision BETWEEN <T>{FechaFormatoServidor(Info.FechaD)}<T> AND <T>{FechaFormatoServidor(Info.FechaA)}<T>
BusquedaRapida=S
BusquedaEnLinea=S
[Lista.Columnas]
0=94

1=-2
2=-2
3=-2
4=-2
5=-2

[Lista.Cont.FechaEmision]
Carpeta=Lista
Clave=Cont.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Cont.Concepto]
Carpeta=Lista
Clave=Cont.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Cont.OrigenTipo]
Carpeta=Lista
Clave=Cont.OrigenTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Cont.Origen]
Carpeta=Lista
Clave=Cont.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Cont.OrigenID]
Carpeta=Lista
Clave=Cont.OrigenID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=Cont.FechaEmision
Cont.FechaEmision=Cont.Concepto
Cont.Concepto=Cont.OrigenTipo
Cont.OrigenTipo=Cont.Origen
Cont.Origen=Cont.OrigenID
Cont.OrigenID=(Fin)
