[Forma]
Clave=FormaPago
Nombre=Formas de Pago
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Detalles
ListaAcciones=(Lista)
PosicionInicialIzquierda=355
PosicionInicialArriba=76
PosicionInicialAltura=318
PosicionInicialAncho=656
PosicionColumna1=40
PosicionInicialAlturaCliente=538
PosicionCol1=227

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
Activo=S
ConCondicion=S
EjecucionConError=S

EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(FormaPago:FormaPago.FormaPago)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaPago
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=FormaPago.FormaPago
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Lista
OtroOrden=S
ListaOrden=(Lista)

[Lista.FormaPago.FormaPago]
Carpeta=Lista
Clave=FormaPago.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
FormaPago=194
Comision=90

Institucion=87
Nombre=190
Ciudad=63
Estado=48
[Detalles]
Estilo=Ficha
PestanaNombre=Detalles
Clave=Detalles
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=FormaPago
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S

Pestana=S
PestanaOtroNombre=S
[Detalles.FormaPago.FormaPago]
Carpeta=Detalles
Clave=FormaPago.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalles.FormaPago.MovIngresos]
Carpeta=Detalles
Clave=FormaPago.MovIngresos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S
ColorFondo=Blanco

[Detalles.FormaPago.MovEgresos]
Carpeta=Detalles
Clave=FormaPago.MovEgresos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Detalles.FormaPago.Moneda]
Carpeta=Detalles
Clave=FormaPago.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Detalles.FormaPago.RequiereReferencia]
Carpeta=Detalles
Clave=FormaPago.RequiereReferencia
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Acciones.Orden]
Nombre=Orden
Boton=50
NombreDesplegar=Cambiar &Orden
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
AntesExpresiones=Forma(<T>FormaPagoOrdenar<T>)
DespuesGuardar=S
Visible=S

[Detalles.FormaPago.Comision]
Carpeta=Detalles
Clave=FormaPago.Comision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco
EspacioPrevio=N

[Detalles.FormaPago.Impuestos]
Carpeta=Detalles
Clave=FormaPago.Impuestos
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.Denominaciones]
Nombre=Denominaciones
Boton=47
NombreEnBoton=S
NombreDesplegar=&Denominaciones
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=FormaPagoD
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EjecucionCondicion=ConDatos(FormaPago:FormaPago.FormaPago)
AntesExpresiones=Asigna(Info.FormaPago, FormaPago:FormaPago.FormaPago)

[Detalles.FormaPago.Restringida]
Carpeta=Detalles
Clave=FormaPago.Restringida
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[Detalles.FormaPago.PermiteCambio]
Carpeta=Detalles
Clave=FormaPago.PermiteCambio
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalles.FormaPago.PV]
Carpeta=Detalles
Clave=FormaPago.PV
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Acciones.FormaPagoDesc]
Nombre=FormaPagoDesc
Boton=61
NombreEnBoton=S
NombreDesplegar=&Descuentos (PV)
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=FormaPagoDesc
Activo=S
Visible=S
ConCondicion=S
GuardarAntes=S
EjecucionCondicion=ConDatos(FormaPago:FormaPago.FormaPago)
Antes=S
AntesExpresiones=Asigna(Info.FormaPago, FormaPago:FormaPago.FormaPago)
DespuesGuardar=S

[Detalles.FormaPago.TarjetaBandaMagnetica]
Carpeta=Detalles
Clave=FormaPago.TarjetaBandaMagnetica
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalles.FormaPago.Cuenta]
Carpeta=Detalles
Clave=FormaPago.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalles.Cta.Descripcion]
Carpeta=Detalles
Clave=Cta.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Detalles.FormaPago.Grupo]
Carpeta=Detalles
Clave=FormaPago.Grupo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Grupos]
Nombre=Grupos
Boton=91
NombreEnBoton=S
NombreDesplegar=&Grupos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=FormaPagoGrupo
Activo=S
Visible=S

[Detalles.FormaPago.DefCtaDinero]
Carpeta=Detalles
Clave=FormaPago.DefCtaDinero
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalles.FormaPago.Comision2]
Carpeta=Detalles
Clave=FormaPago.Comision2
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalles.FormaPago.Importacion]
Carpeta=Detalles
Clave=FormaPago.Importacion
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco








[Acciones.MovEsp]
Nombre=MovEsp
Boton=30
NombreDesplegar=Movimientos Especificos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=FormaPagoMovEsp
Activo=S
Antes=S










AntesExpresiones=Asigna(Info.FormaPago, FormaPago:FormaPago.FormaPago)
Visible=S
[Detalles.FormaPago.CobroIntegrado]
Carpeta=Detalles
Clave=FormaPago.CobroIntegrado
Editar=S
ValidaNombre=N
3D=S
ColorFondo=Blanco




LineaNueva=S
Tamano=20



[Acciones.AccesoEsp]
Nombre=AccesoEsp
Boton=80
NombreDesplegar=Accesos Espeficos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=FormaPagoAcceso
Activo=S
Antes=S



































AntesExpresiones=Asigna(Info.FormaPago, FormaPago:FormaPago.FormaPago)
VisibleCondicion=General.NivelAcceso y(General.NivelAccesoEsp)





















[Detalles.FormaPago.TCActivarInterfaz]
Carpeta=Detalles
Clave=FormaPago.TCActivarInterfaz
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco










Tamano=30






[InterfazTC]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Tarjeta Bancaria
Clave=InterfazTC
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=FormaPago
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

Pestana=S

CondicionVisible=General.InterfazTC y(FormaPago:FormaPago.TCActivarInterfaz)
[InterfazTC.FormaPago.TCTipoPlan]
Carpeta=InterfazTC
Clave=FormaPago.TCTipoPlan
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[InterfazTC.FormaPago.TCNoMeses]
Carpeta=InterfazTC
Clave=FormaPago.TCNoMeses
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20



[InterfazTC.FormaPago.TCDiferirMeses]
Carpeta=InterfazTC
Clave=FormaPago.TCDiferirMeses
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



















[Lista.ListaOrden]
(Inicio)=FormaPago.Orden	(Acendente)
FormaPago.Orden	(Acendente)=FormaPago.FormaPago	(Acendente)
FormaPago.FormaPago	(Acendente)=(Fin)

[Detalles.ListaEnCaptura]
(Inicio)=FormaPago.FormaPago
FormaPago.FormaPago=FormaPago.Grupo
FormaPago.Grupo=FormaPago.MovIngresos
FormaPago.MovIngresos=FormaPago.MovEgresos
FormaPago.MovEgresos=FormaPago.Cuenta
FormaPago.Cuenta=Cta.Descripcion
Cta.Descripcion=FormaPago.Moneda
FormaPago.Moneda=FormaPago.DefCtaDinero
FormaPago.DefCtaDinero=FormaPago.RequiereReferencia
FormaPago.RequiereReferencia=FormaPago.PermiteCambio
FormaPago.PermiteCambio=FormaPago.Restringida
FormaPago.Restringida=FormaPago.Importacion
FormaPago.Importacion=FormaPago.Comision
FormaPago.Comision=FormaPago.Comision2
FormaPago.Comision2=FormaPago.Impuestos
FormaPago.Impuestos=FormaPago.PV
FormaPago.PV=FormaPago.TarjetaBandaMagnetica
FormaPago.TarjetaBandaMagnetica=FormaPago.CobroIntegrado
FormaPago.CobroIntegrado=FormaPago.TCActivarInterfaz
FormaPago.TCActivarInterfaz=(Fin)



[LDI]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=LDI
Clave=LDI
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=FormaPago
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

CondicionVisible=General.InterfazLDI
[LDI.FormaPago.LDIServicio]
Carpeta=LDI
Clave=FormaPago.LDIServicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco



[POS]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=POS
Clave=POS
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=FormaPago
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


CondicionVisible=General.POS
[POS.FormaPago.Recoleccion]
Carpeta=POS
Clave=FormaPago.Recoleccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POS.FormaPago.POSDenominacion]
Carpeta=POS
Clave=FormaPago.POSDenominacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POS.FormaPago.AbreCajon]
Carpeta=POS
Clave=FormaPago.AbreCajon
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[LDI.FormaPago.POSForma]
Carpeta=LDI
Clave=FormaPago.POSForma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco




[POS.ListaEnCaptura]
(Inicio)=FormaPago.Recoleccion
FormaPago.Recoleccion=FormaPago.POSDenominacion
FormaPago.POSDenominacion=FormaPago.AbreCajon
FormaPago.AbreCajon=(Fin)






[LDI.ListaEnCaptura]
(Inicio)=FormaPago.LDI
FormaPago.LDI=FormaPago.LDIServicio
FormaPago.LDIServicio=FormaPago.POSForma
FormaPago.POSForma=(Fin)

[LDI.FormaPago.LDI]
Carpeta=LDI
Clave=FormaPago.LDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco









[InterfazTC.ListaEnCaptura]
(Inicio)=FormaPago.TCTipoPlan
FormaPago.TCTipoPlan=FormaPago.TCNoMeses
FormaPago.TCNoMeses=FormaPago.TCDiferirMeses
FormaPago.TCDiferirMeses=(Fin)









































[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalles
Detalles=InterfazTC
InterfazTC=POS
POS=LDI
LDI=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Denominaciones
Denominaciones=FormaPagoDesc
FormaPagoDesc=Grupos
Grupos=Orden
Orden=MovEsp
MovEsp=AccesoEsp
AccesoEsp=(Fin)
