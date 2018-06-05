

[Forma]
Clave=CFDIRetGastoComplemento
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
PosicionInicialIzquierda=448
PosicionInicialArriba=233
PosicionInicialAlturaCliente=224
PosicionInicialAncho=470
Comentarios=Info.Mov +<T> <T>+ Info.MovID
ExpresionesAlMostrar=Asigna(Info.Dato,0)<BR>EjecutarSQL(<T>EXEC spRetencionesActulizarComplementos :tModulo, :dID, :dBandera<T>, <T>GAS<T>, Info.ID, 3)
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









[Dividendos.CFDIRetSATDividendo.Clave]
Carpeta=Dividendos
Clave=CFDIRetSATDividendo.Clave
Editar=N
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco

Pegado=S
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
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=18










[Dividendos.ListaEnCaptura]
(Inicio)=CFDIRetGastoComplemento.CveTipDivOUtil
CFDIRetGastoComplemento.CveTipDivOUtil=CFDIRetSATDividendo.Clave
CFDIRetSATDividendo.Clave=CFDIRetGastoComplemento.TipoSocDistrDiv
CFDIRetGastoComplemento.TipoSocDistrDiv=CFDIRetGastoComplemento.ProporcionRem
CFDIRetGastoComplemento.ProporcionRem=CFDIRetGastoComplemento.Gravado
CFDIRetGastoComplemento.Gravado=CFDIRetGastoComplemento.Exento
CFDIRetGastoComplemento.Exento=(Fin)
