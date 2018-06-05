[Forma]
Clave=LibroMayorRS
Nombre=Libro Mayor
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialAlturaCliente=237
PosicionInicialAncho=328
PosicionInicialIzquierda=476
PosicionInicialArriba=380
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Preliminar

[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Plata
ListaEnCaptura=(Lista)
PermiteEditar=S

[(Variables).Info.Empresa]
Carpeta=(Variables)
Clave=Info.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Ejercicio]
Carpeta=(Variables)
Clave=Info.Ejercicio
Editar=S
LineaNueva=N
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
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CtaNivel]
Carpeta=(Variables)
Clave=Info.CtaNivel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.VariablesAsignar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.VariablesAsignar.Preliminar]
Nombre=Preliminar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=51
NombreDesplegar=&Preliminar
Multiple=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
ListaAccionesMultiples=Variables Asignar<BR>Expresion
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Preliminar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Browser(General.RSReportASPX+<T>?%2fContabilidad%2fLibro+Mayor&Empresa=<T>+Info.Empresa+<T>&Ejercicio=<T>+Info.Ejercicio+<T>&Tipo=<T>+Info.CtaNivel+<T>&CentroCostos=<T>+Info.CentroCostos+<T>+&CuentaD=<T>+Info.CuentaD+<T>&CuentaA=<T>+Info.CuentaA+<T>&Sucursal=<T>+Info.Sucursal+<T>&Moneda=<T>+Info.Moneda+<T>+&rs%3aClearSession=true&rs%3aFormat=HTML4.0&rs%3aCommand=Render&rc%3aArea=ToolBar&rs%3aPrevPage=Enabled&rs%3aNextPage=Enabled&rs%3aFirstPage=Enabled&rc%3aLinkTarget=_top&rc%3aJavaScript=True&rc%3aToolbar=True&rc%3aReplacementRoot=http%3a%2f%2fintmexs07%2fReports%2fPages%2fReport.aspx%3fServerUrl%3d<T>,<T>Libro Mayor<T>)

[Acciones.Preliminar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar

[(Variables).Info.Sucursal]
Carpeta=(Variables)
Clave=Info.Sucursal
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

[(Variables).ListaEnCaptura]
(Inicio)=Info.CuentaD
Info.CuentaD=Info.CuentaA
Info.CuentaA=Info.CentroCostos
Info.CentroCostos=Info.CtaNivel
Info.CtaNivel=Info.Empresa
Info.Empresa=Info.Ejercicio
Info.Ejercicio=Info.Sucursal
Info.Sucursal=Info.Moneda
Info.Moneda=(Fin)
