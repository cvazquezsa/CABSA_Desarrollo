
[Forma]
Clave=POSMonedero
Icono=0
Modulos=(Todos)
Nombre=Monedero
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Variables
CarpetaPrincipal=Variables
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=559
PosicionInicialArriba=428
PosicionInicialAlturaCliente=145
PosicionInicialAncho=802
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaSinIconosMarco=S
VentanaExclusivaOpcion=0
MenuTouchScreenMostrarTeclasFuncion=S
VentanaColor=$00804000
DeshabilitarAyuda=S
Menus=S
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
Fuente={Segoe UI, 18, Blanco, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=$00804000
FichaAlineacionDerecha=S
CampoColorLetras=Rojo obscuro
CampoColorFondo=Blanco
CarpetaVisible=S

ConFuenteEspecial=S

ListaEnCaptura=Info.POSMonedero

BarraBotones=S
BarraBtnFuente={Segoe UI, 8, Blanco, []}
BarraBtnFondo=$00804000
ListaAccionesBB=(Lista)
BarraBtnPosicion=Abajo
BarraBtnSize=80
BarraBtnSeparacion=2
BarraBtnSinBisel=S
BarraBtnBisel=0
BarraBtnPaginas=5
[Acciones.Activar]
Nombre=Activar
Boton=0
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
ConCondicion=S
EjecucionCondicion=ConDatos(Info.POSMonedero)


[Acciones.Consultar]
Nombre=Consultar
Boton=0
NombreDesplegar=&Consultar Saldo
TipoAccion=Expresion
Activo=S
Visible=S








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
ConCondicion=S
EjecucionCondicion=ConDatos(Info.POSMonedero)


[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=&Desasociar Monedero
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

NombreDesplegar=Ligar para Saldo a Favor
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S


TeclaFuncion=F7



[Variables.Info.POSMonedero]
Carpeta=Variables
Clave=Info.POSMonedero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=37
ColorFondo=Blanco
















ColorFuente=Rojo obscuro
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

Expresion=Asigna(Temp.Texto,SQL(<T>spPOSAsociarMonedero  :tID, :tMonedero,:tUsuario, :nEstacion<T>,Info.IDTexto,Info.POSMonedero,Usuario,EstacionTrabajo))<BR><BR>Si(ConDatos(Temp.Texto),ERROR(Temp.Texto))
ConCondicion=S
EjecucionCondicion=ConDatos(Info.POSMonedero)

[Acciones.Asociar]
Nombre=Asociar
Boton=0
NombreDesplegar=Asociar Monedero
Multiple=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S






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

Expresion=EjecutarSQL(<T>spPOSDesAsociarMonedero  :tID, :tMonedero,:tUsuario, :nEstacion<T>,Info.IDTexto,Nulo,Usuario,EstacionTrabajo)
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





























EspacioPrevio=S











































































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




[Acciones.POSLDIEdoCta.Variables Asignar2]
Nombre=Variables Asignar2
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.POSLDIEdoCta.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Dialogo(<T>POSLDIEdoCta<T>)
ConCondicion=S
EjecucionCondicion=ConDatos(Info.POSMonedero)


[Acciones.POSLDIEdoCta.ListaAccionesMultiples]
(Inicio)=POSLDIEdoCta
POSLDIEdoCta=Variables Asignar
Variables Asignar=(Fin)







[Acciones.Cierra]
Nombre=Cierra
Boton=0
TeclaFuncion=ESC
NombreDesplegar=<T>Cerrar<T>
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=ESC.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado




TipoAccion=Ventana
ClaveAccion=Cerrar
[Acciones.Separador1]
Nombre=Separador1
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=5
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1

[Acciones.Separador2]
Nombre=Separador2
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1



[Acciones.Cancela]
Nombre=Cancela
Boton=0
TeclaFuncion=F1
NombreDesplegar=<T>Desasociar Monedero<T>
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F1.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

ListaAccionesMultiples=(Lista)
Antes=S
AntesExpresiones=Asigna(Info.POSMonedero, Nulo)<BR>Asigna(Temp.Reg3, Nulo)
[Acciones.Cancela.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=EjecutarSQL(<T>spPOSDesAsociarMonedero :tID, :tMonedero, :tUsuario, :nEstacion<T>, Info.IDTexto, Nulo, Usuario, EstacionTrabajo)
[Acciones.Consulta.Asigna]
Nombre=Asigna
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Consulta.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>  Info.MonederoCB<BR>ENTONCES<BR>  Asigna(Info.Mensaje,nulo)<BR>  Asigna(Info.Mensaje,SQL(<T>EXEC spPOSMonederoSaldoEdoCta :tEmpresa, :tMonedero, :tUsuario, :nEstacion, :nSucursal, :tQueEs<T>, Empresa, Info.POSMonedero, Usuario, EstacionTrabajo, Sucursal, <T>SALDO<T> ))<BR>  Si<BR>    ConDatos(Info.Mensaje)<BR>  Entonces<BR>    Informacion(Info.Mensaje)<BR>  Sino<BR>     ReportePantalla(<T>SaldoPOS<T>)<BR>  Fin<BR>Sino<BR>  Asigna(Temp.Reg3, SQL(<T>EXEC spPOSLDI :tServicio, :tID, :tMonedero, :tEmpresa, :tUsuario, :nSucursal<T>, <T>MON CONSULTA<T>, Info.IDTexto, Info.POSMonedero,Empresa,Usuario, Sucursal))<BR>  Si Temp.Reg3[1] <> Nulo Entonces Error(Temp.Reg3[2]) Fin<BR>  Si Temp.Reg3[1] = Nulo Entonces Si Confirmacion(Temp.Reg3[3], BotonSi, BotonNo)=BotonSi Entonces ReportePantalla(<T>POSSaldoMonedero<T>)Fin  Fin<BR>  Asigna(Temp.Reg3, Nulo)<BR>Fin
ConCondicion=S
EjecucionCondicion=ConDatos(Info.POSMonedero)
[Acciones.Consulta]
Nombre=Consulta
Boton=0
NombreDesplegar=<T>Consultar Saldo<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F2.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado



TeclaFuncion=F2

[Acciones.EdoCta]
Nombre=EdoCta
Boton=0
NombreDesplegar=<T>Estado de Cuenta<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F3.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F3
Expresion=
Multiple=S
ListaAccionesMultiples=(Lista)


[Acciones.Sugiere]
Nombre=Sugiere
Boton=0
TeclaFuncion=F4
NombreDesplegar=<T>Sugerir Monedero<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F4.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=Asigna(Info.POSMonedero,SQL(<T>spPOSSugerirMonedero :nEstacion,:tEmpresa,:nSucursal<T>,Estaciontrabajo,Empresa,Sucursal))
[Acciones.Consulta.ListaAccionesMultiples]
(Inicio)=Asigna
Asigna=Expresion
Expresion=(Fin)







[Acciones.Separador3]
Nombre=Separador3
Boton=0
NombreDesplegar=<T>Seperador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1



[Acciones.Activa]
Nombre=Activa
Boton=0
TeclaFuncion=F5
NombreDesplegar=<T>Activar Monedero Nuevo<T>
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F5.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado



Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Asocia]
Nombre=Asocia
Boton=0
NombreDesplegar=<T>Asociar Monedero Nuevo<T>
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F6.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado


TeclaFuncion=F6
Multiple=S
ListaAccionesMultiples=(Lista)

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


[Acciones.Asociar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=Aceptar
Aceptar=(Fin)
















[Acciones.Cancela.Cierra]
Nombre=Cierra
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





[Acciones.Activa.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Activa.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

ConCondicion=S
Expresion=Si<BR>  Info.MonederoCB<BR>Entonces<BR>  Asigna(Temp.Texto,nulo)<BR>  Asigna(Temp.Texto,SQL(<T>EXEC spPOSMonederoActivar :tEmpresa, :tMonedero, :tUsuario, :nEstacion, :nSucursal, :tID<T>, Empresa, Info.POSMonedero, Usuario, EstacionTrabajo, Sucursal, Info.IDTexto ))<BR>  Si(ConDatos(Temp.Texto),ERROR(Temp.Texto))<BR>  Si(Vacio(Temp.Texto),Informacion(<T>LA TARJETA SE ACTIVÓ CON ÉXITO<T>))<BR>Sino<BR>  Asigna(Temp.Logico,SQL(<T>SELECT ISNULL(MonederoLDI,0) FROM POSCfg pc   WHERE Empresa =:tEmpresa<T>,Empresa))<BR>  Si<BR>    Temp.Logico<BR>  Entonces<BR>    Asigna(Temp.Reg3, SQL(<T>EXEC spPOSLDI :tServicio, :tID, :tMonedero, :tEmpresa, :tUsuario, :nSucursal<T>, <T>MON ALTA NUEVO<T>, Info.IDTexto, Info.POSMonedero,Empresa, Usuario, Sucursal))<BR>    Si Temp.Reg3[1] <> Nulo Entonces Error(Temp.Reg3[2]) Fin<BR>    Si Temp.Reg3[1] = Nulo Entonces Informacion(Temp.Reg3[3]) Fin<BR>    Si Temp.Reg3[1] = Nulo Entonces Forma.Accion(<T>Cerrar<T>) Fin<BR>    Si Temp.Reg3[1] = Nulo Entonces ReportePantalla(<T>POSMonedero<T>) Fin<BR>    Asigna(Temp.Reg3, Nulo)<BR>  Fin<BR>  Asigna(Temp.Texto,SQL(<T>spPOSAsociarMonedero  :tID, :tMonedero,:tUsuario, :nEstacion<T>,Info.IDTexto,Info.POSMonedero,Usuario,EstacionTrabajo))<BR>  Si(ConDatos(Temp.Texto),ERROR(Temp.Texto))<BR>Fin
EjecucionCondicion=ConDatos(Info.POSMonedero)
[Acciones.Activa.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Vacio(Temp.Texto)









[Acciones.Asocia.Asigna]
Nombre=Asigna
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Asocia.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>  Info.MonederoCB<BR>ENTONCES<BR>  Asigna(Temp.Texto,nulo)<BR>  Asigna(Temp.Texto,SQL(<T>EXEC spPOSMonederoAsociar :tEmpresa, :tMonedero, :tUsuario, :nEstacion, :nSucursal, :tID<T>, Empresa, Info.POSMonedero, Usuario, EstacionTrabajo, Sucursal, Info.IDTexto ))<BR>  Si(ConDatos(Temp.Texto),ERROR(Temp.Texto))<BR>  Si(Vacio(Temp.Texto),Informacion(<T>TARJETA ASOCIADA CON ÉXITO<T>))<BR>Sino<BR>  Asigna(Temp.Texto,SQL(<T>spPOSAsociarMonedero  :tID, :tMonedero,:tUsuario, :nEstacion<T>,Info.IDTexto,Info.POSMonedero,Usuario,EstacionTrabajo))<BR>  Si(ConDatos(Temp.Texto),ERROR(Temp.Texto))<BR>Fin
ConCondicion=S
EjecucionCondicion=ConDatos(Info.POSMonedero)
[Acciones.Asocia.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Vacio(Temp.Texto)

[Acciones.Activa.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=Aceptar
Aceptar=(Fin)

[Acciones.Asocia.ListaAccionesMultiples]
(Inicio)=Asigna
Asigna=Expresion
Expresion=Aceptar
Aceptar=(Fin)



[Acciones.Cancela.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cierra
Cierra=(Fin)

[Variables.ListaAccionesBB]
(Inicio)=Separador1
Separador1=Cierra
Cierra=Separador2
Separador2=Cancela
Cancela=Consulta
Consulta=EdoCta
EdoCta=Sugiere
Sugiere=Separador3
Separador3=Activa
Activa=Asocia
Asocia=(Fin)


[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)


[Acciones.EdoCta.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.EdoCta.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si<BR>  Info.MonederoCB<BR>ENTONCES<BR>  Asigna(Info.Mensaje,nulo)<BR>  Asigna(Info.Mensaje,SQL(<T>EXEC spPOSMonederoSaldoEdoCta :tEmpresa, :tMonedero, :tUsuario, :nEstacion, :nSucursal, :tQueEs<T>, Empresa, Info.POSMonedero, Usuario, EstacionTrabajo, Sucursal, <T>EDOCTA<T> ))<BR>  Si<BR>    ConDatos(Info.Mensaje)<BR>  Entonces<BR>    Informacion(Info.Mensaje)<BR>  Sino<BR>     ReportePantalla(<T>EstadoMonederoPos<T>)<BR>  Fin<BR>Sino<BR>  Dialogo(<T>POSLDIEdoCta<T>)<BR>Fin

[Acciones.EdoCta.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)





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
