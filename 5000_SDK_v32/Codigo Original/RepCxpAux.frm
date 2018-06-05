[Forma]
Clave=RepCxpAux
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
PosicionInicialArriba=281
PosicionInicialAltura=239
PosicionInicialAncho=314
VentanaExclusiva=S
AccionesDivision=S
AccionesCentro=S
VentanaEscCerrar=S
BarraHerramientas=S
EsMovimiento=S
TituloAuto=S
MovModulo=CXP
MovEspecificos=Todos
PosicionInicialAlturaCliente=304

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.ProveedorD, SQL(<T>SELECT MIN(Proveedor) FROM Prov<T>)) <BR>Asigna(Info.ProveedorA, SQL(<T>SELECT MAX(Proveedor) FROM Prov<T>)) <BR>Asigna(Info.FechaD, PrimerDiaMes)<BR>Asigna(Info.FechaA, UltimoDiaMes )<BR>Asigna(Info.Moneda, Config.ContMoneda)<BR>Asigna(Rep.Aux, <T>Concentrado<T>)<BR>Asigna(Rep.MovEspecifico, <T>(Todos)<T>)<BR>Asigna(Info.ProvCat, <T>(Todos)<T>)<BR>Asigna(Info.ProvFam, <T>(Todos)<T>)<BR>Asigna(Rep.Titulo, <T>Auxiliares - Cuentas por Pagar<T>)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarCxpeoRegistros=S
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

[(Variables).Info.ProveedorD]
Carpeta=(Variables)
Clave=Info.ProveedorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[(Variables).Info.ProveedorA]
Carpeta=(Variables)
Clave=Info.ProveedorA
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

[Acciones.RepPan.CxpAux]
Nombre=CxpAux
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
ListaParametros1=Info.ProveedorD<BR>Info.ProveedorA<BR>Info.FechaD<BR>Info.FechaA

Expresion=Si (Info.MonTodo <> <T>Todo<T>) Entonces<BR>  Asigna(Info.Moneda, Info.MonTodo)<BR>Fin<BR>Caso Rep.Aux<BR>  Es <T>Concentrado<T> Entonces ReportePantalla(<T>CxpAuxConcentrado<T>, Info.ProveedorD, Info.ProveedorA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado<T> Entonces ReportePantalla(<T>CxpAux<T>,   Info.ProveedorD, Info.ProveedorA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado por Dia<T> Entonces ReportePantalla(<T>CxpAuxDia<T>, Info.ProveedorD, Info.ProveedorA, Info.FechaD, Info.FechaA)<BR>Fin
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

[Acciones.Imprimir.CxpAux]
Nombre=CxpAux
Boton=0
TipoAccion=Expresion
ListaParametros1=Info.ProveedorD<BR>Info.ProveedorA<BR>Info.FechaD<BR>Info.FechaA
Activo=S
Visible=S

Expresion=Si (Info.MonTodo <> <T>Todo<T>) Entonces<BR>  Asigna(Info.Moneda, Info.MonTodo)<BR>Fin<BR>Caso Rep.Aux<BR>  Es <T>Concentrado<T> Entonces ReporteImpresora(<T>CxpAuxConcentrado<T>, Info.ProveedorD, Info.ProveedorA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado<T> Entonces ReporteImpresora(<T>CxpAux<T>,   Info.ProveedorD, Info.ProveedorA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado por Dia<T> Entonces ReporteImpresora(<T>CxpAuxDia<T>, Info.ProveedorD, Info.ProveedorA, Info.FechaD, Info.FechaA)<BR>Fin
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

[(Variables).Info.ProvCat]
Carpeta=(Variables)
Clave=Info.ProvCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[(Variables).Info.ProvFam]
Carpeta=(Variables)
Clave=Info.ProvFam
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[(Variables).ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.ProveedorD
Info.ProveedorD=Info.ProveedorA
Info.ProveedorA=Info.ProvCat
Info.ProvCat=Info.ProvFam
Info.ProvFam=Rep.MovEspecifico
Rep.MovEspecifico=Rep.Aux
Rep.Aux=Info.MonTodo
Info.MonTodo=Rep.Titulo
Rep.Titulo=(Fin)

[(Variables).Info.MonTodo]
Carpeta=(Variables)
Clave=Info.MonTodo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Acciones.Imprimir.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=CxpAux
CxpAux=(Fin)


[Acciones.RepPan.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=CxpAux
CxpAux=(Fin)








[Lista.Columnas]
Moneda=64
Tipo de Cambio=77

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
