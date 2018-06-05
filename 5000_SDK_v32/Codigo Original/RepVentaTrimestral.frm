[Forma]
Clave=RepVentaTrimestral
Nombre=<T>Ventas del Trimestre<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=292
PosicionInicialArriba=279
PosicionInicialAltura=203
PosicionInicialAncho=440
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaExclusiva=S
PosicionInicialAlturaCliente=176

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.ArtCat, <T>(Todas)<T>)<BR>Asigna(Info.ArtGrupo, <T>(Todas)<T>)<BR>Asigna(Info.ArtFam, <T>(Todas)<T>)<BR>Asigna(Info.Fabricante, <T>(Todas)<T>)<BR>Asigna(Info.Ejercicio, EjercicioTrabajo)<BR>Asigna(Info.Moneda, Config.ContMoneda)<BR>Asigna(Info.PeriodoD,  PeriodoTrabajo-2)<BR>Asigna(Rep.Titulo, <T>Ventas del Trimestre<T>)
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

[(Variables).Info.ArtCat]
Carpeta=(Variables)
Clave=Info.ArtCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.ArtGrupo]
Carpeta=(Variables)
Clave=Info.ArtGrupo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.ArtFam]
Carpeta=(Variables)
Clave=Info.ArtFam
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Fabricante]
Carpeta=(Variables)
Clave=Info.Fabricante
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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

[(Variables).Info.Moneda]
Carpeta=(Variables)
Clave=Info.Moneda
Editar=S
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

[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Imprimir.VentaRot]
Nombre=VentaRot
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=VentaRot
Activo=S
Visible=S

[Acciones.Preliminar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Preliminar.VentaRot]
Nombre=VentaRot
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=VentaRot
Activo=S
Visible=S

[Acciones.Imp.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Imp]
Nombre=Imp
Boton=4
NombreEnBoton=S
NombreDesplegar=&Imprimir
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
ListaAccionesMultiples=Variables Asignar<BR>VentaTrimestral
Activo=S
Visible=S

[Acciones.Pre]
Nombre=Pre
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
EnBarraHerramientas=S
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Variables Asignar<BR>VentaTrimestral

[Acciones.Pre.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[(Variables).Info.PeriodoD]
Carpeta=(Variables)
Clave=Info.PeriodoD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Rep.Titulo]
Carpeta=(Variables)
Clave=Rep.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Imp.VentaTrimestral]
Nombre=VentaTrimestral
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=VentaTrimestral
ListaParametros=S
Activo=S
Visible=S

[Acciones.Pre.VentaTrimestral]
Nombre=VentaTrimestral
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=VentaTrimestral
ListaParametros=S
Activo=S
Visible=S

[Acciones.Excel.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Excel.VentaTrimestral]
Nombre=VentaTrimestral
Boton=0
TipoAccion=Reportes Excel
ClaveAccion=VentaTrimestral
Activo=S
Visible=S

[Acciones.WEB.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.WEB.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Browser(General.RSReportASPX+<T>/Gerenciales/VentasTrimestre&Empresa=<T>+Info.Empresa+<T>&Categoria=<T>+Info.ArtCat+<T>&Grupo=<T>+Info.ArtGrupo+<T>&Familia=<T>+Info.ArtFam+<T>&Fabricante=<T>+Info.Fabricante+<T>&Ejercicio=<T>+Info.Ejercicio+<T>&Moneda=<T>+Info.Moneda+<T>&PeriodoD=<T>+Info.PeriodoD+<T>&rs:ClearSession=true&rs:Format=HTML4.0&rs:Command=Render&rc:Area=ToolBar&rs:PrevPage=Enabled&rs:NextPage=Enabled&rs:FirstPage=Enabled&rc:LinkTarget=_top&rc:JavaScript=True&rc:Toolbar=True<T>, <T>Ventas - Ventas del trimestre <T>)
Activo=S
Visible=S

[Acciones.WEB]
Nombre=WEB
Boton=106
NombreEnBoton=S
NombreDesplegar=&Web
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)
Visible=S


ActivoCondicion=General.RS
[(Variables).ListaEnCaptura]
(Inicio)=Info.ArtCat
Info.ArtCat=Info.ArtGrupo
Info.ArtGrupo=Info.ArtFam
Info.ArtFam=Info.Fabricante
Info.Fabricante=Info.Ejercicio
Info.Ejercicio=Info.Moneda
Info.Moneda=Info.PeriodoD
Info.PeriodoD=Rep.Titulo
Rep.Titulo=(Fin)






[Acciones.WEB.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imp
Imp=Pre
Pre=WEB
WEB=(Fin)
