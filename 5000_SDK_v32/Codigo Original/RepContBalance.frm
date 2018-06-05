[Forma]
Clave=RepContBalance
Nombre=Estado de Posición Financiera
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=359
PosicionInicialArriba=115
PosicionInicialAltura=292
PosicionInicialAncho=676
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
AccionesTamanoBoton=25x5
AccionesCentro=S
ListaAcciones=(Lista)
AccionesDivision=S
VentanaEscCerrar=S
BarraHerramientas=S
PosicionInicialAlturaCliente=459

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.Ejercicio, EjercicioTrabajo)<BR>Asigna(Info.PeriodoA, PeriodoTrabajo)<BR>Asigna(Info.ConMovimientos, <T>Si<T>)<BR>Asigna(Info.TipoReporte, <T>No<T>)<BR>Asigna(Info.CentroCostos, <T>(Todos)<T>)<BR>Asigna(Info.CentroCostos2, <T>(Todos)<T>)<BR>Asigna(Info.CentroCostos3, <T>(Todos)<T>)<BR>Asigna(Info.AlCentroCostos, <T>(Todos)<T>)<BR>Asigna(Info.AlCentroCostos2, <T>(Todos)<T>)<BR>Asigna(Info.AlCentroCostos3, <T>(Todos)<T>)<BR>Asigna(Info.Proyecto, <T>(Todos)<T>)<BR>Asigna(Info.UEN, Nulo)<BR>Asigna(Rep.Sucursal, Nulo)<BR>Asigna(Info.ContMoneda, Config.ContMoneda)<BR>Asigna(Info.Controladora, Nulo)<BR>Asigna(Rep.Titulo, e(<T>Estado de Posición Finaciera<T>))
PosicionSec1=316
[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
FichaEspacioEntreLineas=5
FichaEspacioNombres=75
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaColorFondo=Plata
FichaAlineacion=Izquierda
ListaEnCaptura=(Lista)
PermiteEditar=S

[(Variables).Info.Ejercicio]
Carpeta=(Variables)
Clave=Info.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[(Variables).Info.PeriodoA]
Carpeta=(Variables)
Clave=Info.PeriodoA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreDesplegar=&Preliminar
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
Multiple=S
EnBarraAcciones=S
TipoAccion=Reportes Impresora
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S

[Acciones.RepPan.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.RepPan.ContBalance]
Nombre=ContBalance
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si(Info.TipoReporte=<T>Si<T>, ReportePantalla(<T>ContBalanceReporte<T>), ReportePantalla(<T>ContBalance<T>))
[Acciones.Imprimir.ContBalance]
Nombre=ContBalance
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si(Info.TipoReporte=<T>Si<T>, ReporteImpresora(<T>ContBalanceReporte<T>), ReporteImpresora(<T>ContBalance<T>))
[(Variables).Info.ConMovimientos]
Carpeta=(Variables)
Clave=Info.ConMovimientos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[(Variables).Info.TipoReporte]
Carpeta=(Variables)
Clave=Info.TipoReporte
Editar=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco
Pegado=S

[(Variables).Rep.Titulo]
Carpeta=(Variables)
Clave=Rep.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=76
ColorFondo=Blanco

[(Variables).Info.CentroCostos]
Carpeta=(Variables)
Clave=Info.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[(Variables).Rep.Sucursal]
Carpeta=(Variables)
Clave=Rep.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[(Variables).Info.ContMoneda]
Carpeta=(Variables)
Clave=Info.ContMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[(Variables).Info.CentroCostos2]
Carpeta=(Variables)
Clave=Info.CentroCostos2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[(Variables).Info.CentroCostos3]
Carpeta=(Variables)
Clave=Info.CentroCostos3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco



















[(Variables).Info.Proyecto]
Carpeta=(Variables)
Clave=Info.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[(Variables).Info.UEN]
Carpeta=(Variables)
Clave=Info.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco





[(Variables).Info.AlCentroCostos]
Carpeta=(Variables)
Clave=Info.AlCentroCostos
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[(Variables).Info.AlCentroCostos2]
Carpeta=(Variables)
Clave=Info.AlCentroCostos2
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[(Variables).Info.AlCentroCostos3]
Carpeta=(Variables)
Clave=Info.AlCentroCostos3
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco












[(Variables).ListaEnCaptura]
(Inicio)=Info.Ejercicio
Info.Ejercicio=Info.PeriodoA
Info.PeriodoA=Info.ConMovimientos
Info.ConMovimientos=Info.TipoReporte
Info.TipoReporte=Info.CentroCostos
Info.CentroCostos=Info.AlCentroCostos
Info.AlCentroCostos=Info.CentroCostos2
Info.CentroCostos2=Info.AlCentroCostos2
Info.AlCentroCostos2=Info.CentroCostos3
Info.CentroCostos3=Info.AlCentroCostos3
Info.AlCentroCostos3=Info.Proyecto
Info.Proyecto=Info.UEN
Info.UEN=Rep.Sucursal
Rep.Sucursal=Info.ContMoneda
Info.ContMoneda=Rep.Titulo
Rep.Titulo=(Fin)







[ReExpresion.Info.ReExpresar]
Carpeta=ReExpresion
Clave=Info.ReExpresar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ReExpresion.Info.ReExpresarTipoCambio]
Carpeta=ReExpresion
Clave=Info.ReExpresarTipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco









[ReExpresion]
Estilo=Ficha
Clave=ReExpresion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S







[ReExpresion.ListaEnCaptura]
(Inicio)=Info.ReExpresar
Info.ReExpresar=Info.ReExpresarTipoCambio
Info.ReExpresarTipoCambio=(Fin)



[Lista.Columnas]
Moneda=144
TipoCambio=69














[Acciones.RepPan.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=ContBalance
ContBalance=(Fin)





[Acciones.Imprimir.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=ContBalance
ContBalance=(Fin)













































[Forma.ListaCarpetas]
(Inicio)=(Variables)
(Variables)=ReExpresion
ReExpresion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
