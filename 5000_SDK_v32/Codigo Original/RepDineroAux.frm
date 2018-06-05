[Forma]
Clave=RepDineroAux
Nombre=Rep.Titulo
Icono=18
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
AccionesTamanoBoton=25x5
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)
PosicionInicialIzquierda=356
PosicionInicialArriba=239
PosicionInicialAltura=204
PosicionInicialAncho=312
VentanaExclusiva=S
AccionesDivision=S
AccionesCentro=S
VentanaEscCerrar=S
BarraHerramientas=S
EsMovimiento=S
TituloAuto=S
MovModulo=DIN
MovEspecificos=Todos
PosicionInicialAlturaCliente=256

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.CtaDineroD, SQL(<T>SELECT MIN(CtaDinero) FROM CtaDinero WHERE Tipo<>:tTipo<T>, TipoEstructura)) <BR>Asigna(Info.CtaDineroA, SQL(<T>SELECT MAX(CtaDinero) FROM CtaDinero WHERE Tipo<>:tTipo<T>, TipoEstructura)) <BR>Asigna(Info.FechaD, PrimerDiaMes)<BR>Asigna(Info.FechaA, UltimoDiaMes )<BR>Asigna(Info.Moneda, Config.ContMoneda)<BR>Asigna(Rep.AuxDinero, <T>Concentrado<T>)<BR>Asigna(Rep.MovEspecifico, <T>(Todos)<T>)<BR>Asigna(Rep.CtaDineroUso, <T>(Todos)<T>)<BR>Asigna(Rep.Titulo, <T>Auxiliares - Cuentas de Dinero<T>)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarDineroeoRegistros=S
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
ColorFuente=Negro

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CtaDineroD]
Carpeta=(Variables)
Clave=Info.CtaDineroD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CtaDineroA]
Carpeta=(Variables)
Clave=Info.CtaDineroA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.RepPan.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.RepPan.DineroAux]
Nombre=DineroAux
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
ListaParametros1=Info.CtaDineroD<BR>Info.CtaDineroA<BR>Info.FechaD<BR>Info.FechaA
Expresion=Caso Rep.AuxDinero<BR>  Es <T>Concentrado<T> Entonces ReportePantalla(<T>DineroAuxConcentrado<T>, Info.CtaDineroD, Info.CtaDineroA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado<T> Entonces ReportePantalla(<T>DineroAux<T>,   Info.CtaDineroD, Info.CtaDineroA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado por Dia<T> Entonces ReportePantalla(<T>DineroAuxDia<T>, Info.CtaDineroD, Info.CtaDineroA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado/Origen<T> Entonces ReportePantalla(<T>DineroAuxOrigen<T>,   Info.CtaDineroD, Info.CtaDineroA, Info.FechaD, Info.FechaA)<BR>Fin

[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreDesplegar=&Preliminar
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=Variables Asignar<BR>DineroAux
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

[Acciones.Imprimir.DineroAux]
Nombre=DineroAux
Boton=0
TipoAccion=Expresion
ListaParametros1=Info.CtaDineroD<BR>Info.CtaDineroA<BR>Info.FechaD<BR>Info.FechaA
Activo=S
Visible=S
Expresion=Caso Rep.AuxDinero<BR>  Es <T>Concentrado<T> Entonces ReporteImpresora(<T>DineroAuxConcentrado<T>, Info.CtaDineroD, Info.CtaDineroA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado<T> Entonces ReporteImpresora(<T>DineroAux<T>,   Info.CtaDineroD, Info.CtaDineroA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado por Dia<T> Entonces ReporteImpresora(<T>DineroAuxDia<T>, Info.CtaDineroD, Info.CtaDineroA, Info.FechaD, Info.FechaA)<BR>  Es <T>Desglosado/Origen<T> Entonces ReporteImpresora(<T>DineroAuxOrigen<T>,   Info.CtaDineroD, Info.CtaDineroA, Info.FechaD, Info.FechaA)<BR>Fin

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=Variables Asignar<BR>DineroAux
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
ColorFuente=Negro

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

[(Variables).Info.Moneda]
Carpeta=(Variables)
Clave=Info.Moneda
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Rep.MovEspecifico]
Carpeta=(Variables)
Clave=Rep.MovEspecifico
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[(Variables).Rep.CtaDineroUso]
Carpeta=(Variables)
Clave=Rep.CtaDineroUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Rep.AuxDinero]
Carpeta=(Variables)
Clave=Rep.AuxDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[(Variables).ListaEnCaptura]
(Inicio)=Info.CtaDineroD
Info.CtaDineroD=Info.CtaDineroA
Info.CtaDineroA=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Rep.CtaDineroUso
Rep.CtaDineroUso=Rep.MovEspecifico
Rep.MovEspecifico=Rep.AuxDinero
Rep.AuxDinero=Info.Moneda
Info.Moneda=Rep.Titulo
Rep.Titulo=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
