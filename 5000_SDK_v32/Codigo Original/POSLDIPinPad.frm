
[Forma]
Clave=POSLDIPinPad
Icono=0
Modulos=(Todos)
Nombre=Deslizar Tarjeta
AccionesTamanoBoton=15x5

ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=108
PosicionInicialAncho=832
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=267
PosicionInicialArriba=290
AccionesCentro=S
AccionesDivision=S
Menus=S
MenuTouchScreen=S
MenuTouchScreenMostrarTeclasFuncion=S
VentanaSinIconosMarco=S
[Lista]
Estilo=Ficha
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Negro
CarpetaVisible=S

FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Negro

[Acciones.Deslizar]
Nombre=Deslizar
Boton=0
NombreDesplegar=&Deslizar Tarjeta
EnBarraAcciones=S
TipoAccion=Expresion
Activo=S
Visible=S

TeclaFuncion=F12
EnMenu=S
Expresion=Si Info.Importe > 0.0<BR>  Entonces<BR>    EjecutarSQL(<T>spPOSLDIADOParametros :tID, :tServicio, :tEmpresa, :tUsuario, :nSucursal, :nImporte, :tMonedero, :tReferencia<T>,Info.IDTexto ,<T>SANTANDERPP<T>,Empresa,Usuario,Sucursal, Info.Importe,Nulo, Info.Cantidad2)<BR>    ADO.EjecutarSQL(<T>a<T>,<T>spPOSLDIADO <T>+Comillas(Info.IDTexto))<BR>    Asigna(Temp.Reg3, SQL(<T>EXEC spPOSLDIADOResultado :tID<T>, Info.IDTexto))<BR>  Sino<BR>    EjecutarSQL(<T>spPOSLDIADOParametros :tID, :tServicio, :tEmpresa, :tUsuario, :nSucursal, :nImporte, :tMonedero, :tReferencia<T>,Info.IDTexto ,<T>SANTANDERPP<T>,Empresa,Usuario,Sucursal, Info.Importe,Info.POSMonedero,Info.Cantidad2)<BR>    ADO.EjecutarSQL(<T>a<T>,<T>spPOSLDIADO <T>+Comillas(Info.IDTexto))<BR>    Asigna(Temp.Reg3, SQL(<T>EXEC spPOSLDIADOResultado :tID<T>, Info.IDTexto))<BR>Fin<BR><BR>Si Temp.Reg3[1] <> Nulo Entonces Error(Temp.Reg3[2]) Fin<BR>Si Temp.Reg3[1] <> Nulo Entonces Asigna(Info.POSLDIError, Temp.Reg3[2]) Fin<BR>Si Temp.Reg3[1] = Nulo Entonces Asigna(Info.POSLDIError, Nulo) Fin<BR>Si Temp.Reg3[1] = Nulo<BR>Entonces<BR>  Informacion(<T>Transacción Aprobada<T>)<BR>  EjecutarSQL(<T>spPOSLDITicket :tID, :nIDLog,:nEstacion<T>,Info.IDTexto,Temp.Reg3[6],EstacionTrabajo)<BR>  ReporteImpresora(<T>POSTicketLDI<T>)<BR>  ReporteImpresora(<T>POSTicketLDICopia<T>)<BR><BR><BR>Fin<BR>Si Temp.Reg3[1] = Nulo Entonces Forma.Accion(<T>CerrarSinError<T>) Fin

[Acciones.CerrarSinError]
Nombre=CerrarSinError
Boton=0
NombreDesplegar=&CerrarSinError
EnBarraAcciones=S
Activo=S
Visible=S



TipoAccion=Ventana
ClaveAccion=Cerrar





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
























































[Forma.ListaAcciones]
(Inicio)=Deslizar
Deslizar=CerrarSinError
CerrarSinError=Cerrar
Cerrar=(Fin)
