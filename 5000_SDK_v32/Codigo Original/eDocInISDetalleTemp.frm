
[Forma]
Clave=eDocInISDetalleTemp
Icono=0
CarpetaPrincipal=eDocInISDetalleTemp
Modulos=(Todos)

ListaCarpetas=eDocInISDetalleTemp
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=405
PosicionInicialArriba=226
PosicionInicialAlturaCliente=370
PosicionInicialAncho=790
Nombre=Detalle
Comentarios=Lista(Info.Nombre2,Info.RID)
[eDocInISDetalleTemp]
Estilo=Iconos
Clave=eDocInISDetalleTemp
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocInISDetalleTemp
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

IconosCampo=(Situación)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
IconosSubTitulo=<T>Estatus<T>
PestanaOtroNombre=S
PestanaNombre=Rutas
IconosNombre=eDocInISDetalleTemp:eDocInISDetalleTemp.Estatus
FiltroGeneral=eDocInISDetalleTemp.Estacion = <T>{EstacionTrabajo}<T>  AND<BR>eDocInISDetalleTemp.RID = {Info.RID}
[eDocInISDetalleTemp.eDocInISDetalleTemp.eDocIn]
Carpeta=eDocInISDetalleTemp
Clave=eDocInISDetalleTemp.eDocIn
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[eDocInISDetalleTemp.eDocInISDetalleTemp.Ruta]
Carpeta=eDocInISDetalleTemp
Clave=eDocInISDetalleTemp.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[eDocInISDetalleTemp.eDocInISDetalleTemp.ID]
Carpeta=eDocInISDetalleTemp
Clave=eDocInISDetalleTemp.ID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[eDocInISDetalleTemp.eDocInISDetalleTemp.Mov]
Carpeta=eDocInISDetalleTemp
Clave=eDocInISDetalleTemp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[eDocInISDetalleTemp.Columnas]
eDocIn=115
Ruta=92
Modulo=52
ID=37
Mov=197
Estatus=124



Origen=124

0=104
1=100
2=99
3=52
4=50
5=110
6=-2
[eDocInISDetalleTemp.eDocInISDetalleTemp.Origen]
Carpeta=eDocInISDetalleTemp
Clave=eDocInISDetalleTemp.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
















[eDocInISDetalleTemp.NombreModulo]
Carpeta=eDocInISDetalleTemp
Clave=NombreModulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[eDocInISDetalleTemp.ListaEnCaptura]
(Inicio)=eDocInISDetalleTemp.eDocIn
eDocInISDetalleTemp.eDocIn=eDocInISDetalleTemp.Ruta
eDocInISDetalleTemp.Ruta=NombreModulo
NombreModulo=eDocInISDetalleTemp.ID
eDocInISDetalleTemp.ID=eDocInISDetalleTemp.Mov
eDocInISDetalleTemp.Mov=eDocInISDetalleTemp.Origen
eDocInISDetalleTemp.Origen=(Fin)
