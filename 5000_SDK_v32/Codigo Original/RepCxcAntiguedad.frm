[Forma]
Clave=RepCxcAntiguedad
Nombre=Antigüedad de Saldos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=522
PosicionInicialArriba=233
PosicionInicialAltura=196
PosicionInicialAncho=350
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
AccionesTamanoBoton=25x5
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
BarraHerramientas=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=231

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
PosicionSec1=43
PosicionCol1=269
PosicionSec2=92
ExpresionesAlMostrar=Asigna(Info.ClienteD, SQL(<T>SELECT MIN(Cliente) FROM Cte<T>))<BR>Asigna(Info.ClienteA, SQL(<T>SELECT MAX(Cliente) FROM Cte<T>))<BR>Asigna(Info.Desglosar, <T>Si<T>)<BR>Asigna(Info.Moneda, <T>(Todas)<T>)<BR>Asigna(Rep.Titulo, <T>Antigüedad de Saldos - Cuentas por Cobrar<T>)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreDesplegar=&Preliminar
Multiple=S
EnBarraAcciones=S
Activo=S
Visible=S
ListaAccionesMultiples=(Lista)
NombreEnBoton=S
EnBarraHerramientas=S

GuardarAntes=S
[Acciones.RepPan.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

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
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S

GuardarAntes=S
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

GuardarAntes=S
[Acciones.RepPan.Preliminar]
Nombre=Preliminar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CampoExtra,RepParam:RepParam.InfoEdoCtaRangos)<BR>ReportePantalla(<T>CxcAntiguedad<T>)
[Acciones.Imprimir.Imprimir]
Nombre=Imprimir
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CampoExtra,RepParam:RepParam.InfoEdoCtaRangos)<BR>ReporteImpresora(<T>CxcAntiguedad<T>)
[(Variables).Rep.Titulo]
Carpeta=(Variables)
Clave=Rep.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=41
ColorFondo=Blanco

[(Variables).Info.ClienteD]
Carpeta=(Variables)
Clave=Info.ClienteD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ClienteA]
Carpeta=(Variables)
Clave=Info.ClienteA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Desglosar]
Carpeta=(Variables)
Clave=Info.Desglosar
Editar=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[(Variables).Info.Moneda]
Carpeta=(Variables)
Clave=Info.Moneda
Editar=S
3D=S
Tamano=11
ColorFondo=Blanco
ValidaNombre=S




[Lista.Columnas]
Cliente=117
Nombre=293
RFC=107






[Rango]
Estilo=Ficha
Clave=Rango
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=RepParam.InfoEdoCtaRangos
CarpetaVisible=S

FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
[Rango.RepParam.InfoEdoCtaRangos]
Carpeta=Rango
Clave=RepParam.InfoEdoCtaRangos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco



EspacioPrevio=N
Tamano=30
[Rango.Columnas]
InfoEdoCtaRangos=304












[(Variables).ListaEnCaptura]
(Inicio)=Info.ClienteD
Info.ClienteD=Info.ClienteA
Info.ClienteA=Info.Desglosar
Info.Desglosar=Info.Moneda
Info.Moneda=Rep.Titulo
Rep.Titulo=(Fin)













[Acciones.Imprimir.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Imprimir
Imprimir=(Fin)



[Acciones.RepPan.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Preliminar
Preliminar=(Fin)









[Forma.ListaCarpetas]
(Inicio)=Rango
Rango=(Variables)
(Variables)=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
