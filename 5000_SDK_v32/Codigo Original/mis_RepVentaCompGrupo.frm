[Forma]
Clave=mis_RepVentaCompGrupo
Nombre=Comparativo Ventas Mes - Año   (Grupo)
Icono=5
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=352
PosicionInicialArriba=266
PosicionInicialAltura=229
PosicionInicialAncho=320
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
AccionesDivision=S
VentanaExclusiva=S
AccionesCentro=S
BarraHerramientas=S
PosicionInicialAlturaCliente=202

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.Empresa, Empresa)<BR>Asigna(Info.ArticuloD, SQL(<T>SELECT Min(Articulo) FROM Art<T>))<BR>Asigna(Info.ArticuloA, SQL(<T>SELECT Max(Articulo) FROM Art<T>))<BR>Asigna(Info.ArtGrupo, <T>(Todos)<T>)<BR>Asigna(Info.Ejercicio, EjercicioTrabajo )<BR>Asigna(Info.Periodo, PeriodoTrabajo  )
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
FichaEspacioEntreLineas=11
FichaEspacioNombres=59
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
ListaEnCaptura=(Lista)
PermiteEditar=S

[(Variables).Info.ArtGrupo]
Carpeta=(Variables)
Clave=Info.ArtGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.ArticuloD]
Carpeta=(Variables)
Clave=Info.ArticuloD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.ArticuloA]
Carpeta=(Variables)
Clave=Info.ArticuloA
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

[(Variables).Info.Periodo]
Carpeta=(Variables)
Clave=Info.Periodo
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
NombreEnBoton=S
NombreDesplegar=&Imprimir
Multiple=S
EnBarraHerramientas=S
EnBarraAcciones=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
ListaAccionesMultiples=Variables Asignar<BR>mis_VentaCompGrupo
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.VerPendientes, Falso)

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
ListaAccionesMultiples=Variables Asignar<BR>mis_VentaCompGrupo
Activo=S
Visible=S

[Acciones.Imprimir.mis_VentaCompGrupo]
Nombre=mis_VentaCompGrupo
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=mis_VentaCompGrupo

[Acciones.Preliminar.mis_VentaCompGrupo]
Nombre=mis_VentaCompGrupo
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=mis_VentaCompGrupo

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
Expresion=Browser(General.RSReportASPX+<T>/Comparativo/ComparativoMA&Empresa=<T>+Info.Empresa+<T>&Ejercicio=<T>+Info.Ejercicio+<T>&Periodo=<T>+Info.Periodo+<T>&ArticuloD=<T>+Info.ArticuloD+<T>&ArticuloA=<T>+Info.ArticuloA+<T>&Filtro=<T>+<T>Grupo<T>+<T>&Valor=<T>+Info.ArtGrupo+<T>&rs:ClearSession=true&rs:Format=HTML4.0&rs:Command=Render&rc:Area=ToolBar&rs:PrevPage=Enabled&rs:NextPage=Enabled&rs:FirstPage=Enabled&rc:LinkTarget=_top&rc:JavaScript=True&rc:Toolbar=True<T>, <T>Ventas - Comparativo Mes - Año<T>)
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
EspacioPrevio=S


ActivoCondicion=General.RS
[(Variables).ListaEnCaptura]
(Inicio)=Info.Ejercicio
Info.Ejercicio=Info.Periodo
Info.Periodo=Info.ArticuloD
Info.ArticuloD=Info.ArticuloA
Info.ArticuloA=Info.ArtGrupo
Info.ArtGrupo=(Fin)










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
