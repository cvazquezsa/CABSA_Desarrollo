
[Forma]
Clave=CFDIRetSATIntereses
Icono=0
Modulos=(Todos)
Nombre=Información Complemento Intereses SAT
MovModulo=GAS
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S


ListaCarpetas=Intereses
CarpetaPrincipal=Intereses
ListaAcciones=GuardarCerrar
PosicionInicialIzquierda=467
PosicionInicialArriba=198
PosicionInicialAlturaCliente=293
PosicionInicialAncho=432
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Comentarios=Info.Mov +<T>  <T>+ Info.MovID
ExpresionesAlMostrar=Asigna(Info.Dato,0)<BR>Asigna(Info.Valor,<T>1.0<T>)<BR>EjecutarSQL(<T>EXEC spRetencionesActulizarComplementos :tModulo, :dID, :dBandera<T>, <T>GAS<T>, Info.ID, 1) 
[Interés.ListaEnCaptura]
(Inicio)=CFDIRetSATIntereses.Version
CFDIRetSATIntereses.Version=CFDIRetSATIntereses.SistFinanciero
CFDIRetSATIntereses.SistFinanciero=CFDIRetSATIntereses.RetiroAORESRetInt
CFDIRetSATIntereses.RetiroAORESRetInt=CFDIRetSATIntereses.OperFinancDerivad
CFDIRetSATIntereses.OperFinancDerivad=CFDIRetSATIntereses.MontIntNominal
CFDIRetSATIntereses.MontIntNominal=CFDIRetSATIntereses.MontIntReal
CFDIRetSATIntereses.MontIntReal=CFDIRetSATIntereses.Perdida
CFDIRetSATIntereses.Perdida=(Fin)

















[Interes.ListaEnCaptura]
(Inicio)=CFDIRetSATIntereses.Version
CFDIRetSATIntereses.Version=CFDIRetSATIntereses.SistFinanciero
CFDIRetSATIntereses.SistFinanciero=CFDIRetSATIntereses.RetiroAORESRetInt
CFDIRetSATIntereses.RetiroAORESRetInt=CFDIRetSATIntereses.OperFinancDerivad
CFDIRetSATIntereses.OperFinancDerivad=CFDIRetSATIntereses.MontIntNominal
CFDIRetSATIntereses.MontIntNominal=CFDIRetSATIntereses.MontIntReal
CFDIRetSATIntereses.MontIntReal=CFDIRetSATIntereses.Perdida
CFDIRetSATIntereses.Perdida=(Fin)


[Información Complemento Intereses SAT.ListaEnCaptura]
(Inicio)=CFDIRetSATIntereses.Version
CFDIRetSATIntereses.Version=CFDIRetSATIntereses.SistFinanciero
CFDIRetSATIntereses.SistFinanciero=CFDIRetSATIntereses.RetiroAORESRetInt
CFDIRetSATIntereses.RetiroAORESRetInt=CFDIRetSATIntereses.OperFinancDerivad
CFDIRetSATIntereses.OperFinancDerivad=CFDIRetSATIntereses.MontIntNominal
CFDIRetSATIntereses.MontIntNominal=CFDIRetSATIntereses.MontIntReal
CFDIRetSATIntereses.MontIntReal=CFDIRetSATIntereses.Perdida
CFDIRetSATIntereses.Perdida=(Fin)
















[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
Activo=S
Visible=S

ClaveAccion=Cancelar Cambios

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Cancelar Cambios
Cancelar Cambios=Cancelar
Cancelar=(Fin)


[CFDIRetSATIntereses.ListaEnCaptura]
(Inicio)=CFDIRetSATIntereses.Version
CFDIRetSATIntereses.Version=CFDIRetSATIntereses.SistFinanciero
CFDIRetSATIntereses.SistFinanciero=CFDIRetSATIntereses.RetiroAORESRetInt
CFDIRetSATIntereses.RetiroAORESRetInt=CFDIRetSATIntereses.OperFinancDerivad
CFDIRetSATIntereses.OperFinancDerivad=CFDIRetSATIntereses.MontIntNominal
CFDIRetSATIntereses.MontIntNominal=CFDIRetSATIntereses.MontIntReal
CFDIRetSATIntereses.MontIntReal=CFDIRetSATIntereses.Perdida
CFDIRetSATIntereses.Perdida=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
Activo=S
Visible=S

Antes=S
TipoAccion=ventana
ClaveAccion=Aceptar
[Intereses]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Intereses SAT
Clave=Intereses
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetSATIntereses
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=5
FichaEspacioNombres=56
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


PermiteEditar=S
FichaEspacioNombresAuto=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
RefrescarAlEntrar=S
FiltroGeneral=CFDIRetSATIntereses.ID = {Info.ID}
[Intereses.CFDIRetSATIntereses.Version]
Carpeta=Intereses
Clave=CFDIRetSATIntereses.Version
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Intereses.CFDIRetSATIntereses.SistFinanciero]
Carpeta=Intereses
Clave=CFDIRetSATIntereses.SistFinanciero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Intereses.CFDIRetSATIntereses.RetiroAORESRetInt]
Carpeta=Intereses
Clave=CFDIRetSATIntereses.RetiroAORESRetInt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Intereses.CFDIRetSATIntereses.OperFinancDerivad]
Carpeta=Intereses
Clave=CFDIRetSATIntereses.OperFinancDerivad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Intereses.CFDIRetSATIntereses.MontIntNominal]
Carpeta=Intereses
Clave=CFDIRetSATIntereses.MontIntNominal
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Intereses.CFDIRetSATIntereses.MontIntReal]
Carpeta=Intereses
Clave=CFDIRetSATIntereses.MontIntReal
Editar=N
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
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

























[Acciones.GuardarCerrar.ListaAccionesMultiples]
(Inicio)=Guardar
Guardar=Expresion
Expresion=(Fin)

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

