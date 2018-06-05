
[Forma]
Clave=POSTarjetaRegalo
Icono=0
Modulos=(Todos)
Nombre=Tarjeta de Regalo
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Variables
CarpetaPrincipal=Variables
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=414
PosicionInicialArriba=307
PosicionInicialAlturaCliente=160
PosicionInicialAncho=842
Menus=S
ListaAcciones=(Lista)
MenuTouchScreen=S
VentanaExclusiva=S
VentanaSinIconosMarco=S
VentanaExclusivaOpcion=0
MenuTouchScreenMostrarTeclasFuncion=S
ExpresionesAlMostrar=Asigna(Info.PosMonedero,Nulo)
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
CarpetaVisible=S

ConFuenteEspecial=S

ListaEnCaptura=Info.POSMonedero

[Acciones.Activar]
Nombre=Activar
Boton=0
TeclaFuncion=F11
NombreDesplegar=&Activar Monedero Nuevo
TipoAccion=Expresion
Activo=S
Visible=S

































Multiple=S
ListaAccionesMultiples=(Lista)

ConCondicion=S
EjecucionCondicion=ConDatos(Info.POSMonedero)
[Acciones.Activar.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Activar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S









Expresion=Asigna(Temp.Logico,SQL(<T>SELECT ISNULL(MonederoLDI,0) FROM POSCfg pc   WHERE Empresa =:tEmpresa<T>,Empresa))<BR><BR>Si Temp.Logico<BR>Entonces<BR>Asigna(Temp.Reg3, SQL(<T>EXEC spPOSLDI :tServicio, :tID, :tMonedero, :tEmpresa, :tUsuario, :nSucursal<T>, <T>MON ALTA NUEVO<T>, Info.IDTexto, Info.POSMonedero,Empresa, Usuario, Sucursal))<BR><BR><BR>Si Temp.Reg3[1] <> Nulo Entonces Error(Temp.Reg3[2]) Fin<BR>Si Temp.Reg3[1] = Nulo Entonces Informacion(Temp.Reg3[3]) Fin<BR>Si Temp.Reg3[1] = Nulo Entonces Forma.Accion(<T>Cerrar<T>) Fin<BR>Si Temp.Reg3[1] = Nulo Entonces ReportePantalla(<T>POSMonedero<T>) Fin<BR><BR>Asigna(Temp.Reg3, Nulo)<BR>Fin<BR>Asigna(Temp.Texto,SQL(<T>spPOSAsociarMonedero  :tID, :tMonedero,:tUsuario, :nEstacion<T>,Info.IDTexto,Info.POSMonedero,Usuario,EstacionTrabajo))<BR><BR>Si(ConDatos(Temp.Texto),ERROR(Temp.Texto))
[Acciones.Consultar]
Nombre=Consultar
Boton=0
NombreDesplegar=&Consultar Saldo
TipoAccion=Expresion
Activo=S
Visible=S

TeclaFuncion=F4







Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.Consultar.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Consultar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Temp.Reg3, SQL(<T>EXEC spPOSLDI :tServicio, :tID, :tMonedero, :tEmpresa, :tUsuario, :nSucursal<T>, <T>MON CONSULTA<T>, Info.IDTexto, Info.POSMonedero,Empresa,Usuario, Sucursal))<BR><BR>Si Temp.Reg3[1] <> Nulo Entonces Error(Temp.Reg3[2]) Fin<BR>Si Temp.Reg3[1] = Nulo Entonces Si Confirmacion(Temp.Reg3[3], BotonSi, BotonNo)=BotonSi Entonces ReportePantalla(<T>POSSaldoMonedero<T>)Fin  Fin<BR><BR>Asigna(Temp.Reg3, Nulo)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
TeclaFuncion=F3
NombreDesplegar=&Desasociar Tarjeta
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S






Antes=S


Multiple=S
ListaAccionesMultiples=(Lista)
AntesExpresiones=Asigna(Info.POSMonedero, Nulo)<BR>Asigna(Temp.Reg3, Nulo)
[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
NombreDesplegar=&Cerrar
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S










UsaTeclaRapida=S
TeclaFuncion=F2
EnMenu=S
[Acciones.LigarSaldoFavor.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.LigarSaldoFavor.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Temp.Reg3, SQL(<T>EXEC spPOSLDI :tServicio, :tID, :tMonedero, :tEmpresa, :tUsuario, :nSucursal<T>, <T>MON CONSULTA<T>, Info.IDTexto, Info.POSMonedero,Empresa,Usuario, Sucursal))<BR><BR>Si Temp.Reg3[1] <> Nulo Entonces Error(Temp.Reg3[2]) Fin<BR>Si Temp.Reg3[1] = Nulo Entonces Informacion(Temp.Reg3[3]) Fin<BR>Si Temp.Reg3[1] = Nulo Entonces Informacion(SQL(<T>spPOSLDIMonederoSaldoFavor :tID, :tMonedero<T>, Info.IDTexto, Info.POSMonedero)) Fin<BR><BR>Asigna(Info.POSMonedero, Nulo)<BR>Asigna(Temp.Reg3, Nulo)
[Acciones.LigarSaldoFavor]
Nombre=LigarSaldoFavor
Boton=0
TeclaFuncion=F6
NombreDesplegar=Ligar para Saldo a Favor
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S




UsaTeclaRapida=S
TeclaRapida=F6



[Variables.Info.POSMonedero]
Carpeta=Variables
Clave=Info.POSMonedero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=37
ColorFondo=Blanco
















[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S




[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Aceptar
Aceptar=(Fin)





[Acciones.Asociar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Asociar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Temp.Texto,SQL(<T>spPOSAsociarTarjetaRegalo  :tID, :tMonedero,:tUsuario, :nEstacion, :nImporte<T>,Info.IDTexto,Info.POSMonedero,Usuario,EstacionTrabajo, Info.POSImporteRef))
[Acciones.Asociar]
Nombre=Asociar
Boton=0
NombreDesplegar=Asociar Tarjeta
Multiple=S
EnMenu=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S


TeclaFuncion=F12




ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Info.Anuncio,SQL(<T>SELECT dbo.fnPOSValidarMonedero (:tMonedero)<T>,Info.POSMonedero))  <BR>Vacio(Info.Anuncio)
EjecucionMensaje=Info.Anuncio
[Acciones.Asociar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S









[Acciones.Cancelar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spPOSDesAsociarTarjetaRegalo  :tID, :tMonedero,:tUsuario, :nEstacion<T>,Info.IDTexto,Nulo,Usuario,EstacionTrabajo)
[Acciones.Cancelar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





[Acciones.Sugerir]
Nombre=Sugerir
Boton=0
TeclaFuncion=F8
NombreDesplegar=Sugerir Monedero
TipoAccion=Expresion
Activo=S
Visible=S




















Expresion=Asigna(Info.POSMonedero,SQL(<T>spPOSSugerirMonedero :nEstacion,:tEmpresa,:nSucursal<T>,Estaciontrabajo,Empresa,Sucursal))
[Acciones.Activar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Acciones.POSLDIEdoCta]
Nombre=POSLDIEdoCta
Boton=0
NombreDesplegar=Estado de Cuenta
TipoAccion=Expresion
Activo=S
Visible=S








































































































TeclaFuncion=F5
RefrescarDespues=S
Expresion=Dialogo(<T>POSLDIEdoCta<T>)
[Acciones.POSLDIEdoCta.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.POSLDIEdoCta.POSLDIEdoCta]
Nombre=POSLDIEdoCta
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Dialogo(<T>POSLDIEdoCta<T>)


[Acciones.POSLDIEdoCta.ListaAccionesMultiples]
(Inicio)=POSLDIEdoCta
POSLDIEdoCta=Variables Asignar
Variables Asignar=(Fin)













[Acciones.Consultar.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)


[Acciones.Activar.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=Aceptar
Aceptar=(Fin)


[Acciones.LigarSaldoFavor.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)















[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)


























[Acciones.Asociar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=Aceptar
Aceptar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cancelar
Cancelar=Consultar
Consultar=Activar
Activar=LigarSaldoFavor
LigarSaldoFavor=Asociar
Asociar=Sugerir
Sugerir=Cerrar
Cerrar=POSLDIEdoCta
POSLDIEdoCta=(Fin)
