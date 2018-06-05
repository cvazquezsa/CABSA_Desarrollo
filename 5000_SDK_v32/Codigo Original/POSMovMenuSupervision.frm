
[Forma]
Clave=POSMovMenuSupervision
Icono=0
Modulos=(Todos)
Nombre=Movimientos Menu Supervision

ListaCarpetas=(Lista)
CarpetaPrincipal=POSMovMenuSupervision
PosicionInicialAlturaCliente=298
PosicionInicialAncho=679
PosicionInicialIzquierda=347
PosicionInicialArriba=151
AccionesTamanoBoton=15x5
AccionesDerecha=S
BarraHerramientas=S
ListaAcciones=Guardar
PosicionCol1=306
VentanaTipoMarco=Normal
VentanaPosicionInicial=Por diseño
VentanaEstadoInicial=Normal
VentanaColor=Plata
ExpresionesAlMostrar=Asigna(Pos.MultiMoneda,SQL(<T>SELECT MultiMoneda FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))
[POSMovMenuSupervision]
Estilo=Ficha
Clave=POSMovMenuSupervision
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSMovMenuSupervision
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
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
FiltroGeneral=POSMovMenuSupervision.Empresa= <T>{Empresa}<T>
[POSMovMenuSupervision.POSMovMenuSupervision.AperturaCaja]
Carpeta=POSMovMenuSupervision
Clave=POSMovMenuSupervision.AperturaCaja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSMovMenuSupervision.POSMovMenuSupervision.AumentoCaja]
Carpeta=POSMovMenuSupervision
Clave=POSMovMenuSupervision.AumentoCaja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSMovMenuSupervision.POSMovMenuSupervision.CorteParcialCaja]
Carpeta=POSMovMenuSupervision
Clave=POSMovMenuSupervision.CorteParcialCaja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSMovMenuSupervision.POSMovMenuSupervision.CorteCaja]
Carpeta=POSMovMenuSupervision
Clave=POSMovMenuSupervision.CorteCaja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[POSMovMenuSupervision.POSMovMenuSupervision.Egreso]
Carpeta=POSMovMenuSupervision
Clave=POSMovMenuSupervision.Egreso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSMovMenuSupervision.POSMovMenuSupervision.Ingreso]
Carpeta=POSMovMenuSupervision
Clave=POSMovMenuSupervision.Ingreso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSMovMenuSupervision.Columnas]
AperturaCaja=124
AumentoCaja=124
CorteParcialCaja=124
CorteCaja=124
CancelacionACaja=124
CancelacionCCaja=124
Egreso=124
Ingreso=124


[Acciones.Guardar.Guardar]
Nombre=Guardar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Guardar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Guardar.ListaAccionesMultiples]
(Inicio)=Guardar
Guardar=Cerrar
Cerrar=(Fin)









[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Salir
Salir=(Fin)

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S








[POSMovMenuSupervisionmulti]
Estilo=Ficha
Clave=POSMovMenuSupervisionmulti
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=POSMovMenuSupervision
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco

Filtros=S
PermiteEditar=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

FiltroGeneral=POSMovMenuSupervision.Empresa= <T>{Empresa}<T>
CarpetaVisible=S
[POSMovMenuSupervisionmulti.POSMovMenuSupervision.AperturaCajaM]
Carpeta=POSMovMenuSupervisionmulti
Clave=POSMovMenuSupervision.AperturaCajaM
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSMovMenuSupervisionmulti.POSMovMenuSupervision.AumentoCajaM]
Carpeta=POSMovMenuSupervisionmulti
Clave=POSMovMenuSupervision.AumentoCajaM
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSMovMenuSupervisionmulti.POSMovMenuSupervision.CorteParcialCajaM]
Carpeta=POSMovMenuSupervisionmulti
Clave=POSMovMenuSupervision.CorteParcialCajaM
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSMovMenuSupervisionmulti.POSMovMenuSupervision.CorteCajaM]
Carpeta=POSMovMenuSupervisionmulti
Clave=POSMovMenuSupervision.CorteCajaM
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[POSMovMenuSupervisionmulti.POSMovMenuSupervision.EgresoM]
Carpeta=POSMovMenuSupervisionmulti
Clave=POSMovMenuSupervision.EgresoM
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSMovMenuSupervisionmulti.POSMovMenuSupervision.IngresoM]
Carpeta=POSMovMenuSupervisionmulti
Clave=POSMovMenuSupervision.IngresoM
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[POSMovMenuSupervisionmulti.Columnas]
AperturaCajaM=124
AumentoCajaM=124
CorteParcialCajaM=124
CorteCajaM=124
CancelacionACajaM=157
CancelacionCCajaM=141
EgresoM=124
IngresoM=124




[POSMovMenuSupervision.POSMovMenuSupervision.Recoleccion]
Carpeta=POSMovMenuSupervision
Clave=POSMovMenuSupervision.Recoleccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco










[POSMovMenuSupervision.ListaEnCaptura]
(Inicio)=POSMovMenuSupervision.AperturaCaja
POSMovMenuSupervision.AperturaCaja=POSMovMenuSupervision.AumentoCaja
POSMovMenuSupervision.AumentoCaja=POSMovMenuSupervision.CorteParcialCaja
POSMovMenuSupervision.CorteParcialCaja=POSMovMenuSupervision.CorteCaja
POSMovMenuSupervision.CorteCaja=POSMovMenuSupervision.Egreso
POSMovMenuSupervision.Egreso=POSMovMenuSupervision.Ingreso
POSMovMenuSupervision.Ingreso=POSMovMenuSupervision.Recoleccion
POSMovMenuSupervision.Recoleccion=(Fin)





[POSMovMenuSupervisionmulti.ListaEnCaptura]
(Inicio)=POSMovMenuSupervision.AperturaCajaM
POSMovMenuSupervision.AperturaCajaM=POSMovMenuSupervision.AumentoCajaM
POSMovMenuSupervision.AumentoCajaM=POSMovMenuSupervision.CorteParcialCajaM
POSMovMenuSupervision.CorteParcialCajaM=POSMovMenuSupervision.CorteCajaM
POSMovMenuSupervision.CorteCajaM=POSMovMenuSupervision.EgresoM
POSMovMenuSupervision.EgresoM=POSMovMenuSupervision.IngresoM
POSMovMenuSupervision.IngresoM=(Fin)

[Forma.ListaCarpetas]
(Inicio)=POSMovMenuSupervision
POSMovMenuSupervision=POSMovMenuSupervisionmulti
POSMovMenuSupervisionmulti=(Fin)
