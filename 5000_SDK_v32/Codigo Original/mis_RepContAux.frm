[Forma]
Clave=mis_RepContAux
Nombre=Rep.Titulo
Icono=18
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
AccionesTamanoBoton=25x5
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)
PosicionInicialIzquierda=492
PosicionInicialArriba=169
PosicionInicialAltura=369
PosicionInicialAncho=382
VentanaExclusiva=S
AccionesDivision=S
AccionesCentro=S
VentanaEscCerrar=S
BarraHerramientas=S
EsMovimiento=S
TituloAuto=S
MovModulo=Cont
MovEspecificos=Todos
PosicionInicialAlturaCliente=351

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.CuentaD, SQL(<T>SELECT MIN(Cuenta) FROM Cta WHERE EsAcumulativa = 0<T>))<BR>Asigna(Info.CuentaA, SQL(<T>SELECT MAX(Cuenta) FROM Cta WHERE EsAcumulativa = 0<T>))<BR>Asigna(Info.FechaD, PrimerDiaMes)<BR>Asigna(Info.FechaA, UltimoDiaMes )<BR>Asigna(Info.Moneda, Config.ContMoneda)<BR>Asigna(Rep.Aux, <T>Concentrado<T>)<BR>Asigna(Rep.MovEspecifico, <T>(Todos)<T>)<BR>Asigna(Info.CtaCat, <T>(Todos)<T>)<BR>Asigna(Info.CtaFam, <T>(Todos)<T>)<BR>Asigna(Info.CtaGrupo, <T>(Todos)<T>)<BR>Asigna(Info.Controladora, Nulo)<BR>Asigna(Rep.Titulo, <T>Auxiliares - Contabilidad<T>)<BR>Asigna(Info.Sucursal,Nulo)<BR>Asigna(Info.IncluirPresupuestos, <T>No<T>)
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

[(Variables).Info.CuentaD]
Carpeta=(Variables)
Clave=Info.CuentaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[(Variables).Info.CuentaA]
Carpeta=(Variables)
Clave=Info.CuentaA
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

[Acciones.RepPan.ContAux]
Nombre=ContAux
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
ListaParametros1=Info.CuentaD<BR>Info.CuentaA<BR>Info.FechaD<BR>Info.FechaA

Expresion=Caso Rep.Aux<BR>  Es <T>Concentrado<T> Entonces ReportePantalla(<T>ContAuxConcentrado<T>, Info.CuentaD, Info.CuentaA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado<T> Entonces ReportePantalla(<T>mis_ContAux<T>,   Info.CuentaD, Info.CuentaA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado por Dia<T> Entonces ReportePantalla(<T>ContAuxDia<T>, Info.CuentaD, Info.CuentaA, Info.FechaD, Info.FechaA)<BR>Fin
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

[Acciones.Imprimir.ContAux]
Nombre=ContAux
Boton=0
TipoAccion=Expresion
ListaParametros1=Info.CuentaD<BR>Info.CuentaA<BR>Info.FechaD<BR>Info.FechaA
Activo=S
Visible=S
Expresion=Caso Rep.Aux<BR>  Es <T>Concentrado<T> Entonces ReporteImpresora(<T>ContAuxConcentrado<T>, Info.CuentaD, Info.CuentaA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado<T> Entonces ReporteImpresora(<T>mis_ContAux<T>,   Info.CuentaD, Info.CuentaA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado por Dia<T> Entonces ReporteImpresora(<T>ContAuxDia<T>, Info.CuentaD, Info.CuentaA, Info.FechaD, Info.FechaA)<BR>Fin

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=Variables Asignar<BR>ContAux
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
Tamano=51
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

[(Variables).Info.CtaCat]
Carpeta=(Variables)
Clave=Info.CtaCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[(Variables).Info.CtaFam]
Carpeta=(Variables)
Clave=Info.CtaFam
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.CtaGrupo]
Carpeta=(Variables)
Clave=Info.CtaGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[(Variables).Info.Sucursal]
Carpeta=(Variables)
Clave=Info.Sucursal
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




















[(Variables).Info.IncluirPresupuestos]
Carpeta=(Variables)
Clave=Info.IncluirPresupuestos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco










[Acciones.RepPan.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=ContAux
ContAux=(Fin)


[(Variables).ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.CuentaD
Info.CuentaD=Info.CuentaA
Info.CuentaA=Info.CtaCat
Info.CtaCat=Info.CtaFam
Info.CtaFam=Info.CtaGrupo
Info.CtaGrupo=Info.Sucursal
Info.Sucursal=Rep.MovEspecifico
Rep.MovEspecifico=Info.IncluirPresupuestos
Info.IncluirPresupuestos=Rep.Aux
Rep.Aux=Rep.Titulo
Rep.Titulo=(Fin)











[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
