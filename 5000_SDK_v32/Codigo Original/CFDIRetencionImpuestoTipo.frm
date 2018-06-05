

[Forma]
Clave=CFDIRetencionImpuestoTipo
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Retenciones - Tipo de Impuesto
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=506
PosicionInicialArriba=208
PosicionInicialAlturaCliente=273
PosicionInicialAncho=354
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
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetencionImpuestoTipo
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
OtroOrden=S

ListaOrden=CFDIRetencionImpuestoTipo.ClaveSAT<TAB>(Acendente)
[Lista.CFDIRetencionImpuestoTipo.Retencion]
Carpeta=Lista
Clave=CFDIRetencionImpuestoTipo.Retencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CFDIRetencionImpuestoTipo.ClaveSAT]
Carpeta=Lista
Clave=CFDIRetencionImpuestoTipo.ClaveSAT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Lista.Columnas]
Retencion=150
ClaveSAT=105
Clave=41
Impuesto=604

[Lista.ListaEnCaptura]
(Inicio)=CFDIRetencionImpuestoTipo.Retencion
CFDIRetencionImpuestoTipo.Retencion=CFDIRetencionImpuestoTipo.ClaveSAT
CFDIRetencionImpuestoTipo.ClaveSAT=(Fin)
