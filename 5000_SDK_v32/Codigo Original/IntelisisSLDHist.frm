[Forma]
Clave=IntelisisSLDHist
Icono=6
Modulos=(Todos)
Nombre=Histórico -Detalle Licencia
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=343
PosicionInicialArriba=158
PosicionInicialAlturaCliente=416
PosicionInicialAncho=680
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Cliente, Info.Clave, Info.Nombre)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
EsConsultaExclusiva=S
SinCondicionDespliege=S
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=IntelisisSLDHist
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

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
FiltroFechasCampo=IntelisisSLDHist.FechaHora
FiltroFechasDefault=Esta Semana
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
OtroOrden=S
ListaOrden=IntelisisSLDHist.FechaHora<TAB>(Decendente)
PestanaOtroNombre=S
PestanaNombre=cambios
IconosNombre=IntelisisSLDHist:IntelisisSLDHist.FechaHora
FiltroGeneral=IntelisisSLDHist.Licencia=<T>{Info.Clave}<T>

[Lista.IntelisisSLDHist.Cantidad]
Carpeta=Lista
Clave=IntelisisSLDHist.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.IntelisisSLDHist.Estatus]
Carpeta=Lista
Clave=IntelisisSLDHist.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Columnas]
Menu=182
Modulos=391
Cantidad=48
Estatus=94


0=148
1=192
2=61
3=103
4=67
5=-2


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





[Lista.IntelisisSLDHist.Licenciamiento]
Carpeta=Lista
Clave=IntelisisSLDHist.Licenciamiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Lista.ListaEnCaptura]
(Inicio)=IntelisisSLDHist.Licenciamiento
IntelisisSLDHist.Licenciamiento=IntelisisSLDHist.Cantidad
IntelisisSLDHist.Cantidad=IntelisisSLDHist.Estatus
IntelisisSLDHist.Estatus=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Personalizar
Personalizar=(Fin)
