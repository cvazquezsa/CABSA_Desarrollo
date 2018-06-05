[Forma]
Clave=RepCxcAux
Nombre=Rep.Titulo
Icono=18
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
AccionesTamanoBoton=25x5
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)
PosicionInicialIzquierda=484
PosicionInicialArriba=261
PosicionInicialAltura=267
PosicionInicialAncho=311
VentanaExclusiva=S
AccionesDivision=S
AccionesCentro=S
VentanaEscCerrar=S
BarraHerramientas=S
EsMovimiento=S
TituloAuto=S
MovModulo=CXC
MovEspecificos=Todos
PosicionInicialAlturaCliente=344

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.ClienteD, SQL(<T>SELECT MIN(Cliente) FROM Cte<T>)) <BR>Asigna(Info.ClienteA, SQL(<T>SELECT MAX(Cliente) FROM Cte<T>)) <BR>Asigna(Info.FechaD, PrimerDiaMes)<BR>Asigna(Info.FechaA, UltimoDiaMes )<BR>Asigna(Info.Moneda, Config.ContMoneda)<BR>Asigna(Rep.Aux, <T>Concentrado<T>)<BR>Asigna(Rep.MovEspecifico, <T>(Todos)<T>)<BR>Asigna(Info.CteCat, <T>(Todos)<T>)<BR>Asigna(Info.CteFam, <T>(Todos)<T>)<BR>Asigna(Info.CteGrupo, <T>(Todos)<T>)<BR>Asigna(Rep.Titulo, <T>Auxiliares - Cuentas por Cobrar<T>)<BR>Asigna(Info.CteTipo, <T>(Todos)<T>)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarCxceoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=81
FichaEspacioNombresAuto=S
FichaColorFondo=Plata
ListaEnCaptura=(Lista)
PermiteEditar=S
FichaNombres=Arriba
FichaAlineacion=Izquierda

[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
ValidaNombre=S
3D=S
Tamano=20
LineaNueva=S
EspacioPrevio=N
ColorFondo=Blanco

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
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
EspacioPrevio=S

[(Variables).Info.ClienteA]
Carpeta=(Variables)
Clave=Info.ClienteA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.RepPan.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.RepPan.CxcAux]
Nombre=CxcAux
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
ListaParametros1=Info.ClienteD<BR>Info.ClienteA<BR>Info.FechaD<BR>Info.FechaA

Expresion=Si (Info.MonTodo <> <T>Todo<T>) Entonces<BR>  Asigna(Info.Moneda, Info.MonTodo)<BR>Fin<BR>Caso Rep.Aux<BR>  Es <T>Concentrado<T> Entonces ReportePantalla(<T>CxcAuxConcentrado<T>, Info.ClienteD, Info.ClienteA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado<T> Entonces ReportePantalla(<T>CxcAux<T>,   Info.ClienteD, Info.ClienteA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado por Dia<T> Entonces ReportePantalla(<T>CxcAuxDia<T>, Info.ClienteD, Info.ClienteA, Info.FechaD, Info.FechaA)<BR>Fin
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

[Acciones.Imprimir.CxcAux]
Nombre=CxcAux
Boton=0
TipoAccion=Expresion
ListaParametros1=Info.ClienteD<BR>Info.ClienteA<BR>Info.FechaD<BR>Info.FechaA
Activo=S
Visible=S

Expresion=Si (Info.MonTodo <> <T>Todo<T>) Entonces<BR>  Asigna(Info.Moneda, Info.MonTodo)<BR>Fin<BR>Caso Rep.Aux<BR>  Es <T>Concentrado<T> Entonces ReporteImpresora(<T>CxcAuxConcentrado<T>, Info.ClienteD, Info.ClienteA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado<T> Entonces ReporteImpresora(<T>CxcAux<T>,   Info.ClienteD, Info.ClienteA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado por Dia<T> Entonces ReporteImpresora(<T>CxcAuxDia<T>, Info.ClienteD, Info.ClienteA, Info.FechaD, Info.FechaA)<BR>Fin
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

[(Variables).Rep.Titulo]
Carpeta=(Variables)
Clave=Rep.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
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


[(Variables).Rep.Aux]
Carpeta=(Variables)
Clave=Rep.Aux
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=N

[(Variables).Rep.MovEspecifico]
Carpeta=(Variables)
Clave=Rep.MovEspecifico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[(Variables).Info.CteCat]
Carpeta=(Variables)
Clave=Info.CteCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[(Variables).Info.CteFam]
Carpeta=(Variables)
Clave=Info.CteFam
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.CteGrupo]
Carpeta=(Variables)
Clave=Info.CteGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.CteTipo]
Carpeta=(Variables)
Clave=Info.CteTipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[(Variables).Info.MonTodo]
Carpeta=(Variables)
Clave=Info.MonTodo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Lista.Columnas]
Moneda=64
Tipo de Cambio=77

[(Variables).ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.ClienteD
Info.ClienteD=Info.ClienteA
Info.ClienteA=Info.CteCat
Info.CteCat=Info.CteFam
Info.CteFam=Info.CteGrupo
Info.CteGrupo=Info.CteTipo
Info.CteTipo=Rep.MovEspecifico
Rep.MovEspecifico=Rep.Aux
Rep.Aux=Info.MonTodo
Info.MonTodo=Rep.Titulo
Rep.Titulo=(Fin)


[Acciones.Imprimir.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=CxcAux
CxcAux=(Fin)


[Acciones.RepPan.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=CxcAux
CxcAux=(Fin)













[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
