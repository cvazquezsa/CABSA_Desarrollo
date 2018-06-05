
[Forma]
Clave=CFDIRetencionPaisEstado
Nombre=Estados
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=439
PosicionInicialArriba=95
PosicionInicialAltura=400
PosicionInicialAncho=488
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialAlturaCliente=500
Comentarios=Info.Pais

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetencionPaisEstado
Fuente={MS Sans Serif, 8, Negro, []}
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General


FiltroGeneral=CFDIRetencionPaisEstado.Pais=<T>{Info.Pais}<T>
[Lista.Columnas]
Pais=100
Estado=183
ImpuestoNomina=100
Clave=98
ClaveCURP=96
ImpuestoNominaEspecial=145

CFDIRetClaveSat=88
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S




[Lista.CFDIRetencionPaisEstado.Estado]
Carpeta=Lista
Clave=CFDIRetencionPaisEstado.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.CFDIRetencionPaisEstado.Clave]
Carpeta=Lista
Clave=CFDIRetencionPaisEstado.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CFDIRetencionPaisEstado.CFDIRetClaveSat]
Carpeta=Lista
Clave=CFDIRetencionPaisEstado.CFDIRetClaveSat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=CFDIRetencionPaisEstado.Estado
CFDIRetencionPaisEstado.Estado=CFDIRetencionPaisEstado.Clave
CFDIRetencionPaisEstado.Clave=CFDIRetencionPaisEstado.CFDIRetClaveSat
CFDIRetencionPaisEstado.CFDIRetClaveSat=(Fin)
