[Forma]
Clave=IntelisisSLHist
Icono=6
Modulos=(Todos)
Nombre=Histórico - Licencias del Cliente

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=290
PosicionInicialArriba=180
PosicionInicialAlturaCliente=372
PosicionInicialAncho=786
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Cliente
EsConsultaExclusiva=S
SinCondicionDespliege=S
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=IntelisisSLHist
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
BusquedaRapidaControles=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Fecha/Hora<T>
ElementosPorPagina=200
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=IntelisisSLHist.FechaHora
FiltroFechasDefault=Esta Semana
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
OtroOrden=S
ListaOrden=IntelisisSLHist.FechaHora<TAB>(Decendente)
PestanaOtroNombre=S
PestanaNombre=cambios
IconosNombre=IntelisisSLHist:IntelisisSLHist.FechaHora
FiltroGeneral=IntelisisSLHist.Cliente=<T>{Info.Cliente}<T>
[Lista.IntelisisSLHist.Licencia]
Carpeta=Lista
Clave=IntelisisSLHist.Licencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IntelisisSLHist.Nombre]
Carpeta=Lista
Clave=IntelisisSLHist.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IntelisisSLHist.Vencimiento]
Carpeta=Lista
Clave=IntelisisSLHist.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IntelisisSLHist.Observaciones]
Carpeta=Lista
Clave=IntelisisSLHist.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IntelisisSLHist.Estatus]
Carpeta=Lista
Clave=IntelisisSLHist.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Licencia=75
Nombre=235
Vencimiento=87
Observaciones=334
Estatus=92

0=-2
1=-2
2=-2
3=-2
4=-2
5=107

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S


[Lista.ListaEnCaptura]
(Inicio)=IntelisisSLHist.Licencia
IntelisisSLHist.Licencia=IntelisisSLHist.Nombre
IntelisisSLHist.Nombre=IntelisisSLHist.Vencimiento
IntelisisSLHist.Vencimiento=IntelisisSLHist.Observaciones
IntelisisSLHist.Observaciones=IntelisisSLHist.Estatus
IntelisisSLHist.Estatus=(Fin)












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

















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Personalizar
Personalizar=(Fin)
