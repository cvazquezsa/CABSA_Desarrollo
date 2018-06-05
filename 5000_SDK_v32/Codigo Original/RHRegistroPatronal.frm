
[Forma]
Clave=RHRegistroPatronal
Icono=0
Modulos=(Todos)
MovModulo=RH
Nombre=Registro Patronal
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal

ListaCarpetas=Detalle
CarpetaPrincipal=Detalle
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=329
PosicionInicialArriba=358
PosicionInicialAlturaCliente=273
PosicionInicialAncho=622
[Detalle]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Registro Patronal
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RHRegistroPatronal
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

CarpetaVisible=S
[Detalle.ListaEnCaptura]
(Inicio)=RHRegistroPatronal.RegistroPatronal
RHRegistroPatronal.RegistroPatronal=RHRegistroPatronal.Folio
RHRegistroPatronal.Folio=RHRegistroPatronal.Estatus
RHRegistroPatronal.Estatus=RHRegistroPatronal.AnexoEnvio
RHRegistroPatronal.AnexoEnvio=RHRegistroPatronal.AnexoRespuesta
RHRegistroPatronal.AnexoRespuesta=RHRegistroPatronal.SecuencialNotaria
RHRegistroPatronal.SecuencialNotaria=(Fin)

[Detalle.RHRegistroPatronal.RegistroPatronal]
Carpeta=Detalle
Clave=RHRegistroPatronal.RegistroPatronal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.RHRegistroPatronal.Folio]
Carpeta=Detalle
Clave=RHRegistroPatronal.Folio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.RHRegistroPatronal.Estatus]
Carpeta=Detalle
Clave=RHRegistroPatronal.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.RHRegistroPatronal.AnexoEnvio]
Carpeta=Detalle
Clave=RHRegistroPatronal.AnexoEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.RHRegistroPatronal.AnexoRespuesta]
Carpeta=Detalle
Clave=RHRegistroPatronal.AnexoRespuesta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.RHRegistroPatronal.SecuencialNotaria]
Carpeta=Detalle
Clave=RHRegistroPatronal.SecuencialNotaria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Detalle.Columnas]
RegistroPatronal=96
Folio=49
Estatus=67
AnexoEnvio=138
AnexoRespuesta=148
SecuencialNotaria=89
