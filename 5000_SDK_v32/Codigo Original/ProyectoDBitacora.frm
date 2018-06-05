[Forma]
Clave=ProyectoDBitacora
Icono=4
Modulos=(Todos)
MovModulo=PROY
Nombre=Actividad - Bitácora
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=241
PosicionInicialArriba=117
PosicionInicialAlturaCliente=586
PosicionInicialAncho=958
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov + <T> <T> + Info.MovID, Info.Actividad)
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Registros
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyectoDBitacora
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco

CarpetaVisible=S
OtroOrden=S

ListaOrden=ProyectoDBitacora.RID<TAB>(Acendente)
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=ProyectoDBitacora.FechaCambio
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroUsuarioDefault=(Usuario)
FiltroFechasDefault=(Todo)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General






ListaEnCaptura=(Lista)
FiltroUsuarios=S
IconosNombre=ProyectoDBitacora:Proyecto.Mov+<T> <T>+ProyectoDBitacora:Proyecto.MovID
FiltroGeneral=ProyectoDBitacora.ID = {Info.ID} AND<BR>ProyectoDBitacora.Actividad = <T>{Info.Actividad}<T>
[Lista.Columnas]
0=130
1=61
2=99
3=84
4=75
5=74
6=63
7=73








8=99
9=71
10=-2
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S




[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación Preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S


[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S




[Acciones.MostrarCampos]
Nombre=MostrarCampos
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S








[Lista.ProyectoDBitacora.Actividad]
Carpeta=Lista
Clave=ProyectoDBitacora.Actividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ProyectoDBitacora.Asunto]
Carpeta=Lista
Clave=ProyectoDBitacora.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.ProyectoDBitacora.FechaCambio]
Carpeta=Lista
Clave=ProyectoDBitacora.FechaCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ProyectoDBitacora.Comienzo]
Carpeta=Lista
Clave=ProyectoDBitacora.Comienzo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ProyectoDBitacora.Fin]
Carpeta=Lista
Clave=ProyectoDBitacora.Fin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ProyectoDBitacora.Usuario]
Carpeta=Lista
Clave=ProyectoDBitacora.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.ProyectoDBitacora.PorcentajeAvance]
Carpeta=Lista
Clave=ProyectoDBitacora.PorcentajeAvance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ProyectoDBitacora.Estado]
Carpeta=Lista
Clave=ProyectoDBitacora.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.ProyectoDBitacora.RecursosAsignados]
Carpeta=Lista
Clave=ProyectoDBitacora.RecursosAsignados
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.ProyectoDBitacora.MovGestion]
Carpeta=Lista
Clave=ProyectoDBitacora.MovGestion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco












[Lista.ListaEnCaptura]
(Inicio)=ProyectoDBitacora.Actividad
ProyectoDBitacora.Actividad=ProyectoDBitacora.Asunto
ProyectoDBitacora.Asunto=ProyectoDBitacora.FechaCambio
ProyectoDBitacora.FechaCambio=ProyectoDBitacora.Comienzo
ProyectoDBitacora.Comienzo=ProyectoDBitacora.Fin
ProyectoDBitacora.Fin=ProyectoDBitacora.Usuario
ProyectoDBitacora.Usuario=ProyectoDBitacora.PorcentajeAvance
ProyectoDBitacora.PorcentajeAvance=ProyectoDBitacora.Estado
ProyectoDBitacora.Estado=ProyectoDBitacora.RecursosAsignados
ProyectoDBitacora.RecursosAsignados=ProyectoDBitacora.MovGestion
ProyectoDBitacora.MovGestion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=MostrarCampos
MostrarCampos=(Fin)
