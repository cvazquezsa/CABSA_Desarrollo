
[Forma]
Clave=POSLDIVales
Icono=0
Modulos=(Todos)
Nombre=Vale Electronico

ListaCarpetas=Variables
CarpetaPrincipal=Variables
PosicionInicialAlturaCliente=167
PosicionInicialAncho=845
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=329
PosicionInicialArriba=316
Menus=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
MenuTouchScreen=S
ListaAcciones=(Lista)
MenuTouchScreenMostrarTeclasFuncion=S
VentanaSinIconosMarco=S
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=Asigna(Info.LDIVale,Nulo)<BR>Asigna(Info.LDIVale,Nulo)
[Variables]
Estilo=Ficha
Clave=Variables
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 20, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Info.LDIVale
CarpetaVisible=S

ConFuenteEspecial=S


[Acciones.Recargar.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
Activo=S
Visible=S











ClaveAccion=Variables Asignar

[Acciones.Recargar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S






















ConCondicion=S
EjecucionConError=S
Expresion=EjecutarSQL(<T>spPOSInsertarLDIRecargaTemp :tID, :tServicio, :tEmpresa, :tUsuario, :nSucursal, :nImporte, :tTelefono<T>,Info.IDTexto, Info.Servicio, Empresa, Usuario, Sucursal, Info.Importe,Info.POSNoTelefono)<BR>//Asigna(Temp.Reg2, SQL(<T>EXEC spPOSLDI :tServicio, :tID, :tMonedero,:tEmpresa, :tUsuario,:nSucursal,:nTarjReemp, :Importe, :nEnSilencio, :tNoTel<T>, Info.Servicio, Info.IDTexto, Nulo,Empresa, Usuario, sucursal, Nulo, Info.Importe, 0, Info.POSNoTelefono))<BR><BR>//Si Temp.Reg2[1] <> Nulo Entonces Error(Temp.Reg2[2]) Fin<BR>//Si Temp.Reg2[1] = Nulo Entonces Informacion(Temp.Reg2[3]) Fin<BR>//Si Temp.Reg2[1] = Nulo Entonces Asigna(Info.Servicio, Nulo) Fin<BR>//Si Temp.Reg2[1] = Nulo Entonces Forma.Accion(<T>Cerrar<T>) Fin<BR>EjecutarSQL(<T>spPOSLDITicket :tID, :nIDLog,:nEstacion<T>,Info.IDTexto,Nulo,EstacionTrabajo)<BR>Asigna(Info.POSNoTelefono, Nulo)<BR>Asigna(Info.POSNoTelefonoConf, Nulo)
EjecucionCondicion=Info.POSNoTelefono = Info.POSNoTelefonoConf
EjecucionMensaje=<T>El telefono confirmado no corresponde<T>

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
NombreDesplegar=Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Antes=S
Visible=S
TeclaFuncion=F2
EnMenu=S
UsaTeclaRapida=S
TeclaRapida=F2
EsDefault=S
AntesExpresiones=Asigna(Info.POSLDIError, <T>Forma de Pago Incorrecta<T>) Fin

[Acciones.Recargar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S











[Variables.ListaEnCaptura]
(Inicio)=Info.POSNoTelefono
Info.POSNoTelefono=Info.POSNoTelefonoConf
Info.POSNoTelefonoConf=(Fin)










[Acciones.Cerrar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=Cerrar
Cerrar=(Fin)














[Acciones.Recargar.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=Cerrar
Cerrar=(Fin)


[Acciones.Consumo]
Nombre=Consumo
Boton=0
TeclaFuncion=F12
NombreDesplegar=&Ejecutar Consumo
Multiple=S
EnMenu=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S






[Acciones.Consumo.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S







Expresion=Si Info.Importe > 0.0<BR>  Entonces<BR>    EjecutarSQL(<T>spPOSLDIADOParametros :tID, :tServicio, :tEmpresa, :tUsuario, :nSucursal, :nImporte, :tMonedero<T>,Info.IDTexto ,<T>VALECARGO<T>,Empresa,Usuario,Sucursal, Info.Importe,Info.LDIVale)<BR>    ADO.EjecutarSQL(<T>a<T>,<T>spPOSLDIADO <T>+Comillas(Info.IDTexto))<BR>    Asigna(Temp.Reg3, SQL(<T>EXEC spPOSLDIADOResultado :tID<T>, Info.IDTexto))<BR>  Sino<BR>    EjecutarSQL(<T>spPOSLDIADOParametros :tID, :tServicio, :tEmpresa, :tUsuario, :nSucursal, :nImporte, :tMonedero<T>,Info.IDTexto ,<T>VALECARGO<T>,Empresa,Usuario,Sucursal, Info.Importe,Info.LDIVale)<BR>    ADO.EjecutarSQL(<T>a<T>,<T>spPOSLDIADO <T>+Comillas(Info.IDTexto))<BR>    Asigna(Temp.Reg3, SQL(<T>EXEC spPOSLDIADOResultado :tID<T>, Info.IDTexto))<BR>Fin<BR><BR>Si Temp.Reg3[1] <> Nulo Entonces Error(Temp.Reg3[2]) Fin<BR>Si Temp.Reg3[1] <> Nulo Entonces Asigna(Info.POSLDIError, Temp.Reg3[2]) Fin<BR>Si Temp.Reg3[1] = Nulo Entonces Asigna(Info.POSLDIError, Nulo) Fin<BR>Si Temp.Reg3[1] = Nulo<BR>Entonces<BR>  Informacion(<T>Transacción Aprobada<T>)<BR>  EjecutarSQL(<T>spPOSLDITicket :tID, :nIDLog,:nEstacion<T>,Info.IDTexto,Temp.Reg3[6],EstacionTrabajo)<BR>  ReporteImpresora(<T>POSTicketLDI<T>)<BR>  ReporteImpresora(<T>POSTicketLDICopia<T>)<BR><BR><BR>Fin<BR>Si Temp.Reg3[1] = Nulo Entonces Forma.Accion(<T>CerrarSinError<T>) Fin<BR><BR>Asigna(Info.LDIVale, Nulo)
[Acciones.Consumo.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar

[Acciones.Consumo.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar


















[Acciones.Consulta]
Nombre=Consulta
Boton=0
NombreDesplegar=Consultar Saldo
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S








Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.CerrarVentana]
Nombre=Cerrar
Boton=0
NombreDesplegar=Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Antes=S
Visible=S
EnMenu=S
AntesExpresiones=Asigna(Info.POSLDIError, <T>Forma de Pago Incorrecta<T>) Fin




[Acciones.Consulta.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Consulta.expresion]
Nombre=expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Temp.Reg3, SQL(<T>EXEC spPOSLDI :tServicio, :tID, :tMonedero, :tEmpresa, :tUsuario, :nSucursal<T>, <T>ValeSaldos<T>, Info.IDTexto, Info.LDIVale,Empresa,Usuario, Sucursal))<BR><BR>Si Temp.Reg3[1] <> Nulo Entonces Error(Temp.Reg3[2]) Sino Informacion(Temp.Reg3[3]) Fin<BR>Asigna(Temp.Reg3, Nulo)

[Variables.Info.LDIVale]
Carpeta=Variables
Clave=Info.LDIVale
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[Acciones.Consumo.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=Cerrar
Cerrar=(Fin)




[Acciones.Consulta.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=expresion
expresion=(Fin)





[Forma.ListaAcciones]
(Inicio)=CerrarVentana
CerrarVentana=Consumo
Consumo=Cerrar
Cerrar=Consulta
Consulta=(Fin)
