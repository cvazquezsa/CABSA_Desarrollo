[Forma]
Clave=mis_RepVentaAnalisisMov
Nombre=General de Movimientos (Ventas)
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
AccionesTamanoBoton=15x5
PosicionInicialAltura=337
PosicionInicialAncho=565
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialIzquierda=229
PosicionInicialArriba=212
SinCondicionDespliege=S
MovModulo=VTAS
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos
BarraHerramientas=S
PosicionInicialAlturaCliente=310

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.Empresa, Empresa)<BR>Asigna(Info.ClienteD, SQL(<T>SELECT Min(Cliente) FROM Cte<T>))<BR>Asigna(Info.ClienteA, SQL(<T>SELECT Max(Cliente) FROM Cte<T>))<BR>Asigna(Info.AgenteD, SQL(<T>SELECT Min(Agente) FROM Agente<T>))<BR>Asigna(Info.AgenteA, SQL(<T>SELECT Max(Agente) FROM Agente<T>))<BR>Asigna(Info.MovClaveAfecta, <T>Factura<T>)<BR>Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.Almacen, <T>(Todos)<T>)<BR>Asigna(Info.Moneda, Config.ContMoneda)<BR>Asigna(Info.CteCat, <T>(Todos)<T>)<BR>Asigna(Info.CteGrupo, <T>(Todos)<T>)<BR>Asigna(Info.CteFam, <T>(Todos)<T>)<BR>Asigna(Info.Estatus, <T>Concluido<T>)<BR>Asigna(Info.Sucursal, Nulo)<BR>Asigna(Info.UEN, Nulo)
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
ListaEnCaptura=(Lista)
CarpetaVisible=S
FichaEspacioEntreLineas=7
FichaEspacioNombres=105
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Blanco
FichaAlineacionDerecha=S
FichaEspacioNombresAuto=S
PermiteEditar=S

[(Variables).Info.ClienteA]
Carpeta=(Variables)
Clave=Info.ClienteA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ClienteD]
Carpeta=(Variables)
Clave=Info.ClienteD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[(Variables).Info.AgenteA]
Carpeta=(Variables)
Clave=Info.AgenteA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[(Variables).Info.AgenteD]
Carpeta=(Variables)
Clave=Info.AgenteD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[(Variables).Info.CteCat]
Carpeta=(Variables)
Clave=Info.CteCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.CteFam]
Carpeta=(Variables)
Clave=Info.CteFam
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.CteGrupo]
Carpeta=(Variables)
Clave=Info.CteGrupo
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
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[(Variables).Info.Almacen]
Carpeta=(Variables)
Clave=Info.Almacen
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=N

[(Variables).Info.Moneda]
Carpeta=(Variables)
Clave=Info.Moneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
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

[(Variables).Info.Estatus]
Carpeta=(Variables)
Clave=Info.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S

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

[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
Multiple=S
EnMenu=S
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
ListaAccionesMultiples=Variables Asignar<BR>mis_VentaAnalisisMov
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S

[Acciones.Preliminar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Variables Asignar<BR>mis_VentaAnalisisMov
Activo=S
Visible=S

[Acciones.Imprimir.mis_VentaAnalisisMov]
Nombre=mis_VentaAnalisisMov
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=mis_VentaAnalisisMov

[Acciones.Preliminar.mis_VentaAnalisisMov]
Nombre=mis_VentaAnalisisMov
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=mis_VentaAnalisisMov

[(Variables).Info.UEN]
Carpeta=(Variables)
Clave=Info.UEN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


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
Activo=S
Visible=S
Expresion=Browser(General.RSReportASPX+<T>/GeneralMovimientos/General+Movimientos&Empresa=<T>+Info.Empresa+<T>&ClienteD=<T>+Info.ClienteD+<T>&ClienteA=<T>+Info.ClienteA+<T>&CatCte=<T>+Info.CteCat+<T>&FamCte=<T>+Info.CteFam+<T>&GpoCte=<T>+Info.CteGrupo+<T>&Sucursal=<T>+Info.Sucursal+<T>&UEN=<T>+Info.UEN+<T>&Mov=<T>+Info.MovClaveAfecta+<T>&Moneda=<T>+Info.Moneda+<T>&Estatus=<T>+Info.Estatus+<T>&Almacen=<T>+Info.Almacen+<T>&FechaD=<T>+FechaFormatoServidor(Info.FechaD)+<T>&FechaA=<T>+FechaFormatoServidor(Info.FechaA)+<T>&rs:ClearSession=true&rs:Format=HTML4.0&rs:Command=Render&rc:Area=ToolBar&rs:PrevPage=Enabled&rs:NextPage=Enabled&rs:FirstPage=Enabled&rc:LinkTarget=_top&rc:JavaScript=True&rc:Toolbar=True<T>, <T>Ventas - General de movimientos<T>)

[Acciones.WEB]
Nombre=WEB
Boton=106
NombreEnBoton=S
NombreDesplegar=&Web
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
ListaAccionesMultiples=(Lista)
Visible=S


ActivoCondicion=General.RS

[Acciones.WEB.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=(Fin)


[(Variables).ListaEnCaptura]
(Inicio)=Info.AgenteD
Info.AgenteD=Info.AgenteA
Info.AgenteA=Info.ClienteD
Info.ClienteD=Info.ClienteA
Info.ClienteA=Info.CteCat
Info.CteCat=Info.CteFam
Info.CteFam=Info.CteGrupo
Info.CteGrupo=Info.Sucursal
Info.Sucursal=Info.UEN
Info.UEN=Info.MovClaveAfectaRV
Info.MovClaveAfectaRV=Info.Moneda
Info.Moneda=Info.Estatus
Info.Estatus=Info.Almacen
Info.Almacen=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=(Fin)

[(Variables).Info.MovClaveAfectaRV]
Carpeta=(Variables)
Clave=Info.MovClaveAfectaRV
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=WEB
WEB=(Fin)
