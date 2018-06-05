

[Forma]
Clave=CFDIEnajenacionGastoComplementoInfo
Icono=0
Modulos=(Todos)
Nombre=CFDI Enajenacion de Acciones - Información Complemento
MovModulo=(Todos)

ListaCarpetas=EnajenacionAcciones
CarpetaPrincipal=EnajenacionAcciones
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=413
PosicionInicialArriba=209
PosicionInicialAlturaCliente=271
PosicionInicialAncho=540
Comentarios=Info.Mov +<T>  <T>+ Info.MovID
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[EnajenacionAcciones]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Enajenacion de Acciones
Clave=EnajenacionAcciones
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIEnajenacionGastoComplemento
Fuente={Tahoma, 8, Negro, []}
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
ListaEnCaptura=(Lista)


FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
FiltroGeneral=CFDIEnajenacionGastoComplemento.ID = {Info.ID}
CondicionVisible=Info.Concepto = <T>ENAJENACION DE ACCIONES<T>
[EnajenacionAcciones.CFDIEnajenacionGastoComplemento.Descripcion]
Carpeta=EnajenacionAcciones
Clave=CFDIEnajenacionGastoComplemento.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50x3
ColorFondo=Blanco

[EnajenacionAcciones.CFDIEnajenacionGastoComplemento.Ganancia]
Carpeta=EnajenacionAcciones
Clave=CFDIEnajenacionGastoComplemento.Ganancia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[EnajenacionAcciones.CFDIEnajenacionGastoComplemento.Perdida]
Carpeta=EnajenacionAcciones
Clave=CFDIEnajenacionGastoComplemento.Perdida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[EnajenacionAcciones.CFDIEnajenacionGastoComplemento.VersionXSD]
Carpeta=EnajenacionAcciones
Clave=CFDIEnajenacionGastoComplemento.VersionXSD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco


[EnajenacionAcciones.CFDIEnajenacionGastoComplemento.ID]
Carpeta=EnajenacionAcciones
Clave=CFDIEnajenacionGastoComplemento.ID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[EnajenacionAcciones.Columnas]
Descripcion=304
Ganancia=64
Perdida=64
VersionXSD=304












[EnajenacionAcciones.CFDIEnajenacionGastoComplemento.Gravado]
Carpeta=EnajenacionAcciones
Clave=CFDIEnajenacionGastoComplemento.Gravado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[EnajenacionAcciones.CFDIEnajenacionGastoComplemento.Exento]
Carpeta=EnajenacionAcciones
Clave=CFDIEnajenacionGastoComplemento.Exento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco















[EnajenacionAcciones.ListaEnCaptura]
(Inicio)=CFDIEnajenacionGastoComplemento.VersionXSD
CFDIEnajenacionGastoComplemento.VersionXSD=CFDIEnajenacionGastoComplemento.Descripcion
CFDIEnajenacionGastoComplemento.Descripcion=CFDIEnajenacionGastoComplemento.Ganancia
CFDIEnajenacionGastoComplemento.Ganancia=CFDIEnajenacionGastoComplemento.Perdida
CFDIEnajenacionGastoComplemento.Perdida=CFDIEnajenacionGastoComplemento.Gravado
CFDIEnajenacionGastoComplemento.Gravado=CFDIEnajenacionGastoComplemento.Exento
CFDIEnajenacionGastoComplemento.Exento=CFDIEnajenacionGastoComplemento.ID
CFDIEnajenacionGastoComplemento.ID=(Fin)
