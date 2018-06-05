
[Forma]
Clave=MFATipoActivoLista
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=MFA - Tipos de Activo Fijo
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=MFATipoActivo
CarpetaPrincipal=MFATipoActivo
PosicionInicialIzquierda=398
PosicionInicialArriba=161
PosicionInicialAlturaCliente=367
PosicionInicialAncho=483
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[MFATipoActivo]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=MFATipoActivo
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFATipoActivo
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ListaOrden=MFATipoActivo.Tipo<TAB>(Acendente)
CarpetaVisible=S

Detalle=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
[MFATipoActivo.MFATipoActivo.Tipo]
Carpeta=MFATipoActivo
Clave=MFATipoActivo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=255
[MFATipoActivo.MFATipoActivo.Descripcion]
Carpeta=MFATipoActivo
Clave=MFATipoActivo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[MFATipoActivo.Columnas]
Tipo=56
Descripcion=366

0=-2
1=-2






[MFATipoActivo.ListaEnCaptura]
(Inicio)=MFATipoActivo.Tipo
MFATipoActivo.Tipo=MFATipoActivo.Descripcion
MFATipoActivo.Descripcion=(Fin)
