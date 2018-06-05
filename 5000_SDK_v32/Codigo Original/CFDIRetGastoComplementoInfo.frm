

[Forma]
Clave=CFDIRetGastoComplementoInfo
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Retenciones - Información Complementos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Cerrar
ListaCarpetas=Dividendos
CarpetaPrincipal=Dividendos
PosicionInicialIzquierda=448
PosicionInicialArriba=208
PosicionInicialAlturaCliente=273
PosicionInicialAncho=470
Comentarios=Info.Mov +<T> <T>+ Info.MovID

[Dividendos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Dividendos
Clave=Dividendos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetGastoComplemento
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


Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=CFDIRetGastoComplemento.ID = {Info.ID}
CondicionVisible=Info.Concepto = <T>DIVIDENDOS<T>
[Dividendos.CFDIRetGastoComplemento.CveTipDivOUtil]
Carpeta=Dividendos
Clave=CFDIRetGastoComplemento.CveTipDivOUtil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Dividendos.CFDIRetSATDividendo.Dividendo]
Carpeta=Dividendos
Clave=CFDIRetSATDividendo.Dividendo
3D=S
Pegado=S
Tamano=30
ColorFondo=$00F0F0F0

[Dividendos.CFDIRetGastoComplemento.TipoSocDistrDiv]
Carpeta=Dividendos
Clave=CFDIRetGastoComplemento.TipoSocDistrDiv
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco

[Dividendos.CFDIRetGastoComplemento.ProporcionRem]
Carpeta=Dividendos
Clave=CFDIRetGastoComplemento.ProporcionRem
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco















Tamano=18

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






[Dividendos.CFDIRetGastoComplemento.Gravado]
Carpeta=Dividendos
Clave=CFDIRetGastoComplemento.Gravado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=18
[Dividendos.CFDIRetGastoComplemento.Exento]
Carpeta=Dividendos
Clave=CFDIRetGastoComplemento.Exento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=18


[Dividendos.ListaEnCaptura]
(Inicio)=CFDIRetGastoComplemento.CveTipDivOUtil
CFDIRetGastoComplemento.CveTipDivOUtil=CFDIRetSATDividendo.Dividendo
CFDIRetSATDividendo.Dividendo=CFDIRetGastoComplemento.TipoSocDistrDiv
CFDIRetGastoComplemento.TipoSocDistrDiv=CFDIRetGastoComplemento.ProporcionRem
CFDIRetGastoComplemento.ProporcionRem=CFDIRetGastoComplemento.Gravado
CFDIRetGastoComplemento.Gravado=CFDIRetGastoComplemento.Exento
CFDIRetGastoComplemento.Exento=(Fin)
