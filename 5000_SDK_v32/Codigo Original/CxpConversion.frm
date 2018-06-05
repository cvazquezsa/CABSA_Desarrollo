[Forma]
Clave=CxpConversion
Nombre=<T>Conversión Moneda Cargos Pendientes - Cuentas por Pagar
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=186
PosicionInicialArriba=305
PosicionInicialAltura=347
PosicionInicialAncho=652
IniciarAgregando=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsMovimiento=S
TituloAuto=S
MovModulo=Cxp
MovEspecificos=Todos
PosicionInicialAlturaCliente=124

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxpConversion
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=95
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
FichaEspacioNombresAuto=S

[Ficha.Conversion.Cuenta]
Carpeta=Ficha
Clave=Conversion.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.Prov.Nombre]
Carpeta=Ficha
Clave=Prov.Nombre
Editar=S
ValidaNombre=N
3D=S
Tamano=35
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Conversion.Mov]
Carpeta=Ficha
Clave=Conversion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Conversion.MovID]
Carpeta=Ficha
Clave=Conversion.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
Tamano=20
IgnoraFlujo=N

[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=<T>&Generar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S
GuardarAntes=S
ClaveAccion=Aceptar
Antes=S
DespuesGuardar=S
ConCondicion=S
EjecucionCondicion=CxpConversion:Conversion.MovMoneda<>CxpConversion:Conversion.Moneda
EjecucionMensaje=<T>Moneda Incorrecta<T>
EjecucionConError=S
AntesExpresiones=Si<BR>  Precaucion(<T>¿ Esta Seguro ?<T>,BotonSi,BotonNo)=BotonSi<BR>Entonces<BR>  ProcesarSQL(<T>spConversion :nID, :nSuc, :tEmp<T>, CxpConversion:Conversion.ID, Sucursal, Empresa)<BR>Sino<BR>  AbortarOperacion<BR>Fin

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
TipoAccion=Ventana
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S
EspacioPrevio=S

[Ficha.Conversion.Moneda]
Carpeta=Ficha
Clave=Conversion.Moneda
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
ValidaNombre=S
EspacioPrevio=S

[Ficha.Conversion.MovMoneda]
Carpeta=Ficha
Clave=Conversion.MovMoneda
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Conversion.TipoCambio]
Carpeta=Ficha
Clave=Conversion.TipoCambio
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.CxpPendiente.FechaEmision]
Carpeta=Ficha
Clave=CxpPendiente.FechaEmision
Editar=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Ficha.CxpPendiente.Saldo]
Carpeta=Ficha
Clave=CxpPendiente.Saldo
Editar=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[Ficha.Conversion.MovTipoCambio]
Carpeta=Ficha
Clave=Conversion.MovTipoCambio
Editar=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.Importe]
Carpeta=Ficha
Clave=Importe
Editar=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Tamano=20

[Ficha.Conversion.Movimiento]
Carpeta=Ficha
Clave=Conversion.Movimiento
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Conversion.FechaEmision]
Carpeta=Ficha
Clave=Conversion.FechaEmision
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Forma.ListaAcciones]
(Inicio)=Generar
Generar=Cancelar
Cancelar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Conversion.Cuenta
Conversion.Cuenta=Prov.Nombre
Prov.Nombre=Conversion.MovMoneda
Conversion.MovMoneda=Conversion.MovTipoCambio
Conversion.MovTipoCambio=Conversion.Mov
Conversion.Mov=Conversion.MovID
Conversion.MovID=CxpPendiente.FechaEmision
CxpPendiente.FechaEmision=CxpPendiente.Saldo
CxpPendiente.Saldo=Conversion.Moneda
Conversion.Moneda=Conversion.TipoCambio
Conversion.TipoCambio=Conversion.Movimiento
Conversion.Movimiento=Conversion.FechaEmision
Conversion.FechaEmision=Importe
Importe=(Fin)
