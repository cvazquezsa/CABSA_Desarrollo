

[Forma]
Clave=CFDIRetSATInteresesInfo
Icono=0
Modulos=(Todos)
Nombre=Complemento Intereses SAT - Información
MovModulo=GAS
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Intereses
CarpetaPrincipal=Intereses
ListaAcciones=Cerrar
PosicionInicialAlturaCliente=277
PosicionInicialAncho=500
PosicionInicialIzquierda=433
PosicionInicialArriba=206
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Comentarios=Info.Mov +<T>  <T>+ Info.MovID
[Intereses]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Intereses SAT información
Clave=Intereses
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetSATIntereses
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaEnCaptura=(Lista)


FiltroGeneral=CFDIRetSATIntereses.ID = {Info.ID}
CondicionVisible=Info.Concepto = <T>INTERESES<T>
[Intereses.CFDIRetSATIntereses.Version]
Carpeta=Intereses
Clave=CFDIRetSATIntereses.Version
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Intereses.CFDIRetSATIntereses.SistFinanciero]
Carpeta=Intereses
Clave=CFDIRetSATIntereses.SistFinanciero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Intereses.CFDIRetSATIntereses.RetiroAORESRetInt]
Carpeta=Intereses
Clave=CFDIRetSATIntereses.RetiroAORESRetInt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Intereses.CFDIRetSATIntereses.OperFinancDerivad]
Carpeta=Intereses
Clave=CFDIRetSATIntereses.OperFinancDerivad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Intereses.CFDIRetSATIntereses.MontIntNominal]
Carpeta=Intereses
Clave=CFDIRetSATIntereses.MontIntNominal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Intereses.CFDIRetSATIntereses.MontIntReal]
Carpeta=Intereses
Clave=CFDIRetSATIntereses.MontIntReal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Intereses.CFDIRetSATIntereses.Perdida]
Carpeta=Intereses
Clave=CFDIRetSATIntereses.Perdida
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
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Intereses.CFDIRetSATIntereses.ID]
Carpeta=Intereses
Clave=CFDIRetSATIntereses.ID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Intereses.CFDIRetSATIntereses.Gravado]
Carpeta=Intereses
Clave=CFDIRetSATIntereses.Gravado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Intereses.CFDIRetSATIntereses.Exento]
Carpeta=Intereses
Clave=CFDIRetSATIntereses.Exento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco









[Intereses.ListaEnCaptura]
(Inicio)=CFDIRetSATIntereses.Version
CFDIRetSATIntereses.Version=CFDIRetSATIntereses.SistFinanciero
CFDIRetSATIntereses.SistFinanciero=CFDIRetSATIntereses.RetiroAORESRetInt
CFDIRetSATIntereses.RetiroAORESRetInt=CFDIRetSATIntereses.OperFinancDerivad
CFDIRetSATIntereses.OperFinancDerivad=CFDIRetSATIntereses.MontIntNominal
CFDIRetSATIntereses.MontIntNominal=CFDIRetSATIntereses.MontIntReal
CFDIRetSATIntereses.MontIntReal=CFDIRetSATIntereses.Perdida
CFDIRetSATIntereses.Perdida=CFDIRetSATIntereses.Gravado
CFDIRetSATIntereses.Gravado=CFDIRetSATIntereses.Exento
CFDIRetSATIntereses.Exento=CFDIRetSATIntereses.ID
CFDIRetSATIntereses.ID=(Fin)
