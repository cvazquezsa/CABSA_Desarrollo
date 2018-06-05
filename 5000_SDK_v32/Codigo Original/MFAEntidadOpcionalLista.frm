
[Forma]
Clave=MFAEntidadOpcionalLista
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=MFA - Entidad Opcional
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Seleccionar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=418
PosicionInicialAncho=484
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=279
PosicionInicialArriba=131
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAEntidadOpcional
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
BusquedaRapidaControles=S

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
[Lista.MFAEntidadOpcional.entidad_clave]
Carpeta=Lista
Clave=MFAEntidadOpcional.entidad_clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.MFAEntidadOpcional.entidad_nombre]
Carpeta=Lista
Clave=MFAEntidadOpcional.entidad_nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.MFAEntidadOpcional.entidad_tipo]
Carpeta=Lista
Clave=MFAEntidadOpcional.entidad_tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco

[Lista.Columnas]
0=-2
1=-2
2=-2

[Lista.ListaEnCaptura]
(Inicio)=MFAEntidadOpcional.entidad_clave
MFAEntidadOpcional.entidad_clave=MFAEntidadOpcional.entidad_nombre
MFAEntidadOpcional.entidad_nombre=MFAEntidadOpcional.entidad_tipo
MFAEntidadOpcional.entidad_tipo=(Fin)
