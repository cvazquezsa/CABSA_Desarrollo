

[Forma]
Clave=CFDIEnajenacionGastoComplemento
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Enajenacion de Acciones - Información Complemento


ListaCarpetas=EnajenacionAcciones
CarpetaPrincipal=EnajenacionAcciones
PosicionInicialIzquierda=418
PosicionInicialArriba=207
PosicionInicialAlturaCliente=275
PosicionInicialAncho=529
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=GuardaryCerrar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Comentarios=Info.Mov +<T>  <T>+ Info.MovID
ExpresionesAlMostrar=Asigna(Info.Dato,0)<BR>Asigna(Info.Valor,<T>1.0<T>)<BR>EjecutarSQL(<T>EXEC spRetencionesActulizarComplementos :tModulo, :dID, :dBandera<T>, <T>GAS<T>, Info.ID, 2)
[calendario.ListaEnCaptura]
(Inicio)=CFDIEnajenacionGastoComplemento.Version
CFDIEnajenacionGastoComplemento.Version=CFDIEnajenacionGastoComplemento.Descripcion
CFDIEnajenacionGastoComplemento.Descripcion=CFDIEnajenacionGastoComplemento.Ganancia
CFDIEnajenacionGastoComplemento.Ganancia=CFDIEnajenacionGastoComplemento.Perdida
CFDIEnajenacionGastoComplemento.Perdida=(Fin)





[EnajenacionAcciones]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Enajenacion de Acciones
Clave=EnajenacionAcciones
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIEnajenacionGastoComplemento
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S


Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
Pestana=S
CarpetaVisible=S
FiltroGeneral=CFDIEnajenacionGastoComplemento.ID = {Info.ID}
[EnajenacionAcciones.CFDIEnajenacionGastoComplemento.Descripcion]
Carpeta=EnajenacionAcciones
Clave=CFDIEnajenacionGastoComplemento.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=50x3
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

[EnajenacionAcciones.Columnas]
Version=604
Descripcion=304
Ganancia=64
Perdida=64


[Acciones.GuardaryCerrar]
Nombre=GuardaryCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S










[EnajenacionAcciones.CFDIEnajenacionGastoComplemento.VersionXSD]
Carpeta=EnajenacionAcciones
Clave=CFDIEnajenacionGastoComplemento.VersionXSD
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
























































































[Forma.ListaAcciones]
(Inicio)=GuardaryCerrar
GuardaryCerrar=Nuevo
Nuevo=(Fin)






[EnajenacionAcciones.CFDIEnajenacionGastoComplemento.ID]
Carpeta=EnajenacionAcciones
Clave=CFDIEnajenacionGastoComplemento.ID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco










































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
