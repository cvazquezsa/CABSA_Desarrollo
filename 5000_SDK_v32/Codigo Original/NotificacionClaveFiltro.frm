
[Forma]
Clave=NotificacionClaveFiltro
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Filtros - Claves Notificación
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaAcciones=Cerrar
Comentarios=Lista(Info.NotificacionClave)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=0
PosicionInicialArriba=14
PosicionInicialAlturaCliente=400
PosicionInicialAncho=1062
VentanaExclusiva=S
VentanaExclusivaOpcion=3
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

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionClaveFiltro
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Empresa<T>
ElementosPorPaginaEsp=200
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

IconosNombre=NotificacionClaveFiltro:NotificacionClaveFiltro.Empresa
FiltroGeneral=NotificacionClaveFiltro.Clave = {Comillas(Info.NotificacionClave)}
[Lista.NotificacionClaveFiltro.Sucursal]
Carpeta=Lista
Clave=NotificacionClaveFiltro.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.NotificacionClaveFiltro.UEN]
Carpeta=Lista
Clave=NotificacionClaveFiltro.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.NotificacionClaveFiltro.Usuario]
Carpeta=Lista
Clave=NotificacionClaveFiltro.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.NotificacionClaveFiltro.Modulo]
Carpeta=Lista
Clave=NotificacionClaveFiltro.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.NotificacionClaveFiltro.Movimiento]
Carpeta=Lista
Clave=NotificacionClaveFiltro.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.NotificacionClaveFiltro.Estatus]
Carpeta=Lista
Clave=NotificacionClaveFiltro.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.NotificacionClaveFiltro.Situacion]
Carpeta=Lista
Clave=NotificacionClaveFiltro.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.NotificacionClaveFiltro.Proyecto]
Carpeta=Lista
Clave=NotificacionClaveFiltro.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.NotificacionClaveFiltro.ContactoTipo]
Carpeta=Lista
Clave=NotificacionClaveFiltro.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.NotificacionClaveFiltro.Contacto]
Carpeta=Lista
Clave=NotificacionClaveFiltro.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.NotificacionClaveFiltro.ImporteMin]
Carpeta=Lista
Clave=NotificacionClaveFiltro.ImporteMin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.NotificacionClaveFiltro.ImporteMax]
Carpeta=Lista
Clave=NotificacionClaveFiltro.ImporteMax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
0=62
1=-2
2=52
3=66
4=-2
5=103
6=78
7=80
8=76
9=94
10=-2
11=97
12=99







13=-2
[Lista.ListaEnCaptura]
(Inicio)=NotificacionClaveFiltro.Sucursal
NotificacionClaveFiltro.Sucursal=NotificacionClaveFiltro.UEN
NotificacionClaveFiltro.UEN=NotificacionClaveFiltro.Usuario
NotificacionClaveFiltro.Usuario=NotificacionClaveFiltro.Modulo
NotificacionClaveFiltro.Modulo=NotificacionClaveFiltro.Movimiento
NotificacionClaveFiltro.Movimiento=NotificacionClaveFiltro.Estatus
NotificacionClaveFiltro.Estatus=NotificacionClaveFiltro.Situacion
NotificacionClaveFiltro.Situacion=NotificacionClaveFiltro.Proyecto
NotificacionClaveFiltro.Proyecto=NotificacionClaveFiltro.ContactoTipo
NotificacionClaveFiltro.ContactoTipo=NotificacionClaveFiltro.Contacto
NotificacionClaveFiltro.Contacto=NotificacionClaveFiltro.ImporteMin
NotificacionClaveFiltro.ImporteMin=NotificacionClaveFiltro.ImporteMax
NotificacionClaveFiltro.ImporteMax=NotificacionClaveFiltro.ValidarAlEmitir
NotificacionClaveFiltro.ValidarAlEmitir=(Fin)

[Lista.NotificacionClaveFiltro.ValidarAlEmitir]
Carpeta=Lista
Clave=NotificacionClaveFiltro.ValidarAlEmitir
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
