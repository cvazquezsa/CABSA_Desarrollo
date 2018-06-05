[Forma]
Clave=AuxiliarRS
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialAlturaCliente=188
PosicionInicialAncho=566
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialIzquierda=337
PosicionInicialArriba=399
EsMovimiento=S
MovModulo=CONT
TituloAuto=S
MovEspecificos=Todos
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Preliminar
Nombre=Auxiliar Reporting Services
ExpresionesAlMostrar=Asigna(Info.Empresa, Empresa)<BR>Asigna(Info.Mov, <T>NULL<T>)<BR>Asigna(Info.CuentaD, SQL(<T>Select Min (Cuenta) From Cta<T>))<BR>Asigna(Info.CuentaA, SQL(<T>Select Max (Cuenta) From Cta<T>))<BR>Asigna(Info.FechaD, PrimerDiaMes)<BR>Asigna(Info.FechaA, UltimoDiaMes )<BR>Asigna(Info.Moneda, Config.ContMoneda)<BR>Asigna(Info.CtaCat, <T>NULL<T>)<BR>Asigna(Info.CtaFam, <T>NULL<T>)<BR>Asigna(Info.CtaGrupo, <T>NULL<T>)<BR>Asigna(Rep.MovEspecifico, <T>(Todos)<T>)

[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
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

[(Variables).Info.Empresa]
Carpeta=(Variables)
Clave=Info.Empresa
Editar=S
LineaNueva=N
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
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CtaCat]
Carpeta=(Variables)
Clave=Info.CtaCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CtaFam]
Carpeta=(Variables)
Clave=Info.CtaFam
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CtaGrupo]
Carpeta=(Variables)
Clave=Info.CtaGrupo
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

[Acciones.Preliminar]
Nombre=Preliminar
Boton=51
NombreDesplegar=&Preliminar
Multiple=S
EnBarraHerramientas=S
Activo=S
Visible=S
NombreEnBoton=S
ListaAccionesMultiples=Variables<BR>Explorador

[Acciones.Preliminar.Explorador]
Nombre=Explorador
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Browser(General.RSReportASPX+<T>?%2fContabilidad%2fAuxiliares&Empresa=<T>+Info.Empresa+<T>&CuentaD=<T>+Info.CuentaD+<T>&CuentaA=<T>+Info.CuentaA+<T>&FechaD=<T>+Info.FechaD+<T>+&FechaA=<T>+Info.FechaA+<T>&MovEspecifico=<T>+Rep.MovEspecifico+<T>&CtaCat=<T>+Info.CtaCat+<T>&CtaFam=<T>+Info.CtaFam+<T>&CtaGrupo=<T>+Info.CtaGrupo+<T>&Moneda=<T>+Info.Moneda+<T>+&rs%3aClearSession=true&rs%3aFormat=HTML4.0&rs%3aCommand=Render&rc%3aArea=ToolBar&rs%3aPrevPage=Enabled&rs%3aNextPage=Enabled&rs%3aFirstPage=Enabled&rc%3aLinkTarget=_top&rc%3aJavaScript=True&rc%3aToolbar=True&rc%3aReplacementRoot=http%3a%2f%2fintmexs07%2fReports%2fPages%2fReport.aspx%3fServerUrl%3d<T>,<T>Auxiliares<T>)

[Acciones.Preliminar.Variables]
Nombre=Variables
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[(Variables).Rep.MovEspecifico]
Carpeta=(Variables)
Clave=Rep.MovEspecifico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).ListaEnCaptura]
(Inicio)=Info.CuentaD
Info.CuentaD=Info.CuentaA
Info.CuentaA=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.CtaCat
Info.CtaCat=Info.CtaFam
Info.CtaFam=Info.CtaGrupo
Info.CtaGrupo=Info.Moneda
Info.Moneda=Rep.MovEspecifico
Rep.MovEspecifico=Info.Empresa
Info.Empresa=(Fin)
