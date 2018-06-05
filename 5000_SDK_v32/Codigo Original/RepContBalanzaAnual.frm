[Forma]
Clave=RepContBalanzaAnual
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
Nombre=Rep.Titulo
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialIzquierda=804
PosicionInicialArriba=410
PosicionInicialAltura=230
PosicionInicialAncho=312
AccionesTamanoBoton=15x5
AccionesDerecha=S
BarraHerramientas=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=346

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.Ejercicio,  EjercicioTrabajo)<BR>Asigna(Info.CtaNivel, TipoMayor)<BR>Asigna(Info.CuentaD,  SQL( <T>SELECT MIN(Cuenta) FROM Cta WHERE Tipo<>:tTipo<T>, TipoEstructura ) )<BR>Asigna(Info.CuentaA,  SQL( <T>SELECT MAX(Cuenta) FROM Cta WHERE Tipo<>:tTipo<T>, TipoEstructura ) )<BR>Asigna(Info.CentroCostos, <T>(Todos)<T>)<BR>Asigna(Info.CentroCostos2, <T>(Todos)<T>)<BR>Asigna(Info.CentroCostos3, <T>(Todos)<T>)<BR>Asigna(Info.Proyecto, <T>(Todos)<T>)<BR>Asigna(Info.UEN, Nulo)<BR>Asigna(Rep.Titulo, e(<T>Balanza de Comprobación Anual<T>))<BR>Asigna(Info.ContMoneda, Config.ContMoneda)<BR>Asigna(Info.Controladora, Nulo)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
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

[(Variables).Info.Ejercicio]
Carpeta=(Variables)
Clave=Info.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CtaNivel]
Carpeta=(Variables)
Clave=Info.CtaNivel
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CuentaD]
Carpeta=(Variables)
Clave=Info.CuentaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CuentaA]
Carpeta=(Variables)
Clave=Info.CuentaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CentroCostos]
Carpeta=(Variables)
Clave=Info.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Preliminar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Preliminar.ContBalanzaAnual]
Nombre=ContBalanzaAnual
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=ContBalanzaAnual
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreEnBoton=S
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
TipoAccion=Reportes Impresora
ClaveAccion=ContBalanzaAnual
ListaParametros=S
Activo=S
Visible=S
EspacioPrevio=S

[(Variables).Rep.Titulo]
Carpeta=(Variables)
Clave=Rep.Titulo
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[(Variables).Info.ContMoneda]
Carpeta=(Variables)
Clave=Info.ContMoneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro



LineaNueva=S
EspacioPrevio=S


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
LineaNueva=N
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
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[(Variables).ListaEnCaptura]
(Inicio)=Info.Ejercicio
Info.Ejercicio=Info.CtaNivel
Info.CtaNivel=Info.CuentaD
Info.CuentaD=Info.CuentaA
Info.CuentaA=Info.CentroCostos
Info.CentroCostos=Info.CentroCostos2
Info.CentroCostos2=Info.CentroCostos3
Info.CentroCostos3=Info.Proyecto
Info.Proyecto=Info.UEN
Info.UEN=Info.ContMoneda
Info.ContMoneda=Rep.Titulo
Rep.Titulo=(Fin)










[Acciones.Preliminar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=ContBalanzaAnual
ContBalanzaAnual=(Fin)









[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=(Fin)
