[Forma]
Clave=RepCxpAntiguedad
Nombre=Antigüedad de Saldos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=527
PosicionInicialArriba=230
PosicionInicialAltura=196
PosicionInicialAncho=340
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
AccionesTamanoBoton=25x5
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
BarraHerramientas=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=237

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.ProveedorD, SQL(<T>SELECT MIN(Proveedor) FROM Prov<T>))<BR>Asigna(Info.ProveedorA, SQL(<T>SELECT MAX(Proveedor) FROM Prov<T>))<BR>Asigna(Info.Desglosar, <T>Si<T>)<BR>Asigna(Info.Moneda, <T>(Todas)<T>)<BR>Asigna(Rep.Titulo, <T>Antigüedad de Saldos - Cuentas por Pagar<T>)
PosicionSec1=41
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

Expresion=Asigna(Info.CampoExtra,RepParam:RepParam.InfoEdoCtaRangos)<BR>ReportePantalla(<T>CxpAntiguedad<T>)
[Acciones.Imprimir.Imprimir]
Nombre=Imprimir
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CampoExtra,RepParam:RepParam.InfoEdoCtaRangos)<BR>ReporteImpresora(<T>CxpAntiguedad<T>)
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

[(Variables).Info.ProveedorD]
Carpeta=(Variables)
Clave=Info.ProveedorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ProveedorA]
Carpeta=(Variables)
Clave=Info.ProveedorA
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



[Rango]
Estilo=Ficha
Clave=Rango
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
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
ListaEnCaptura=RepParam.InfoEdoCtaRangos
CarpetaVisible=S

PermiteEditar=S
[Rango.RepParam.InfoEdoCtaRangos]
Carpeta=Rango
Clave=RepParam.InfoEdoCtaRangos
Editar=S
LineaNueva=S
ValidaNombre=S
Tamano=30
ColorFondo=Blanco

















[(Variables).ListaEnCaptura]
(Inicio)=Info.ProveedorD
Info.ProveedorD=Info.ProveedorA
Info.ProveedorA=Info.Desglosar
Info.Desglosar=Info.Moneda
Info.Moneda=Rep.Titulo
Rep.Titulo=(Fin)










[Acciones.RepPan.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Preliminar
Preliminar=(Fin)
















[Acciones.Imprimir.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Imprimir
Imprimir=(Fin)

[Forma.ListaCarpetas]
(Inicio)=(Variables)
(Variables)=Rango
Rango=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
