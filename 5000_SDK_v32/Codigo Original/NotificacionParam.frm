
[Forma]
Clave=NotificacionParam
Icono=0
Modulos=(Todos)
Nombre=Parámetros Notificaciones

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Notificacion)
PosicionInicialAlturaCliente=332
PosicionInicialAncho=486
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=411
PosicionInicialArriba=186
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionParam
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=NotificacionParam.Notificacion = {Comillas(Info.Notificacion)}
[Lista.NotificacionParam.Parametro]
Carpeta=Lista
Clave=NotificacionParam.Parametro
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata

[Lista.NotificacionParam.Valor]
Carpeta=Lista
Clave=NotificacionParam.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Parametro=181
Valor=231



[Lista.ListaEnCaptura]
(Inicio)=NotificacionParam.Parametro
NotificacionParam.Parametro=NotificacionParam.Valor
NotificacionParam.Valor=(Fin)


[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Ayuda
Ayuda=(Fin)
