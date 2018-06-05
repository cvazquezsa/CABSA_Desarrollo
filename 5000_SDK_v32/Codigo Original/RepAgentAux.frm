[Forma]
Clave=RepAgentAux
Nombre=Rep.Titulo
Icono=18
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
AccionesTamanoBoton=25x5
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)
PosicionInicialIzquierda=483
PosicionInicialArriba=302
PosicionInicialAltura=211
PosicionInicialAncho=313
VentanaExclusiva=S
AccionesDivision=S
AccionesCentro=S
VentanaEscCerrar=S
BarraHerramientas=S
EsMovimiento=S
TituloAuto=S
MovModulo=Agent
MovEspecificos=Todos
PosicionInicialAlturaCliente=261

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.AgenteD, SQL(<T>SELECT MIN(Agente) FROM Agente<T>)) <BR>Asigna(Info.AgenteA, SQL(<T>SELECT MAX(Agente) FROM Agente<T>)) <BR>Asigna(Info.FechaD, PrimerDiaMes)<BR>Asigna(Info.FechaA, UltimoDiaMes )<BR>Asigna(Info.Moneda, Config.ContMoneda)<BR>Asigna(Rep.Aux, <T>Concentrado<T>)<BR>Asigna(Rep.MovEspecifico, <T>(Todos)<T>)<BR>Asigna(Rep.Titulo, <T>Auxiliares - Comisiones y Destajos<T>)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarAgenteoRegistros=S
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

[(Variables).Info.AgenteD]
Carpeta=(Variables)
Clave=Info.AgenteD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[(Variables).Info.AgenteA]
Carpeta=(Variables)
Clave=Info.AgenteA
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

[Acciones.RepPan.AgentAux]
Nombre=AgentAux
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
ListaParametros1=Info.AgenteD<BR>Info.AgenteA<BR>Info.FechaD<BR>Info.FechaA

Expresion=Si (Info.MonTodo <> <T>Todo<T>) Entonces<BR>  Asigna(Info.Moneda, Info.MonTodo)<BR>Fin<BR>Caso Rep.Aux<BR>  Es <T>Concentrado<T> Entonces ReportePantalla(<T>AgentAuxConcentrado<T>, Info.AgenteD, Info.AgenteA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado<T> Entonces ReportePantalla(<T>AgentAux<T>,   Info.AgenteD, Info.AgenteA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado por Dia<T> Entonces ReportePantalla(<T>AgentAuxDia<T>, Info.AgenteD, Info.AgenteA, Info.FechaD, Info.FechaA)<BR>Fin
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

[Acciones.Imprimir.AgentAux]
Nombre=AgentAux
Boton=0
TipoAccion=Expresion
ListaParametros1=Info.AgenteD<BR>Info.AgenteA<BR>Info.FechaD<BR>Info.FechaA
Activo=S
Visible=S

Expresion=Si (Info.MonTodo <> <T>Todo<T>) Entonces<BR>  Asigna(Info.Moneda, Info.MonTodo)<BR>Fin<BR>Caso Rep.Aux<BR>  Es <T>Concentrado<T> Entonces ReporteImpresora(<T>AgentAuxConcentrado<T>, Info.AgenteD, Info.AgenteA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado<T> Entonces ReporteImpresora(<T>AgentAux<T>,   Info.AgenteD, Info.AgenteA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado por Dia<T> Entonces ReporteImpresora(<T>AgentAuxDia<T>, Info.AgenteD, Info.AgenteA, Info.FechaD, Info.FechaA)<BR>Fin
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
Info.FechaA=Info.AgenteD
Info.AgenteD=Info.AgenteA
Info.AgenteA=Rep.MovEspecifico
Rep.MovEspecifico=Rep.Aux
Rep.Aux=Info.MonTodo
Info.MonTodo=Rep.Titulo
Rep.Titulo=(Fin)



[Acciones.RepPan.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=AgentAux
AgentAux=(Fin)




[Acciones.Imprimir.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=AgentAux
AgentAux=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
