[Forma]
Clave=InformeVentaTrimestral
Nombre=<T>Ventas del Trimestre<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=RepParam
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=571
PosicionInicialArriba=307
PosicionInicialAltura=203
PosicionInicialAncho=458
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaExclusiva=S
PosicionInicialAlturaCliente=217

VentanaEstadoInicial=Normal

VentanaExclusivaOpcion=0
ExpresionesAlMostrar=AUTOEXEC
[(Variables).Info.ArtCat]
Carpeta=(Variables)
Clave=Info.ArtCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ArtGrupo]
Carpeta=(Variables)
Clave=Info.ArtGrupo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ArtFam]
Carpeta=(Variables)
Clave=Info.ArtFam
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Fabricante]
Carpeta=(Variables)
Clave=Info.Fabricante
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Ejercicio]
Carpeta=(Variables)
Clave=Info.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Moneda]
Carpeta=(Variables)
Clave=Info.Moneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

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
[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
























Expresion=Asigna(RepParam:RepParam.RepTitulo, RepParam:RepParam.InfoTituloVTASTri )<BR>GuardarCambios<BR>Informe( <T>InformeVentaTrimestral<T>, RepParam:RepParam.RepTitulo)
[RepParam]
Estilo=Ficha
Clave=RepParam
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
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




PestanaOtroNombre=S
Pestana=S
PestanaNombre=Filtros
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=RepParam.Estacion = {EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General
[RepParam.RepParam.InfoArtCat]
Carpeta=RepParam
Clave=RepParam.InfoArtCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoArtGrupo]
Carpeta=RepParam
Clave=RepParam.InfoArtGrupo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoArtFam]
Carpeta=RepParam
Clave=RepParam.InfoArtFam
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoFabricante]
Carpeta=RepParam
Clave=RepParam.InfoFabricante
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoMoneda]
Carpeta=RepParam
Clave=RepParam.InfoMoneda
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoTituloVTASTri]
Carpeta=RepParam
Clave=RepParam.InfoTituloVTASTri
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



EspacioPrevio=S
[RepParam.RepParam.InfoEjercicio]
Carpeta=RepParam
Clave=RepParam.InfoEjercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[RepParam.RepParam.InfoPeriodoD]
Carpeta=RepParam
Clave=RepParam.InfoPeriodoD
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20


LineaNueva=S
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









[Grafica]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Grafica
Clave=Grafica
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=124
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
ListaEnCaptura=(Lista)


FiltroGeneral=RepParam.Estacion = { EstacionTrabajo }
[Grafica.RepParam.InformeGraficarTipo]
Carpeta=Grafica
Clave=RepParam.InformeGraficarTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Grafica.RepParam.InfoEtiqueta]
Carpeta=Grafica
Clave=RepParam.InfoEtiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[RepParam.ListaEnCaptura]
(Inicio)=RepParam.InfoArtCat
RepParam.InfoArtCat=RepParam.InfoArtGrupo
RepParam.InfoArtGrupo=RepParam.InfoArtFam
RepParam.InfoArtFam=RepParam.InfoFabricante
RepParam.InfoFabricante=RepParam.InfoEjercicio
RepParam.InfoEjercicio=RepParam.InfoMoneda
RepParam.InfoMoneda=RepParam.InfoPeriodoD
RepParam.InfoPeriodoD=RepParam.InfoTituloVTASTri
RepParam.InfoTituloVTASTri=(Fin)





[Grafica.RepParam.InformeGraficarCantidad]
Carpeta=Grafica
Clave=RepParam.InformeGraficarCantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
























[Acciones.WEB.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=(Fin)



[Grafica.ListaEnCaptura]
(Inicio)=RepParam.InformeGraficarTipo
RepParam.InformeGraficarTipo=RepParam.InformeGraficarCantidad
RepParam.InformeGraficarCantidad=RepParam.InfoEtiqueta
RepParam.InfoEtiqueta=RepParam.VerGraficaDetalle
RepParam.VerGraficaDetalle=(Fin)

[Grafica.RepParam.VerGraficaDetalle]
Carpeta=Grafica
Clave=RepParam.VerGraficaDetalle
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Forma.ListaCarpetas]
(Inicio)=RepParam
RepParam=Grafica
Grafica=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Preliminar
Preliminar=WEB
WEB=(Fin)
