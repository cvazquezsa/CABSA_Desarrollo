
[Forma]
Clave=CFDIRetGastoComplementoEfectivoInfo
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
PosicionInicialIzquierda=380
PosicionInicialArriba=142
PosicionInicialAlturaCliente=404
PosicionInicialAncho=605
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
Vista=CFDIRetGastoComplementoEfectivo
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

CarpetaVisible=S
FiltroGeneral=CFDIRetGastoComplementoEfectivo.ID = {Info.ID}
[Dividendos.CFDIRetGastoComplementoEfectivo.CveTipDivOUtil]
Carpeta=Dividendos
Clave=CFDIRetGastoComplementoEfectivo.CveTipDivOUtil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco


[Dividendos.CFDIRetGastoComplementoEfectivo.TipoSocDistrDiv]
Carpeta=Dividendos
Clave=CFDIRetGastoComplementoEfectivo.TipoSocDistrDiv
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Dividendos.CFDIRetGastoComplementoEfectivo.ProporcionRem]
Carpeta=Dividendos
Clave=CFDIRetGastoComplementoEfectivo.ProporcionRem
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






[Dividendos.CFDIRetGastoComplementoEfectivo.MontISRAcredRetMexico]
Carpeta=Dividendos
Clave=CFDIRetGastoComplementoEfectivo.MontISRAcredRetMexico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Dividendos.CFDIRetGastoComplementoEfectivo.MontISRAcredRetExtranjero]
Carpeta=Dividendos
Clave=CFDIRetGastoComplementoEfectivo.MontISRAcredRetExtranjero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Dividendos.CFDIRetGastoComplementoEfectivo.MontRetExtDivExt]
Carpeta=Dividendos
Clave=CFDIRetGastoComplementoEfectivo.MontRetExtDivExt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Dividendos.CFDIRetGastoComplementoEfectivo.MontISRAcredNal]
Carpeta=Dividendos
Clave=CFDIRetGastoComplementoEfectivo.MontISRAcredNal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Dividendos.CFDIRetGastoComplementoEfectivo.MontDivAcumNal]
Carpeta=Dividendos
Clave=CFDIRetGastoComplementoEfectivo.MontDivAcumNal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Dividendos.CFDIRetGastoComplementoEfectivo.MontDivAcumExt]
Carpeta=Dividendos
Clave=CFDIRetGastoComplementoEfectivo.MontDivAcumExt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[Dividendos.CFDIRetSATDividendo.Clave]
Carpeta=Dividendos
Clave=CFDIRetSATDividendo.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco





[Dividendos.ListaEnCaptura]
(Inicio)=CFDIRetGastoComplementoEfectivo.CveTipDivOUtil
CFDIRetGastoComplementoEfectivo.CveTipDivOUtil=CFDIRetSATDividendo.Clave
CFDIRetSATDividendo.Clave=CFDIRetGastoComplementoEfectivo.TipoSocDistrDiv
CFDIRetGastoComplementoEfectivo.TipoSocDistrDiv=CFDIRetGastoComplementoEfectivo.ProporcionRem
CFDIRetGastoComplementoEfectivo.ProporcionRem=CFDIRetGastoComplementoEfectivo.MontISRAcredRetMexico
CFDIRetGastoComplementoEfectivo.MontISRAcredRetMexico=CFDIRetGastoComplementoEfectivo.MontISRAcredRetExtranjero
CFDIRetGastoComplementoEfectivo.MontISRAcredRetExtranjero=CFDIRetGastoComplementoEfectivo.MontRetExtDivExt
CFDIRetGastoComplementoEfectivo.MontRetExtDivExt=CFDIRetGastoComplementoEfectivo.MontISRAcredNal
CFDIRetGastoComplementoEfectivo.MontISRAcredNal=CFDIRetGastoComplementoEfectivo.MontDivAcumNal
CFDIRetGastoComplementoEfectivo.MontDivAcumNal=CFDIRetGastoComplementoEfectivo.MontDivAcumExt
CFDIRetGastoComplementoEfectivo.MontDivAcumExt=CFDIRetGastoComplementoEfectivo.Gravado
CFDIRetGastoComplementoEfectivo.Gravado=CFDIRetGastoComplementoEfectivo.Exento
CFDIRetGastoComplementoEfectivo.Exento=(Fin)

[Dividendos.CFDIRetGastoComplementoEfectivo.Gravado]
Carpeta=Dividendos
Clave=CFDIRetGastoComplementoEfectivo.Gravado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Dividendos.CFDIRetGastoComplementoEfectivo.Exento]
Carpeta=Dividendos
Clave=CFDIRetGastoComplementoEfectivo.Exento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
