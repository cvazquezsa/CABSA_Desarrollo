

[Forma]
Clave=CFDIRetencionCfg
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Retenciones - Configuración
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Configuracion
CarpetaPrincipal=Configuracion
PosicionInicialIzquierda=428
PosicionInicialArriba=204
PosicionInicialAlturaCliente=282
PosicionInicialAncho=509
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
GuardarAntes=S

[Configuracion]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Configuracion
Clave=Configuracion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetencionCfg
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Configuracion.CFDIRetencionCfg.MovTimbrado]
Carpeta=Configuracion
Clave=CFDIRetencionCfg.MovTimbrado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco


EspacioPrevio=S
[Configuracion.CFDIRetencionCfg.Concepto]
Carpeta=Configuracion
Clave=CFDIRetencionCfg.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco






[Configuracion.CFDIRetencionCfg.Version]
Carpeta=Configuracion
Clave=CFDIRetencionCfg.Version
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco




[Configuracion.CFDIRetencionCfg.RepConstancia]
Carpeta=Configuracion
Clave=CFDIRetencionCfg.RepConstancia
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

LineaNueva=S





[Configuracion.CFDIRetencionCfg.PeriodosEspecificos]
Carpeta=Configuracion
Clave=CFDIRetencionCfg.PeriodosEspecificos
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=S
ColorFondo=Blanco

Tamano=50
[Configuracion.CFDIRetencionCfg.MesIni]
Carpeta=Configuracion
Clave=CFDIRetencionCfg.MesIni
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Configuracion.CFDIRetencionCfg.MesFin]
Carpeta=Configuracion
Clave=CFDIRetencionCfg.MesFin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[Configuracion.ListaEnCaptura]
(Inicio)=CFDIRetencionCfg.Version
CFDIRetencionCfg.Version=CFDIRetencionCfg.RepConstancia
CFDIRetencionCfg.RepConstancia=CFDIRetencionCfg.MovTimbrado
CFDIRetencionCfg.MovTimbrado=CFDIRetencionCfg.Concepto
CFDIRetencionCfg.Concepto=CFDIRetencionCfg.PeriodosEspecificos
CFDIRetencionCfg.PeriodosEspecificos=CFDIRetencionCfg.Ejerc
CFDIRetencionCfg.Ejerc=CFDIRetencionCfg.MesIni
CFDIRetencionCfg.MesIni=CFDIRetencionCfg.MesFin
CFDIRetencionCfg.MesFin=(Fin)

[Configuracion.CFDIRetencionCfg.Ejerc]
Carpeta=Configuracion
Clave=CFDIRetencionCfg.Ejerc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
