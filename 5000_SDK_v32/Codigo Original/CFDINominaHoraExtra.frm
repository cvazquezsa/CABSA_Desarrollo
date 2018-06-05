
[Forma]
Clave=CFDINominaHoraExtra
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Nómina - Horas Extra
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=414
PosicionInicialArriba=147
PosicionInicialAlturaCliente=401
PosicionInicialAncho=495
Comentarios=Lista(Info.Mov +<T> <T> + Info.MovID, Info.Personal)
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDINominaHoraExtra
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tipo<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco

CarpetaVisible=S
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S

ListaOrden=CFDINominaHoraExtra.TipoHoras<TAB>(Acendente)
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
FiltroGrupo1=CFDINominaHoraExtra.Movimiento
FiltroValida1=CFDINominaHoraExtra.Movimiento
FiltroTodo=S





ListaEnCaptura=(Lista)
IconosNombre=CFDINominaHoraExtra:CFDINominaHoraExtra.TipoHoras
FiltroGeneral=CFDINominaHoraExtra.ID = {Info.ID} AND<BR>CFDINominaHoraExtra.Personal = <T>{Info.Personal}<T>
[Lista.Columnas]
0=109
1=105
2=117
3=128
4=138
5=124












[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S


EspacioPrevio=S
[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Preliminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S




[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

















[Lista.CFDINominaHoraExtra.Dias]
Carpeta=Lista
Clave=CFDINominaHoraExtra.Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.CFDINominaHoraExtra.HorasExtra]
Carpeta=Lista
Clave=CFDINominaHoraExtra.HorasExtra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.CFDINominaHoraExtra.ImportePagado]
Carpeta=Lista
Clave=CFDINominaHoraExtra.ImportePagado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



Totalizador=1



[Lista.ListaEnCaptura]
(Inicio)=CFDINominaHoraExtra.Dias
CFDINominaHoraExtra.Dias=CFDINominaHoraExtra.HorasExtra
CFDINominaHoraExtra.HorasExtra=CFDINominaHoraExtra.ImportePagado
CFDINominaHoraExtra.ImportePagado=(Fin)







[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=(Fin)
