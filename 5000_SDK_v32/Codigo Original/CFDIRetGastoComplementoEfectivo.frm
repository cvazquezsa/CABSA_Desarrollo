

[Forma]
Clave=CFDIRetGastoComplementoEfectivo
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

ListaAcciones=GuardarCerrar
ListaCarpetas=Dividendos
CarpetaPrincipal=Dividendos
PosicionInicialIzquierda=336
PosicionInicialArriba=154
PosicionInicialAlturaCliente=381
PosicionInicialAncho=694
Comentarios=Info.Mov +<T> <T>+ Info.MovID
ExpresionesAlMostrar=Asigna(Info.Dato,0)<BR>EjecutarSQL(<T>EXEC spRetencionesActulizarComplementos :tModulo, :dID, :dBandera<T>, <T>GAS<T>, Info.ID, 4)
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

[Dividendos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Dividendos
Clave=Dividendos
PermiteEditar=S
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


Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S











ListaEnCaptura=(Lista)


FiltroGeneral=CFDIRetGastoComplementoEfectivo.ID = {Info.ID}
[Dividendos.CFDIRetGastoComplementoEfectivo.CveTipDivOUtil]
Carpeta=Dividendos
Clave=CFDIRetGastoComplementoEfectivo.CveTipDivOUtil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
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
Editar=N
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=30
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
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
Clave=41
Dividendo=604
