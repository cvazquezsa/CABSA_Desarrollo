[Forma]
Clave=RepVentaCteCat
Nombre=Ventas por Categoría de Clientes
Icono=18
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=374
PosicionInicialArriba=307
PosicionInicialAltura=146
PosicionInicialAncho=276
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
AccionesDivision=S
VentanaExclusiva=S
AccionesCentro=S
BarraHerramientas=S
ListaAcciones=(Lista)
VentanaEscCerrar=S
PosicionInicialAlturaCliente=119

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.FechaD, PrimerDiaMes)<BR>Asigna(Info.FechaA, UltimoDiaMes)<BR>Asigna(Rep.Ventas, <T>Ventas y Devoluciones<T>)<BR>Asigna(Info.Empresa, Empresa)
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
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
ListaEnCaptura=(Lista)
PermiteEditar=S

[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Rep.Ventas]
Carpeta=(Variables)
Clave=Rep.Ventas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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
ListaAccionesMultiples=Variables Asignar<BR>VentaCteCat

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
ListaAccionesMultiples=Variables Asignar<BR>VentaCteCat

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

[Acciones.Imprimir.VentaCteCat]
Nombre=VentaCteCat
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=VentaCteCat
Activo=S
Visible=S

[Acciones.Preliminar.VentaCteCat]
Nombre=VentaCteCat
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=VentaCteCat
Activo=S
Visible=S

[Acciones.Variables Asignar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Variables Asignar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Browser(General.RSReportASPX+<T>/Gerenciales/Clientes&Empresa=<T>+Info.Empresa+<T>&FechaD=<T>+FechaFormatoServidor(Info.FechaD)+<T>&FechaA=<T>+FechaFormatoServidor(Info.FechaA)+<T>&Filtro=<T>+Rep.Ventas+<T>&rs:ClearSession=true&rs:Format=HTML4.0&rs:Command=Render&rc:Area=ToolBar&rs:PrevPage=Enabled&rs:NextPage=Enabled&rs:FirstPage=Enabled&rc:LinkTarget=_top&rc:JavaScript=True&rc:Toolbar=True<T>, <T>Ventas - Gerenciales Clientes <T>)
Activo=S
Visible=S

[Acciones.WEB]
Nombre=WEB
Boton=106
NombreEnBoton=S
NombreDesplegar=&Web
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
ListaAccionesMultiples=(Lista)
Visible=S

ActivoCondicion=General.RS
[Acciones.WEB.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Browser(General.RSReportASPX+<T>/Gerenciales/Clientes&Empresa=<T>+Info.Empresa+<T>&FechaD=<T>+FechaFormatoServidor(Info.FechaD)+<T>&FechaA=<T>+FechaFormatoServidor(Info.FechaA)+<T>&Filtro=<T>+Rep.Ventas+<T>&rs:ClearSession=true&rs:Format=HTML4.0&rs:Command=Render&rc:Area=ToolBar&rs:PrevPage=Enabled&rs:NextPage=Enabled&rs:FirstPage=Enabled&rc:LinkTarget=_top&rc:JavaScript=True&rc:Toolbar=True<T>, <T>Ventas - Gerenciales Clientes <T>)


[(Variables).ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Rep.Ventas
Rep.Ventas=(Fin)






[Acciones.WEB.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=WEB
WEB=(Fin)
