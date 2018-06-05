
[Forma]
Clave=NotificacionFiltro
Icono=0
Modulos=(Todos)
Nombre=Filtros Notificaciones
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=Aceptar
Comentarios=Lista(Info.Notificacion)
PosicionInicialIzquierda=0
PosicionInicialArriba=4
PosicionInicialAlturaCliente=420
PosicionInicialAncho=1122
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionFiltro
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
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

FiltroGeneral=NotificacionFiltro.Notificacion = {Comillas(Info.Notificacion)}
[Lista.NotificacionFiltro.Empresa]
Carpeta=Lista
Clave=NotificacionFiltro.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.NotificacionFiltro.Sucursal]
Carpeta=Lista
Clave=NotificacionFiltro.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.NotificacionFiltro.UEN]
Carpeta=Lista
Clave=NotificacionFiltro.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.NotificacionFiltro.Usuario]
Carpeta=Lista
Clave=NotificacionFiltro.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.NotificacionFiltro.Modulo]
Carpeta=Lista
Clave=NotificacionFiltro.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


NombreEnBoton=S
[Lista.Columnas]
Empresa=64
Sucursal=60
UEN=63
Usuario=64
Modulo=60

Movimiento=83

Estatus=61
Situacion=64
Proyecto=144
ContactoTipo=85
Contacto=64
ImporteMin=89
ImporteMax=99
ValidarAlEmitir=77
[Lista.NotificacionFiltro.Movimiento]
Carpeta=Lista
Clave=NotificacionFiltro.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Lista.NotificacionFiltro.Estatus]
Carpeta=Lista
Clave=NotificacionFiltro.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.NotificacionFiltro.Situacion]
Carpeta=Lista
Clave=NotificacionFiltro.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Lista.NotificacionFiltro.Proyecto]
Carpeta=Lista
Clave=NotificacionFiltro.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.NotificacionFiltro.ContactoTipo]
Carpeta=Lista
Clave=NotificacionFiltro.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.NotificacionFiltro.Contacto]
Carpeta=Lista
Clave=NotificacionFiltro.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.NotificacionFiltro.ImporteMin]
Carpeta=Lista
Clave=NotificacionFiltro.ImporteMin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.NotificacionFiltro.ImporteMax]
Carpeta=Lista
Clave=NotificacionFiltro.ImporteMax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=NotificacionFiltro.Empresa
NotificacionFiltro.Empresa=NotificacionFiltro.Sucursal
NotificacionFiltro.Sucursal=NotificacionFiltro.UEN
NotificacionFiltro.UEN=NotificacionFiltro.Usuario
NotificacionFiltro.Usuario=NotificacionFiltro.Modulo
NotificacionFiltro.Modulo=NotificacionFiltro.Movimiento
NotificacionFiltro.Movimiento=NotificacionFiltro.Estatus
NotificacionFiltro.Estatus=NotificacionFiltro.Situacion
NotificacionFiltro.Situacion=NotificacionFiltro.Proyecto
NotificacionFiltro.Proyecto=NotificacionFiltro.ContactoTipo
NotificacionFiltro.ContactoTipo=NotificacionFiltro.Contacto
NotificacionFiltro.Contacto=NotificacionFiltro.ImporteMin
NotificacionFiltro.ImporteMin=NotificacionFiltro.ImporteMax
NotificacionFiltro.ImporteMax=NotificacionFiltro.ValidarAlEmitir
NotificacionFiltro.ValidarAlEmitir=(Fin)

[Lista.NotificacionFiltro.ValidarAlEmitir]
Carpeta=Lista
Clave=NotificacionFiltro.ValidarAlEmitir
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
