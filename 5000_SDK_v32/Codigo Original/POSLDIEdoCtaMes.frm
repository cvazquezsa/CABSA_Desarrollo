
[Forma]
Clave=POSLDIEdoCtaMes
Icono=0
Modulos=(Todos)
Nombre=Estado Cuenta LDI por Mes

ListaCarpetas=(Variables)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=627
PosicionInicialArriba=238
PosicionInicialAlturaCliente=202
PosicionInicialAncho=207
VentanaExclusiva=S
VentanaExclusivaOpcion=0

VentanaColor=Plata
ExpresionesAlMostrar=Asigna(Info.Ano, Año(  Hoy  ) )<BR>Asigna(Info.Periodo, Mes( Hoy ) )
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

ConFuenteEspecial=S
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
[(Variables).Info.Ano]
Carpeta=(Variables)
Clave=Info.Ano
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Periodo]
Carpeta=(Variables)
Clave=Info.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)

Activo=S


[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S






[Acciones.Solicitar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion



Expresion=EjecutarSQL(<T>spPOSLDI :tServicio, :tID, :tMonedero, :tEmpresa, :tUsuario, :nSucursal, null,null,1,null,null,null,:tModulo, @Mes = :tMes, @Ano = :tAno<T>,<T>EDOCTAMES<T>,Info.IDTexto,Info.POSMonedero,Empresa,Usuario,Sucursal,<T>POS<T>,Info.Periodo,Info.Ano))<BR><BR>Asigna(Info.Tipo,<T>MES<T>)<BR>ReportePantalla(<T>POSLDIEdoCta<T>)




[Acciones.Solicitar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar


[Acciones.Separador]
Nombre=Separador
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=5
BarraBtnAlto=75
BarraBtnFondo=Plata
BarraBtnPagina=1



[Acciones.Cierra]
Nombre=Cierra
Boton=0
NombreDesplegar=<T>Cerrar<T>
GuardarAntes=S
TipoAccion=Ventana
ClaveAccion=Cerrar
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




TeclaFuncion=ESC






[Acciones.Solicita.Variable Asigna]
Nombre=Variable Asigna
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Solicita.Expresiones]
Nombre=Expresiones
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spPOSLDI :tServicio, :tID, :tMonedero, :tEmpresa, :tUsuario, :nSucursal, null,null,1,null,null,null,:tModulo, @Mes = :tMes, @Ano = :tAno<T>,<T>EDOCTAMES<T>,Info.IDTexto,Info.POSMonedero,Empresa,Usuario,Sucursal,<T>POS<T>,Info.Periodo,Info.Ano))<BR><BR>Asigna(Info.Tipo,<T>MES<T>)<BR>ReportePantalla(<T>POSLDIEdoCta<T>)

[Acciones.Solicita]
Nombre=Solicita
Boton=0
NombreDesplegar=<T>Aceptar<T>
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
edBotonSrc=Seleccionar.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado



[Acciones.Solicitar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=Aceptar
Aceptar=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Solicitar
Solicitar=(Fin)










[Acciones.Solicita.ListaAccionesMultiples]
(Inicio)=Variable Asigna
Variable Asigna=Expresiones
Expresiones=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.Ano
Info.Ano=Info.Periodo
Info.Periodo=(Fin)

[(Variables).ListaAccionesBB]
(Inicio)=Separador
Separador=Cierra
Cierra=Solicita
Solicita=(Fin)
