
[Forma]
Clave=CFDINominaIncapacidad
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Nómina - Incapacidades
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=475
PosicionInicialArriba=157
PosicionInicialAlturaCliente=374
PosicionInicialAncho=395
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
Vista=CFDINominaIncapacidad
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

ListaOrden=CFDINominaIncapacidad.TipoIncapacidad<TAB>(Acendente)
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
FiltroGrupo1=CFDINominaIncapacidad.Movimiento
FiltroValida1=CFDINominaIncapacidad.Movimiento
FiltroTodo=S





ListaEnCaptura=(Lista)
IconosNombre=CFDINominaIncapacidad:CFDINominaIncapacidad.TipoIncapacidad
FiltroGeneral=CFDINominaIncapacidad.ID = {Info.ID} AND<BR>CFDINominaIncapacidad.Personal = <T>{Info.Personal}<T>
[Lista.Columnas]
0=103
1=103
2=129
3=108
4=108
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

















[Lista.CFDINominaIncapacidad.Dias]
Carpeta=Lista
Clave=CFDINominaIncapacidad.Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


Totalizador=1
[Lista.CFDINominaIncapacidad.Descuento]
Carpeta=Lista
Clave=CFDINominaIncapacidad.Descuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





Totalizador=1

[Lista.ListaEnCaptura]
(Inicio)=CFDINominaIncapacidad.Dias
CFDINominaIncapacidad.Dias=CFDINominaIncapacidad.Descuento
CFDINominaIncapacidad.Descuento=(Fin)





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=(Fin)
