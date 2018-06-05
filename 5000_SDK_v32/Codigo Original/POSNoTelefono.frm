
[Forma]
Clave=POSNoTelefono
Icono=0
Modulos=(Todos)
Nombre=Número de Teléfono

ListaCarpetas=Variables
CarpetaPrincipal=Variables
PosicionInicialAlturaCliente=188
PosicionInicialAncho=741
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=397
PosicionInicialArriba=298
VentanaSinIconosMarco=S
VentanaExclusivaOpcion=0
VentanaColor=$00804000
ExpresionesAlMostrar=Asigna(Info.POSNoTelefono,Nulo)<BR>Asigna(Info.POSNoTelefonoConf,Nulo)
[Variables]
Estilo=Ficha
Clave=Variables
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Segoe UI, 20, Blanco, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=$00804000
FichaAlineacionDerecha=S
CampoColorLetras=$00C08000
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

ConFuenteEspecial=S
BarraBotones=S
ListaAccionesBB=(Lista)
BarraBtnFuente={Segoe UI, 10, Blanco, []}
BarraBtnFondo=$00804000
BarraBtnPosicion=Abajo
BarraBtnSize=80
BarraBtnSeparacion=4
BarraBtnSinBisel=S
BarraBtnBisel=0
BarraBtnPaginas=1
[Variables.Info.POSNoTelefono]
Carpeta=Variables
Clave=Info.POSNoTelefono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20


ColorFuente=$00C08000
ColorFondo=Blanco

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
Expresion=EjecutarSQL(<T>spPOSRecargaTemp :tID, :tServicio, :tEmpresa, :tUsuario, :nSucursal, :nImporte, :tTelefono, :nEstacion<T>,Info.IDTexto, Info.Servicio, Empresa, Usuario, Sucursal, Info.Importe,Info.POSNoTelefono, EstacionTrabajo)<BR>//Asigna(Temp.Reg2, SQL(<T>EXEC spPOSLDI :tServicio, :tID, :tMonedero,:tEmpresa, :tUsuario,:nSucursal,:nTarjReemp, :Importe, :nEnSilencio, :tNoTel<T>, Info.Servicio, Info.IDTexto, Nulo,Empresa, Usuario, sucursal, Nulo, Info.Importe, 0, Info.POSNoTelefono))<BR><BR>//Si Temp.Reg2[1] <> Nulo Entonces Error(Temp.Reg2[2]) Fin<BR>//Si Temp.Reg2[1] = Nulo Entonces Informacion(Temp.Reg2[3]) Fin<BR>//Si Temp.Reg2[1] = Nulo Entonces Asigna(Info.Servicio, Nulo) Fin<BR>//Si Temp.Reg2[1] = Nulo Entonces Forma.Accion(<T>Cerrar<T>) Fin<BR><BR>Asigna(Info.POSNoTelefono, Nulo)<BR>Asigna(Info.POSNoTelefonoConf, Nulo)
EjecucionCondicion=Info.POSNoTelefono = Info.POSNoTelefonoConf
EjecucionMensaje=<T>El teléfono confirmado no corresponde<T>

[Variables.Info.POSNoTelefonoConf]
Carpeta=Variables
Clave=Info.POSNoTelefonoConf
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

















ColorFuente=$00C08000
ColorFondo=Blanco
[Acciones.Recargar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S








[Acciones.Cerrar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Cerrar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spPOSInsertarLDIRecargaTemp :tID, :tServicio, :tEmpresa, :tUsuario, :nSucursal, :nImporte, :tTelefono<T>,Info.IDTexto,NULO , Empresa, Usuario, Sucursal, Info.Importe,NULO)
[Acciones.Cerrar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S




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














[Acciones.Regresar]
Nombre=Regresar
Boton=0
NombreEnBoton=S
TeclaFuncion=ESC
NombreDesplegar=Cerrar
Activo=S
Visible=S
BarraBtnAncho=72
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

Multiple=S
ListaAccionesMultiples=(Lista)


[Acciones.Regresar.Variables]
Nombre=Variables
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Regresar.Insertar]
Nombre=Insertar
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>spPOSInsertarLDIRecargaTemp :tID, :tServicio, :tEmpresa, :tUsuario, :nSucursal, :nImporte, :tTelefono<T>,Info.IDTexto,NULO , Empresa, Usuario, Sucursal, Info.Importe,NULO)
Activo=S
Visible=S

[Acciones.Regresar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S




[Acciones.Regresar.ListaAccionesMultiples]
(Inicio)=Variables
Variables=Insertar
Insertar=Cerrar
Cerrar=(Fin)

[Acciones.Espacio]
Nombre=Espacio
Boton=0
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=555
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1




[Acciones.Recarga]
Nombre=Recarga
Boton=0
NombreEnBoton=S
TeclaFuncion=F12
NombreDesplegar=Ejecutar Recarga
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=72
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F12.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado



















ListaAccionesMultiples=(Lista)
[Acciones.Previo]
Nombre=Previo
Boton=0
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=5
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1







[Acciones.Recarga.Asigna]
Nombre=Asigna
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Recarga.Recarga]
Nombre=Recarga
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spPOSRecargaTemp :tID, :tServicio, :tEmpresa, :tUsuario, :nSucursal, :nImporte, :tTelefono, :nEstacion<T>,Info.IDTexto, Info.Servicio, Empresa, Usuario, Sucursal, Info.Importe,Info.POSNoTelefono, EstacionTrabajo)<BR>//Asigna(Temp.Reg2, SQL(<T>EXEC spPOSLDI :tServicio, :tID, :tMonedero,:tEmpresa, :tUsuario,:nSucursal,:nTarjReemp, :Importe, :nEnSilencio, :tNoTel<T>, Info.Servicio, Info.IDTexto, Nulo,Empresa, Usuario, sucursal, Nulo, Info.Importe, 0, Info.POSNoTelefono))<BR><BR>//Si Temp.Reg2[1] <> Nulo Entonces Error(Temp.Reg2[2]) Fin<BR>//Si Temp.Reg2[1] = Nulo Entonces Informacion(Temp.Reg2[3]) Fin<BR>//Si Temp.Reg2[1] = Nulo Entonces Asigna(Info.Servicio, Nulo) Fin<BR>//Si Temp.Reg2[1] = Nulo Entonces Forma.Accion(<T>Cerrar<T>) Fin<BR><BR>Asigna(Info.POSNoTelefono, Nulo)<BR>Asigna(Info.POSNoTelefonoConf, Nulo)
ConCondicion=S
EjecucionCondicion=Info.POSNoTelefono = Info.POSNoTelefonoConf
EjecucionMensaje=<T>El teléfono confirmado no corresponde<T>
EjecucionConError=S

[Acciones.Recarga.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Recarga.ListaAccionesMultiples]
(Inicio)=Asigna
Asigna=Recarga
Recarga=Cerrar
Cerrar=(Fin)

[Variables.ListaEnCaptura]
(Inicio)=Info.POSNoTelefono
Info.POSNoTelefono=Info.POSNoTelefonoConf
Info.POSNoTelefonoConf=(Fin)

[Variables.ListaAccionesBB]
(Inicio)=Previo
Previo=Regresar
Regresar=Espacio
Espacio=Recarga
Recarga=(Fin)

[Forma.ListaAcciones]
(Inicio)=Recargar
Recargar=Cerrar
Cerrar=(Fin)
