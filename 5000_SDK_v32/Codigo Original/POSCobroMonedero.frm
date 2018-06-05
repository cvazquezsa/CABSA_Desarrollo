
[Forma]
Clave=POSCobroMonedero
Icono=0
Modulos=(Todos)
Nombre=Monedero

ListaCarpetas=Variables
CarpetaPrincipal=Variables
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=293
PosicionInicialArriba=274
PosicionInicialAlturaCliente=140
PosicionInicialAncho=780
VentanaExclusiva=S
VentanaSinIconosMarco=S
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=Asigna(Info.POSMonedero, Nulo)
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
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Info.POSMonedero
CarpetaVisible=S

ConFuenteEspecial=S
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
[Variables.Info.POSMonedero]
Carpeta=Variables
Clave=Info.POSMonedero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Blanco



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








Expresion=Asigna(Temp.Reg, SQL(<T>EXEC spPOSLDI :tServicio, :tID, :tMonedero<T>, <T>MON ALTA NUEVO<T>, Info.IDTexto, Info.POSMonedero))<BR><BR>Si Temp.Reg[1] <> Nulo Entonces Error(Temp.Reg[2]) Fin<BR><BR>Si Temp.Reg[1] = Nulo Entonces Informacion(Temp.Reg[3]) Fin<BR>Si Temp.Reg[1] = Nulo Entonces Forma.Accion(<T>Cerrar<T>) Fin<BR>Si Temp.Reg[1] = Nulo Entonces ReportePantalla(<T>POSMonedero<T>) Fin

[Acciones.Consultar]
Nombre=Consultar
Boton=0
NombreDesplegar=&Consultar Saldo
EnMenu=S
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




Expresion=Asigna(Temp.Reg3, SQL(<T>EXEC spPOSLDI :tServicio, :tID, :tMonedero,:tEmpresa,:tUsuario,:nSucursal<T>, <T>MON CONSULTA<T>, Info.IDTexto, Info.POSMonedero,Empresa,Usuario,Sucursal))<BR><BR>Si Temp.Reg3[1] <> Nulo Entonces Error(Temp.Reg3[2]) Fin<BR><BR>Si Temp.Reg3[1] = Nulo Entonces Informacion(Temp.Reg3[3]) Fin<BR><BR>Asigna(Temp.Reg3, Nulo)
[Acciones.Activar.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)

















[Acciones.AplicarCobro]
Nombre=AplicarCobro
Boton=0
TeclaFuncion=F12
NombreDesplegar=&Aplicar Cobro
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S



Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.AplicarCobro.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S










[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
TeclaFuncion=F2
NombreDesplegar=&Cerrar
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S































Antes=S
AntesExpresiones=Asigna(Info.POSLDIError, <T>Forma de Pago Incorrecta<T>) Fin
[Acciones.CerrarSinError]
Nombre=CerrarSinError
Boton=0
NombreDesplegar=CerrarSinError
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S










[Acciones.AplicarCobro.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S







[Acciones.AplicarCobro.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Aceptar
Aceptar=(Fin)




[Acciones.Consultar.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)































[Acciones.Consulta]
Nombre=Consulta
Boton=0
TeclaFuncion=f1
NombreDesplegar=<T>Consultar Saldo<T>
Multiple=S
Activo=S
Visible=S
BarraBtnFondo=$00C08000


ListaAccionesMultiples=(Lista)
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F1.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
[Forma.ListaAcciones]
(Inicio)=Consultar
Consultar=AplicarCobro
AplicarCobro=Cerrar
Cerrar=CerrarSinError
CerrarSinError=(Fin)

[Acciones.Cierra]
Nombre=Cierra
Boton=0
TeclaFuncion=ESC
NombreDesplegar=<T>Cerrar<T>
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Antes=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Esc.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






AntesExpresiones=Asigna(Info.POSLDIError, <T>Forma de Pago Incorrecta<T>) Fin
[Acciones.Consulta.Asigna]
Nombre=Asigna
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Consulta.Expreciones]
Nombre=Expreciones
Boton=0
TipoAccion=Expresion
Expresion=Si<BR>  Info.MonederoCB<BR>ENTONCES<BR>  Asigna(Info.Mensaje,nulo)<BR>  Asigna(Info.Mensaje,SQL(<T>EXEC spPOSMonederoSaldoEdoCta :tEmpresa, :tMonedero, :tUsuario, :nEstacion, :nSucursal, :tQueEs<T>, Empresa, Info.POSMonedero, Usuario, EstacionTrabajo, Sucursal, <T>SALDO<T> ))<BR>  Si<BR>    ConDatos(Info.Mensaje)<BR>  Entonces<BR>    Informacion(Info.Mensaje)<BR>  Sino<BR>     ReportePantalla(<T>SaldoPOS<T>)<BR>  Fin<BR>Sino<BR>  Asigna(Temp.Reg3, SQL(<T>EXEC spPOSLDI :tServicio, :tID, :tMonedero,:tEmpresa,:tUsuario,:nSucursal<T>, <T>MON CONSULTA<T>, Info.IDTexto, Info.POSMonedero,Empresa,Usuario,Sucursal))<BR>  Si Temp.Reg3[1] <> Nulo Entonces Error(Temp.Reg3[2]) Fin<BR>  Si Temp.Reg3[1] = Nulo Entonces Informacion(Temp.Reg3[3]) Fin<BR>  Asigna(Temp.Reg3, Nulo)<BR>Fin
Activo=S
Visible=S


[Acciones.AplicaCobro.Asigna]
Nombre=Asigna
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.AplicaCobro.Acepta]
Nombre=Acepta
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.AplicaCobro]
Nombre=AplicaCobro
Boton=0
TeclaFuncion=F2
NombreDesplegar=<T>Aplicar Cobro<T>
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

[Acciones.CierraSinError]
Nombre=CierraSinError
Boton=0
NombreDesplegar=<T>Cerrar Sin Error<T>
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
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









VisibleCondicion=0



[Acciones.Consulta.ListaAccionesMultiples]
(Inicio)=Asigna
Asigna=Expreciones
Expreciones=(Fin)




[Acciones.Separador1]
Nombre=Separador1
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=5
BarraBtnAlto=75
BarraBtnFondo=Plata
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
BarraBtnFondo=Plata
BarraBtnPagina=1




[Acciones.AplicaCobro.ListaAccionesMultiples]
(Inicio)=Asigna
Asigna=Acepta
Acepta=(Fin)

[Variables.ListaAccionesBB]
(Inicio)=Separador1
Separador1=Cierra
Cierra=Separador2
Separador2=Consulta
Consulta=AplicaCobro
AplicaCobro=CierraSinError
CierraSinError=(Fin)
