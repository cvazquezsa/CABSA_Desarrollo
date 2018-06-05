
[Forma]
Clave=MFAContLista
Icono=0
Modulos=(Todos)
Nombre=Pólizas

ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=407
PosicionInicialArriba=119
PosicionInicialAlturaCliente=451
PosicionInicialAncho=551
[Lista]
Estilo=Iconos
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAContLista
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Empresa<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

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
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Registros

Filtros=S
FiltroPredefinido=S
FiltroGrupo1=MFAContLista.Mov
FiltroValida1=MFAContLista.Mov
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroTodoFinal=S
IconosConPaginas=S
IconosNombre=MFAContLista:MFAContLista.Empresa
FiltroGeneral=MFAContLista.Empresa = {Comillas(Empresa)}
[Lista.MFAContLista.Modulo]
Carpeta=Lista
Clave=MFAContLista.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFAContLista.ID]
Carpeta=Lista
Clave=MFAContLista.ID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFAContLista.Mov]
Carpeta=Lista
Clave=MFAContLista.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFAContLista.MovID]
Carpeta=Lista
Clave=MFAContLista.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFAContLista.Ejercicio]
Carpeta=Lista
Clave=MFAContLista.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFAContLista.Periodo]
Carpeta=Lista
Clave=MFAContLista.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.Columnas]
0=-2
1=-2
2=-2
3=-2
4=-2
5=-2
6=-2







[Lista.ListaEnCaptura]
(Inicio)=MFAContLista.Modulo
MFAContLista.Modulo=MFAContLista.ID
MFAContLista.ID=MFAContLista.Mov
MFAContLista.Mov=MFAContLista.MovID
MFAContLista.MovID=MFAContLista.Ejercicio
MFAContLista.Ejercicio=MFAContLista.Periodo
MFAContLista.Periodo=(Fin)
