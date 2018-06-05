
[Forma]
Clave=POSL
Icono=0
Modulos=(Todos)
Nombre=Edición de Encabezado

ListaCarpetas=Datos Generales
CarpetaPrincipal=Datos Generales
PosicionInicialAlturaCliente=447
PosicionInicialAncho=628
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=400
PosicionInicialArriba=141




















VentanaSinIconosMarco=S
VentanaEscCerrar=S
ExpresionesAlActivar=Asigna(Info.Cliente, SQL(<T>SELECT Cliente FROM POSL WHERE Id = :tID<T>, Info.IDTexto))
[Lista.Columnas]
Cliente=117
Nombre=293
RFC=107






0=105
1=247
2=-2
3=-2

[Campos.ListaEnCaptura]
(Inicio)=POSL.Mov
POSL.Mov=POSL.Proyecto
POSL.Proyecto=POSL.Moneda
POSL.Moneda=POSL.TipoCambio
POSL.TipoCambio=POSL.FechaEmision
POSL.FechaEmision=POSL.Cliente
POSL.Cliente=Cte.Nombre
Cte.Nombre=POSL.EnviarA
POSL.EnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=POSL.Concepto
POSL.Concepto=POSL.Referencia
POSL.Referencia=POSL.Observaciones
POSL.Observaciones=POSL.Agente
POSL.Agente=POSL.Cajero
POSL.Cajero=POSL.Almacen
POSL.Almacen=POSL.UEN
POSL.UEN=POSL.FormaEnvio
POSL.FormaEnvio=POSL.Condicion
POSL.Condicion=POSL.Vencimiento
POSL.Vencimiento=POSL.CtaDinero
POSL.CtaDinero=POSL.Descuento
POSL.Descuento=POSL.DescuentoGlobal
POSL.DescuentoGlobal=POSL.Importe
POSL.Importe=POSL.Impuestos
POSL.Impuestos=POSL.Causa
POSL.Causa=POSL.Atencion
POSL.Atencion=POSL.AtencionTelefono
POSL.AtencionTelefono=POSL.ListaPreciosEsp
POSL.ListaPreciosEsp=POSL.ZonaImpuesto
POSL.ZonaImpuesto=POSL.Sucursal
POSL.Sucursal=POSL.FormaPago
POSL.FormaPago=(Fin)

[Datos Generales]
Estilo=Ficha
PestanaNombre=Datos Generales
Clave=Datos Generales
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSL
Fuente={Segoe UI, 8, Blanco, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=$00804000
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S



Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
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
BarraBtnPaginas=5
FiltroGeneral=POSL.ID = <T>{Info.IDTexto}<T>
[Datos Generales.POSL.Moneda]
Carpeta=Datos Generales
Clave=POSL.Moneda
Editar=N
3D=S
Tamano=10
ColorFondo=Blanco

ValidaNombre=S
LineaNueva=S
[Datos Generales.POSL.TipoCambio]
Carpeta=Datos Generales
Clave=POSL.TipoCambio
Editar=N
3D=S
Pegado=S
Tamano=8
ColorFondo=Blanco

[Datos Generales.POSL.FechaEmision]
Carpeta=Datos Generales
Clave=POSL.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco


[Datos Generales.Cte.Nombre]
Carpeta=Datos Generales
Clave=Cte.Nombre
3D=S
Tamano=48
ColorFondo=Plata

[Datos Generales.POSL.EnviarA]
Carpeta=Datos Generales
Clave=POSL.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco

EspacioPrevio=N
[Datos Generales.CteEnviarA.Nombre]
Carpeta=Datos Generales
Clave=CteEnviarA.Nombre
3D=S
Tamano=48
ColorFondo=Plata

[Datos Generales.POSL.Concepto]
Carpeta=Datos Generales
Clave=POSL.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Datos Generales.POSL.Referencia]
Carpeta=Datos Generales
Clave=POSL.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Datos Generales.POSL.Observaciones]
Carpeta=Datos Generales
Clave=POSL.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Datos Generales.POSL.Agente]
Carpeta=Datos Generales
Clave=POSL.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=14
ColorFondo=Blanco


[Datos Generales.POSL.Almacen]
Carpeta=Datos Generales
Clave=POSL.Almacen
Editar=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco



LineaNueva=S
EspacioPrevio=S
[Datos Generales.POSL.Vencimiento]
Carpeta=Datos Generales
Clave=POSL.Vencimiento
Editar=N
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco


Pegado=S
Tamano=15




[Forma.ListaCarpetas]
(Inicio)=Datos Generales
Datos Generales=Condiciones
Condiciones=(Fin)










[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S

NombreEnBoton=S
ClaveAccion=Aceptar
Antes=S
Multiple=S
ListaAccionesMultiples=(Lista)
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=SQL(<T>xpPOSLGuardar :tEmpresa, :nSucursal, :tID, :tMov, :tCte<T>, Empresa, Sucursal, Info.IDTexto, POSL:POSL.Mov, POSL:POSL.Cliente) = 0
EjecucionMensaje=<T>El Cliente debe de tener Condición de Crédito<T>
AntesExpresiones=EjecutarSQL( <T>spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto )<BR><BR>EjecutarSQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente)
[Acciones.Guardar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S




[Datos Generales.POSL.Cliente]
Carpeta=Datos Generales
Clave=POSL.Cliente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=22
ColorFondo=Blanco






[Datos Generales.POSL.Descuento]
Carpeta=Datos Generales
Clave=POSL.Descuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco




[Acciones.Guardar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spPOSArtPrecioRecalcular :tID, :nEstacion<T>,POSL:POSL.ID,EstacionTrabajo)<BR>Asigna(Info.Cliente,POSL:POSL.Cliente)
[Acciones.Guardar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S














[Acciones.CteInfo]
Nombre=CteInfo
Boton=34
NombreDesplegar=Información del Cliente
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=POSCteInfo
Activo=S
Antes=S
Visible=S









EspacioPrevio=S
AntesExpresiones=Asigna(Info.Cliente,POSL:POSL.Cliente)






[Datos Generales.POSL.ListaPreciosEsp]
Carpeta=Datos Generales
Clave=POSL.ListaPreciosEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco





























[Datos Generales.POSL.Mov]
Carpeta=Datos Generales
Clave=POSL.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Datos Generales.Columnas]
0=-2
1=-2
2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
10=-2
11=-2
12=-2
13=-2
14=-2
15=-2


[Acciones.Guardar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)


















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





[Acciones.Acepta]
Nombre=Acepta
Boton=0
NombreDesplegar=<T>Aceptar<T>
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

GuardarAntes=S
Multiple=S
ListaAccionesMultiples=(Lista)
ConCondicion=S
EjecucionConError=S
Antes=S



TeclaFuncion=F1
EjecucionCondicion=SQL(<T>xpPOSLGuardar :tEmpresa, :nSucursal, :tID, :tMov, :tCte<T>, Empresa, Sucursal, Info.IDTexto, POSL:POSL.Mov, POSL:POSL.Cliente) = 0
EjecucionMensaje=<T>El Cliente debe de tener Condición de Crédito<T>
AntesExpresiones=EjecutarSQL( <T>spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto )<BR><BR>EjecutarSQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente)
[Acciones.Acepta.Expresa]
Nombre=Expresa
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>spPOSArtPrecioRecalcular :tID, :nEstacion<T>,POSL:POSL.ID,EstacionTrabajo)<BR>Asigna(Info.Cliente,POSL:POSL.Cliente)
Activo=S
Visible=S

[Acciones.Acepta.Acepta]
Nombre=Acepta
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





[Acciones.Acepta.ListaAccionesMultiples]
(Inicio)=Expresa
Expresa=Acepta
Acepta=(Fin)




[Acciones.CteInforma]
Nombre=CteInforma
Boton=0
NombreDesplegar=<T>Información del Cliente<T>
GuardarAntes=S
TipoAccion=Formas
ClaveAccion=POSCteInfo
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
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






AntesExpresiones=Asigna(Info.Cliente,POSL:POSL.Cliente)
edBotonSrc=Info.png
[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=CteInfo
CteInfo=(Fin)



[Datos Generales.ListaEnCaptura]
(Inicio)=POSL.Mov
POSL.Mov=POSL.Moneda
POSL.Moneda=POSL.TipoCambio
POSL.TipoCambio=POSL.FechaEmision
POSL.FechaEmision=POSL.Cliente
POSL.Cliente=Cte.Nombre
Cte.Nombre=POSL.EnviarA
POSL.EnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=POSL.ListaPreciosEsp
POSL.ListaPreciosEsp=POSL.Concepto
POSL.Concepto=POSL.Referencia
POSL.Referencia=POSL.Observaciones
POSL.Observaciones=POSL.Agente
POSL.Agente=POSL.Almacen
POSL.Almacen=POSL.Vencimiento
POSL.Vencimiento=POSL.Descuento
POSL.Descuento=(Fin)

[Datos Generales.ListaAccionesBB]
(Inicio)=Separador
Separador=Acepta
Acepta=CteInforma
CteInforma=(Fin)
