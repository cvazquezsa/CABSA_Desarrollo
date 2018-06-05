[Forma]
Clave=RepGastoAcum
Nombre=Acumulados - Gastos
Icono=18
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=357
PosicionInicialArriba=290
PosicionInicialAltura=187
PosicionInicialAncho=309
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
AccionesDivision=S
VentanaExclusiva=S
AccionesCentro=S
BarraHerramientas=S
ListaAcciones=(Lista)
VentanaEscCerrar=S

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.Clase, <T>(Todas)<T>)<BR>Asigna(Info.Ejercicio, EjercicioTrabajo)<BR>Asigna(Info.Moneda, <T>(Todas)<T>)<BR>Asigna(Rep.GastoAcum, <T>por Concepto<T>)<BR>Asigna(Rep.Titulo, <T>Acumulados - Gastos<T>)
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
FichaEspacioEntreLineas=4
FichaEspacioNombres=65
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
ListaEnCaptura=(Lista)
PermiteEditar=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
EnBarraHerramientas=S
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Variables Asignar<BR>GastoAcum

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreEnBoton=S
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Variables Asignar<BR>GastoAcum

[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Preliminar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

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
ColorFuente=Negro

[(Variables).Info.Ejercicio]
Carpeta=(Variables)
Clave=Info.Ejercicio
Editar=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N
EspacioPrevio=N

[(Variables).Info.Clase]
Carpeta=(Variables)
Clave=Info.Clase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Moneda]
Carpeta=(Variables)
Clave=Info.Moneda
Editar=S
ValidaNombre=S
3D=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Rep.GastoAcum]
Carpeta=(Variables)
Clave=Rep.GastoAcum
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Preliminar.GastoAcum]
Nombre=GastoAcum
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ReportePantalla(Si(Rep.GastoAcum=<T>por Concepto<T>, <T>GastoAcumConcepto<T>,<T>GastoAcumClase<T>))

[Acciones.Imprimir.GastoAcum]
Nombre=GastoAcum
Boton=0
TipoAccion=Expresion
Expresion=ReporteImpresora(Si(Rep.GastoAcum=<T>por Concepto<T>, <T>GastoAcumConcepto<T>,<T>GastoAcumClase<T>))
Activo=S
Visible=S


[(Variables).ListaEnCaptura]
(Inicio)=Info.Clase
Info.Clase=Rep.GastoAcum
Rep.GastoAcum=Info.Ejercicio
Info.Ejercicio=Info.Moneda
Info.Moneda=Rep.Titulo
Rep.Titulo=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=(Fin)
