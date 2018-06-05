
[Forma]
Clave=POSHerrCteFrecuenteD2
Icono=0
CarpetaPrincipal=POSHerrCteFrecuenteD
BarraHerramientas=S
Modulos=(Todos)
Nombre=Histórico Monedero Cliente Frecuente
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=POSHerrCteFrecuenteD
PosicionInicialIzquierda=404
PosicionInicialArriba=191
PosicionInicialAlturaCliente=440
PosicionInicialAncho=792
ListaAcciones=(Lista)
[POSHerrCteFrecuenteD]
Estilo=Iconos
Clave=POSHerrCteFrecuenteD
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSHerrCteFrecuenteD
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Cliente<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroAutoCampo=POSHerrCteFrecuenteD.Cliente
FiltroGrupo1=POSHerrCteFrecuenteD.Cliente
FiltroValida1=POSHerrCteFrecuenteD.Cliente
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=POSHerrCteFrecuenteD.FechaEmision
FiltroFechasDefault=Hoy
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Monederos

IconosNombre=POSHerrCteFrecuenteD:POSHerrCteFrecuenteD.Cliente
FiltroTodo=S
[POSHerrCteFrecuenteD.Cte.Nombre]
Carpeta=POSHerrCteFrecuenteD
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[POSHerrCteFrecuenteD.POSHerrCteFrecuenteD.Monedero]
Carpeta=POSHerrCteFrecuenteD
Clave=POSHerrCteFrecuenteD.Monedero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSHerrCteFrecuenteD.POSHerrCteFrecuenteD.Mov]
Carpeta=POSHerrCteFrecuenteD
Clave=POSHerrCteFrecuenteD.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSHerrCteFrecuenteD.POSHerrCteFrecuenteD.MovID]
Carpeta=POSHerrCteFrecuenteD
Clave=POSHerrCteFrecuenteD.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSHerrCteFrecuenteD.Columnas]
0=83
1=150
2=109
3=130
4=150


[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Reporte]
Nombre=Reporte
Boton=51
NombreEnBoton=S
NombreDesplegar=&Preliminar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S











GuardarAntes=S




EspacioPrevio=S










Expresion=Asigna(Info.POSMonedero,POSHerrCteFrecuenteD:POSHerrCteFrecuenteD.Monedero)<BR>Asigna(Info.Cliente,POSHerrCteFrecuenteD:POSHerrCteFrecuenteD.Cliente)<BR>Asigna(Info.Nombre,POSHerrCteFrecuenteD:Cte.Nombre)<BR>ReportePantalla(<T>POSMonederoCte<T>)











[POSHerrCteFrecuenteD.ListaEnCaptura]
(Inicio)=Cte.Nombre
Cte.Nombre=POSHerrCteFrecuenteD.Monedero
POSHerrCteFrecuenteD.Monedero=POSHerrCteFrecuenteD.Mov
POSHerrCteFrecuenteD.Mov=POSHerrCteFrecuenteD.MovID
POSHerrCteFrecuenteD.MovID=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Reporte
Reporte=(Fin)
