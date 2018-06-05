[Forma]
Clave=RepInvVal
Nombre=Valuación de Inventarios
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=420
PosicionInicialArriba=437
PosicionInicialAltura=121
PosicionInicialAncho=439
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
AccionesTamanoBoton=25x5
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
VentanaEscCerrar=S
BarraHerramientas=S
PosicionInicialAlturaCliente=123

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.ArticuloD, Nulo) <BR>Asigna(Info.ArticuloA, Nulo) <BR>Asigna(Rep.InvVal, <T>(Sin Valuar)<T>)<BR>Asigna(Info.Almacen, <T>(Todos)<T>)<BR>Asigna(Info.Desglosar, <T>Si<T>)
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
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Variables).Info.ArticuloD]
Carpeta=(Variables)
Clave=Info.ArticuloD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ArticuloA]
Carpeta=(Variables)
Clave=Info.ArticuloA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Rep.InvVal]
Carpeta=(Variables)
Clave=Rep.InvVal
Editar=S
LineaNueva=S
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

[Acciones.RepPan.InvVal]
Nombre=InvVal
Boton=0
TipoAccion=Expresion
ListaParametros1=Info.ArticuloD<BR>Info.ArticuloA
Activo=S
Visible=S
Expresion=Caso Rep.InvVal<BR>  Es <T>UEPS<T> Entonces ReportePantalla(<T>InvValPepsUeps<T>,  Info.ArticuloD, Info.ArticuloA, Info.Almacen, Rep.InvVal)<BR>  Es <T>PEPS<T> Entonces ReportePantalla(<T>InvValPepsUeps<T>,  Info.ArticuloD, Info.ArticuloA, Info.Almacen, Rep.InvVal)<BR>  Sino ReportePantalla(<T>InvVal<T>, Info.ArticuloD, Info.ArticuloA, Rep.InvVal, Info.Almacen)<BR>Fin

[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreDesplegar=&Preliminar
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=Variables Asignar<BR>InvVal
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

[Acciones.Imprimir.Imprimir]
Nombre=Imprimir
Boton=0
TipoAccion=Expresion
ListaParametros1=Info.ArticuloD<BR>Info.ArticuloA
Activo=S
Visible=S
Expresion=Caso Rep.InvVal<BR>  Es <T>UEPS<T> Entonces ReporteImpresora(<T>InvValPepsUeps<T>,  Info.ArticuloD, Info.ArticuloA, Info.Almacen, Rep.InvVal)<BR>  Es <T>PEPS<T> Entonces ReporteImpresora(<T>InvValPepsUeps<T>,  Info.ArticuloD, Info.ArticuloA, Info.Almacen, Rep.InvVal)<BR>  Sino ReporteImpresora(<T>InvVal<T>, Info.ArticuloD, Info.ArticuloA, Rep.InvVal, Info.Almacen)<BR>Fin

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
Multiple=S
EnBarraAcciones=S
TipoAccion=Controles Captura
ListaAccionesMultiples=Variables Asignar<BR>Imprimir
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

[(Variables).Info.Almacen]
Carpeta=(Variables)
Clave=Info.Almacen
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



LineaNueva=S

[(Variables).ListaEnCaptura]
(Inicio)=Info.ArticuloD
Info.ArticuloD=Info.ArticuloA
Info.ArticuloA=Rep.InvVal
Rep.InvVal=Info.Almacen
Info.Almacen=Info.FechaA
Info.FechaA=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
