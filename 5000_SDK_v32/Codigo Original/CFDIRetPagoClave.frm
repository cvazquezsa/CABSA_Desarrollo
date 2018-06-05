

[Forma]
Clave=CFDIRetPagoClave
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Claves Afectación Pagos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=511
PosicionInicialArriba=203
PosicionInicialAlturaCliente=283
PosicionInicialAncho=344
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetPagoClave
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

PestanaOtroNombre=S
PestanaNombre=Lista
[Lista.CFDIRetPagoClave.Clave]
Carpeta=Lista
Clave=CFDIRetPagoClave.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
Clave=67

0=37
1=67
2=-2
3=-2
NombreOmision=219
Descripcion=170


[Lista.ListaEnCaptura]
(Inicio)=CFDIRetPagoClave.Clave
CFDIRetPagoClave.Clave=CFDIRetencionMovClaveCXPP.NombreOmision
CFDIRetencionMovClaveCXPP.NombreOmision=(Fin)

[Lista.CFDIRetencionMovClaveCXPP.NombreOmision]
Carpeta=Lista
Clave=CFDIRetencionMovClaveCXPP.NombreOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
