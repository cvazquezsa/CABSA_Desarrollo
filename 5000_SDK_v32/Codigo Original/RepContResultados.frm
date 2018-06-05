[Forma]
Clave=RepContResultados
Nombre=Estado de Resultados
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=400
PosicionInicialArriba=98
PosicionInicialAltura=375
PosicionInicialAncho=594
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
AccionesTamanoBoton=25x5
AccionesCentro=S
ListaAcciones=(Lista)
AccionesDivision=S
BarraHerramientas=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=492

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.Ejercicio, EjercicioTrabajo)<BR>Asigna(Info.PeriodoD, 1);<BR>Asigna(Info.PeriodoA, PeriodoTrabajo)<BR>Asigna(Info.ConMovimientos, <T>Si<T>)<BR>Asigna(Info.AgruparCC, <T>No<T>)<BR>Asigna(Info.Desglosar, <T>No<T>)<BR>Asigna(Info.CentroCostos, <T>(Todos)<T>)<BR>Asigna(Info.CentroCostos2, <T>(Todos)<T>)<BR>Asigna(Info.CentroCostos3, <T>(Todos)<T>)<BR>Asigna(Info.AlCentroCostos, <T>(Todos)<T>)<BR>Asigna(Info.AlCentroCostos2, <T>(Todos)<T>)<BR>Asigna(Info.AlCentroCostos3, <T>(Todos)<T>)<BR>Asigna(Info.Proyecto, <T>(Todos)<T>)<BR>Asigna(Info.UEN, Nulo)<BR>Asigna(Rep.Sucursal, Nulo)  <BR>Asigna(Rep.Titulo, e(<T>Estado de Resultados<T>))<BR>Asigna(Info.ContMoneda, Config.ContMoneda)<BR>Asigna(Info.Grupo, Nulo)<BR>Asigna(Info.Rama, <T>CC<T>)<BR>Asigna(Info.Controladora, Nulo)
PosicionSec1=394
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
FichaEspacioEntreLineas=8
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
ColorFuente=Negro

[(Variables).Info.PeriodoA]
Carpeta=(Variables)
Clave=Info.PeriodoA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=12
Pegado=S
ColorFondo=Blanco
ColorFuente=Negro

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

[(Variables).Info.ConMovimientos]
Carpeta=(Variables)
Clave=Info.ConMovimientos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.PeriodoD]
Carpeta=(Variables)
Clave=Info.PeriodoD
Editar=S
ValidaNombre=S
3D=S
Tamano=12
LineaNueva=S
ColorFondo=Blanco
ColorFuente=Negro

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
ListaAccionesMultiples=Variables Asignar<BR>ContResultados
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

[Acciones.RepPan.ContResultados]
Nombre=ContResultados
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si(Info.AgruparCC=<T>No<T>, ReportePantalla(<T>ContResultados<T>), ReportePantalla(<T>ContResultadosCC<T>))
[Acciones.Imprimir.ContResultados]
Nombre=ContResultados
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si(Info.AgruparCC=<T>No<T>, ReporteImpresora(<T>ContResultados<T>), ReporteImpresora(<T>ContResultadosCC<T>))

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

[(Variables).Info.CentroCostos]
Carpeta=(Variables)
Clave=Info.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Rep.Titulo]
Carpeta=(Variables)
Clave=Rep.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[(Variables).Rep.Sucursal]
Carpeta=(Variables)
Clave=Rep.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Desglosar]
Carpeta=(Variables)
Clave=Info.Desglosar
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[(Variables).Info.AgruparCC]
Carpeta=(Variables)
Clave=Info.AgruparCC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.ContMoneda]
Carpeta=(Variables)
Clave=Info.ContMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Grupo]
Carpeta=(Variables)
Clave=Info.Grupo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N





[(Variables).Info.CentroCostos2]
Carpeta=(Variables)
Clave=Info.CentroCostos2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CentroCostos3]
Carpeta=(Variables)
Clave=Info.CentroCostos3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Proyecto]
Carpeta=(Variables)
Clave=Info.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.UEN]
Carpeta=(Variables)
Clave=Info.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro














[(Variables).Info.AlCentroCostos]
Carpeta=(Variables)
Clave=Info.AlCentroCostos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.AlCentroCostos2]
Carpeta=(Variables)
Clave=Info.AlCentroCostos2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.AlCentroCostos3]
Carpeta=(Variables)
Clave=Info.AlCentroCostos3
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[(Variables).ListaEnCaptura]
(Inicio)=Info.Ejercicio
Info.Ejercicio=Info.PeriodoD
Info.PeriodoD=Info.PeriodoA
Info.PeriodoA=Info.ConMovimientos
Info.ConMovimientos=Info.Desglosar
Info.Desglosar=Info.ContMoneda
Info.ContMoneda=Info.CentroCostos
Info.CentroCostos=Info.AlCentroCostos
Info.AlCentroCostos=Info.CentroCostos2
Info.CentroCostos2=Info.AlCentroCostos2
Info.AlCentroCostos2=Info.CentroCostos3
Info.CentroCostos3=Info.AlCentroCostos3
Info.AlCentroCostos3=Info.Proyecto
Info.Proyecto=Info.UEN
Info.UEN=Rep.Sucursal
Rep.Sucursal=Info.AgruparCC
Info.AgruparCC=Info.Grupo
Info.Grupo=Rep.Titulo
Rep.Titulo=(Fin)





[ReExpresar]
Estilo=Ficha
Clave=ReExpresar
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

[ReExpresar.Info.ReExpresar]
Carpeta=ReExpresar
Clave=Info.ReExpresar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ReExpresar.Info.ReExpresarTipoCambio]
Carpeta=ReExpresar
Clave=Info.ReExpresarTipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[ReExpresar.ListaEnCaptura]
(Inicio)=Info.ReExpresar
Info.ReExpresar=Info.ReExpresarTipoCambio
Info.ReExpresarTipoCambio=(Fin)









[Acciones.RepPan.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=ContResultados
ContResultados=(Fin)





[Lista.Columnas]
Moneda=144
TipoCambio=69





[Forma.ListaCarpetas]
(Inicio)=(Variables)
(Variables)=ReExpresar
ReExpresar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
