[Forma]
Clave=OrganizacionPosicionEditar
Icono=0
Modulos=(Todos)
Nombre=e(<T>Editar Posiciones de<T>)+<T> <T>+Info.Nombre

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=248
PosicionInicialArriba=103
PosicionInicialAlturaCliente=525
PosicionInicialAncho=869
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionSec1=368
VentanaExclusiva=S
ExpresionesAlMostrar=Asigna(Info.Nombre, SQL(<T>SELECT Nombre FROM Organizacion WHERE Organizacion=:nOrganizacion<T>, Empresa.Organizacion))
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OrganizacionPosicion
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ListaOrden=OrganizacionPosicion.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

HojaIndicador=S
FiltroGeneral=OrganizacionPosicion.Organizacion={Empresa.Organizacion}
[Lista.OrganizacionPosicion.Posicion]
Carpeta=Lista
Clave=OrganizacionPosicion.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Lista.OrganizacionPosicion.RolEsp]
Carpeta=Lista
Clave=OrganizacionPosicion.RolEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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


[Lista.OrganizacionPosicion.Nombre]
Carpeta=Lista
Clave=OrganizacionPosicion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
Posicion=124
Nombre=377
CapacidadEsp=104
RolEsp=251

Capacidad=55

[Lista.OrganizacionPosicion.Capacidad]
Carpeta=Lista
Clave=OrganizacionPosicion.Capacidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S

NombreEnBoton=S
ActivoCondicion=no OrganizacionPosicion:OrganizacionPosicion.TieneMovimientos


[Acciones.Insertar]
Nombre=Insertar
Boton=1
NombreEnBoton=S
NombreDesplegar=&Insertar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

















[Entidades.Entidad.Nombre]
Carpeta=Entidades
Clave=Entidad.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Entidades.EntidadPosicion.Rol]
Carpeta=Entidades
Clave=EntidadPosicion.Rol
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[Entidades.Columnas]
0=109
1=404
2=259


[Acciones.EntidadPersonalizar]
Nombre=EntidadPersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
Carpeta=Entidades
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S




[Lista.ListaEnCaptura]
(Inicio)=OrganizacionPosicion.Posicion
OrganizacionPosicion.Posicion=OrganizacionPosicion.Nombre
OrganizacionPosicion.Nombre=OrganizacionPosicion.Capacidad
OrganizacionPosicion.Capacidad=OrganizacionPosicion.RolEsp
OrganizacionPosicion.RolEsp=(Fin)

























[Entidades.LlaveLocal]
(Inicio)=EntidadPosicion.Organizacion
EntidadPosicion.Organizacion=EntidadPosicion.Posicion
EntidadPosicion.Posicion=(Fin)

[Entidades.LlaveMaestra]
(Inicio)=OrganizacionPosicion.Organizacion
OrganizacionPosicion.Organizacion=OrganizacionPosicion.Posicion
OrganizacionPosicion.Posicion=(Fin)

[Entidades.ListaEnCaptura]
(Inicio)=Entidad.Nombre
Entidad.Nombre=EntidadPosicion.Rol
EntidadPosicion.Rol=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Entidades
Entidades=(Fin)



















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Insertar
Insertar=Eliminar
Eliminar=(Fin)
