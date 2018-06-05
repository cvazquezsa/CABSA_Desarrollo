
[Forma]
Clave=NotificacionClaveParam
Icono=24
Modulos=(Todos)
Nombre=Clave Notificación - Parámetros

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.NotificacionClave)
PosicionInicialAlturaCliente=341
PosicionInicialAncho=724
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=278
PosicionInicialArriba=184
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionClaveParam
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

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroGeneral=NotificacionClaveParam.Clave = {Comillas(Info.NotificacionClave)}
[Lista.NotificacionClaveParam.Tipo]
Carpeta=Lista
Clave=NotificacionClaveParam.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.NotificacionClaveParam.ValorOmision]
Carpeta=Lista
Clave=NotificacionClaveParam.ValorOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.NotificacionClaveParam.Descripcion]
Carpeta=Lista
Clave=NotificacionClaveParam.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

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

[Lista.Columnas]
0=124
1=77
2=188
3=-2


Tipo=124
ValorOmision=604
Descripcion=604
[Acciones.Ayuda]
Nombre=Ayuda
Boton=20
NombreEnBoton=S
NombreDesplegar=&Ayuda en captura
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NotificacionClaveParamAyuda

EspacioPrevio=S


Antes=S














ActivoCondicion=NotificacionClaveParam:NotificacionClaveParam.Tipo = <T>TEXTO<T>
AntesExpresiones=Asigna(Info.Nombre,NotificacionClaveParam:NotificacionClaveParam.Parametro)
Visible=S









[Lista.ListaEnCaptura]
(Inicio)=NotificacionClaveParam.Tipo
NotificacionClaveParam.Tipo=NotificacionClaveParam.ValorOmision
NotificacionClaveParam.ValorOmision=NotificacionClaveParam.Descripcion
NotificacionClaveParam.Descripcion=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Ayuda
Ayuda=(Fin)
