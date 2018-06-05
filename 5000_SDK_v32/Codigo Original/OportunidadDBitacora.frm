
[Forma]
Clave=OportunidadDBitacora
Icono=4
Modulos=(Todos)
MovModulo=OPORT
Nombre=Actividad - Bitacora
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=204
PosicionInicialArriba=52
PosicionInicialAlturaCliente=586
PosicionInicialAncho=958
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov + <T> <T> + Info.MovID, Info.Tipo +<T> <T>+Info.Clave)
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Bitacora
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadDBitacora
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
OtroOrden=S

ListaOrden=OportunidadDBitacora.RID<TAB>(Acendente)
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=OportunidadDBitacora.FechaCambio
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroUsuarios=S
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
IconosNombre=OportunidadDBitacora:Oportunidad.Mov+<T> <T>+OportunidadDBitacora:Oportunidad.MovID
FiltroGeneral=OportunidadDBitacora.ID = {Info.ID} AND<BR>OportunidadDBitacora.Renglon = {Info.Renglon} AND<BR>OportunidadDBitacora.RenglonSub = {Info.RenglonSub}
[Lista.OportunidadDBitacora.Tipo]
Carpeta=Lista
Clave=OportunidadDBitacora.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.OportunidadDBitacora.Clave]
Carpeta=Lista
Clave=OportunidadDBitacora.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.OportunidadDBitacora.Fecha]
Carpeta=Lista
Clave=OportunidadDBitacora.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.OportunidadDBitacora.Usuario]
Carpeta=Lista
Clave=OportunidadDBitacora.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.OportunidadDBitacora.PorcentajeAvance]
Carpeta=Lista
Clave=OportunidadDBitacora.PorcentajeAvance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.OportunidadDBitacora.Recurso]
Carpeta=Lista
Clave=OportunidadDBitacora.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Lista.Columnas]
0=119
1=61
2=135
3=79
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



[Lista.OportunidadDBitacora.FechaCambio]
Carpeta=Lista
Clave=OportunidadDBitacora.FechaCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco













[Lista.OportunidadDBitacora.Estado]
Carpeta=Lista
Clave=OportunidadDBitacora.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco





[Lista.OportunidadDBitacora.FechaA]
Carpeta=Lista
Clave=OportunidadDBitacora.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[Lista.ListaEnCaptura]
(Inicio)=OportunidadDBitacora.Tipo
OportunidadDBitacora.Tipo=OportunidadDBitacora.Clave
OportunidadDBitacora.Clave=OportunidadDBitacora.FechaCambio
OportunidadDBitacora.FechaCambio=OportunidadDBitacora.Fecha
OportunidadDBitacora.Fecha=OportunidadDBitacora.FechaA
OportunidadDBitacora.FechaA=OportunidadDBitacora.Usuario
OportunidadDBitacora.Usuario=OportunidadDBitacora.PorcentajeAvance
OportunidadDBitacora.PorcentajeAvance=OportunidadDBitacora.Estado
OportunidadDBitacora.Estado=OportunidadDBitacora.Recurso
OportunidadDBitacora.Recurso=OportunidadDBitacora.MovGestion
OportunidadDBitacora.MovGestion=(Fin)

[Lista.OportunidadDBitacora.MovGestion]
Carpeta=Lista
Clave=OportunidadDBitacora.MovGestion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=MostrarCampos
MostrarCampos=(Fin)
