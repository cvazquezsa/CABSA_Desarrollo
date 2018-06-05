[Forma]
Clave=PolizaConcentradaRS
Nombre=Poliza Concentrada
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
BarraHerramientas=S
MovModulo=CONT
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Preliminar
PosicionInicialIzquierda=521
PosicionInicialArriba=435
PosicionInicialAlturaCliente=120
PosicionInicialAncho=237
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
ExpresionesAlMostrar=Asigna(Info.Ejercicio, EjercicioTrabajo)<BR>Asigna(Info.Periodo, PeriodoTrabajo)

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
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Periodo]
Carpeta=(Variables)
Clave=Info.Periodo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Mov]
Carpeta=(Variables)
Clave=Info.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Preliminar.AsignarEmpresa]
Nombre=AsignarEmpresa
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.Empresa, <T>SALO<T>)

[Acciones.Preliminar.AsiganarVariables]
Nombre=AsiganarVariables
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Preliminar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Browser(General.RSReportASPX+<T>?%2fContabilidad%2fPoliza+Concentrada&Empresa=<T>+Info.Empresa+<T>&Ejercicio=<T>+Info.Ejercicio+<T>&Periodo=<T>+Info.Periodo+<T>&Mov=<T>+Info.Mov+<T>+&rs%3aClearSession=true&rs%3aFormat=HTML4.0&rs%3aCommand=Render&rc%3aArea=ToolBar&rs%3aPrevPage=Enabled&rs%3aNextPage=Enabled&rs%3aFirstPage=Enabled&rc%3aLinkTarget=_top&rc%3aJavaScript=True&rc%3aToolbar=True&rc%3aReplacementRoot=http%3a%2f%2fintmexs07%2fReports%2fPages%2fReport.aspx%3fServerUrl%3d<T>,<T>Poliza Concentrada<T>)

[Acciones.Preliminar]
Nombre=Preliminar
Boton=51
NombreEnBoton=S
NombreDesplegar=Preliminar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=AsignarEmpresa<BR>AsiganarVariables<BR>Expresion
Activo=S
Visible=S

[(Variables).ListaEnCaptura]
(Inicio)=Info.Ejercicio
Info.Ejercicio=Info.Periodo
Info.Periodo=Info.Mov
Info.Mov=(Fin)
