
[Forma]
Clave=POSLDIEdoCtaPeriodo
Modulos=(Todos)
Nombre=Estado Cuenta LDI por Periodo

ListaCarpetas=(Variables)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=854
PosicionInicialArriba=410
PosicionInicialAlturaCliente=200
PosicionInicialAncho=274
Icono=0
VentanaExclusiva=S
VentanaExclusivaOpcion=0

VentanaColor=$00804000
ExpresionesAlMostrar=Asigna(Info.FechaD,Nulo )<BR>Asigna(Info.FechaA,Hoy)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Segoe UI, 10, Blanco, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=$00804000
ListaEnCaptura=(Lista)
PermiteEditar=S



BarraBotones=S
ListaAccionesBB=(Lista)
BarraBtnFuente={Segoe UI, 10, Blanco, []}
BarraBtnFondo=$00804000
BarraBtnPosicion=Abajo
BarraBtnSize=80
BarraBtnSeparacion=2
BarraBtnSinBisel=S
BarraBtnBisel=0
BarraBtnPaginas=1
ConFuenteEspecial=S
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

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Temp.Reg,SQL(<T>spPOSLDI :tServicio, :tID, :tMonedero, :tEmpresa, :tUsuario, :nSucursal, null,null,0,null,null,null,:tModulo, @Mes = :tMes, @Ano = :tAno<T>,<T>EDOCTAMES<T>,Info.IDTexto,Info.POSMonedero,Empresa,Usuario,Sucursal,<T>POS<T>,Info.Periodo,Info.Ano)))
Activo=S
Visible=S

[Acciones.Solicitar]
Nombre=Solicitar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=Cerrar
GuardarAntes=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S






[Acciones.Solicitar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>spPOSLDI :tServicio, :tID, :tMonedero, :tEmpresa, :tUsuario, :nSucursal, null,null,1,null,null,null,:tModulo, @FechaD = :tFechaD, @FechaA = :tFechaA<T>,<T>EDOCTAMES<T>,Info.IDTexto,Info.POSMonedero,Empresa,Usuario,Sucursal,<T>POS<T>, FechaFormatoServidor(Info.FechaD) ,  FechaFormatoServidor( Info.FechaA )  ))<BR><BR>Asigna(Info.Tipo,<T>PERIODO<T>)<BR>ReportePantalla(<T>POSLDIEdoCta<T>)


[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco








[Acciones.Solicitar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar




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
edBotonSrc=Esc.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





TipoAccion=Ventana
ClaveAccion=Cerrar
GuardarAntes=S
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










[Acciones.Solicita]
Nombre=Solicita
Boton=0
NombreDesplegar=<T>Aceptar<T>
GuardarAntes=S
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
edBotonSrc=Seleccionar.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

ListaAccionesMultiples=(Lista)
[Acciones.Solicita.Asigna]
Nombre=Asigna
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Solicita.Espresion]
Nombre=Espresion
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>spPOSLDI :tServicio, :tID, :tMonedero, :tEmpresa, :tUsuario, :nSucursal, null,null,1,null,null,null,:tModulo, @FechaD = :tFechaD, @FechaA = :tFechaA<T>,<T>EDOCTAMES<T>,Info.IDTexto,Info.POSMonedero,Empresa,Usuario,Sucursal,<T>POS<T>, FechaFormatoServidor(Info.FechaD) ,  FechaFormatoServidor( Info.FechaA )  ))<BR><BR>Asigna(Info.Tipo,<T>PERIODO<T>)<BR>ReportePantalla(<T>POSLDIEdoCta<T>)
Activo=S
Visible=S

[Acciones.Solicita.Acepta]
Nombre=Acepta
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Solicita.ListaAccionesMultiples]
(Inicio)=Asigna
Asigna=Espresion
Espresion=Acepta
Acepta=(Fin)



[Acciones.Solicitar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=Aceptar
Aceptar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Solicitar
Solicitar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=(Fin)

[(Variables).ListaAccionesBB]
(Inicio)=Separador1
Separador1=Cierra
Cierra=Solicita
Solicita=(Fin)
