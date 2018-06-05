
[Forma]
Clave=CFDIRetencionPais
Nombre=Paises
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=430
PosicionInicialArriba=168
PosicionInicialAltura=400
PosicionInicialAncho=505
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=354

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetencionPais
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

ListaEnCaptura=(Lista)
[Lista.Columnas]
Pais=300
Estado=183
ImpuestoNomina=100
Clave=55
ClaveCURP=61

CFDIRetClaveSat=83
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


[Acciones.PaisEstado]
Nombre=PaisEstado
Boton=47
NombreEnBoton=S
NombreDesplegar=&Estados
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionPaisEstado
Activo=S
ConCondicion=S
Antes=S
Visible=S





EjecucionCondicion=ConDatos(CFDIRetencionPais:CFDIRetencionPais.Pais)
AntesExpresiones=Asigna(Info.Pais, CFDIRetencionPais:CFDIRetencionPais.Pais)
[Lista.CFDIRetencionPais.Pais]
Carpeta=Lista
Clave=CFDIRetencionPais.Pais
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

Efectos=[Negritas]
[Lista.CFDIRetencionPais.Clave]
Carpeta=Lista
Clave=CFDIRetencionPais.Clave
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CFDIRetencionPais.CFDIRetClaveSat]
Carpeta=Lista
Clave=CFDIRetencionPais.CFDIRetClaveSat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco










[Lista.ListaEnCaptura]
(Inicio)=CFDIRetencionPais.Pais
CFDIRetencionPais.Pais=CFDIRetencionPais.Clave
CFDIRetencionPais.Clave=CFDIRetencionPais.CFDIRetClaveSat
CFDIRetencionPais.CFDIRetClaveSat=(Fin)

















































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=PaisEstado
PaisEstado=(Fin)
