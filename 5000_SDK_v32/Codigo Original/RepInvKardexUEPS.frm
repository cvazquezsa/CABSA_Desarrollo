[Forma]
Clave=RepInvKardexUEPS
Nombre=Rep.Titulo
Icono=18
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
AccionesTamanoBoton=25x5
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)
PosicionInicialIzquierda=466
PosicionInicialArriba=167
PosicionInicialAltura=550
PosicionInicialAncho=329
VentanaExclusiva=S
AccionesDivision=S
AccionesCentro=S
VentanaEscCerrar=S
BarraHerramientas=S
EsMovimiento=S
TituloAuto=S
MovModulo=Inv
MovEspecificos=Todos
PosicionInicialAlturaCliente=356

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.ArticuloD, SQL(<T>SELECT MIN(Articulo) FROM Art<T>))<BR>Asigna(Info.ArticuloA, SQL(<T>SELECT MAX(Articulo) FROM Art<T>)) <BR>Asigna(Info.FechaD, PrimerDiaMes)<BR>Asigna(Info.FechaA, UltimoDiaMes )<BR>Asigna(Info.Moneda, Config.ContMoneda)<BR>Asigna(Rep.Aux, <T>Concentrado<T>)<BR>Asigna(Rep.MovEspecifico, <T>(Todos)<T>)<BR>Asigna(Rep.InvAuxUMov, <T>(Todos)<T>)<BR>Asigna(Info.SubCuenta, <T>(TODAS)<T>)<BR>Asigna(Info.ArtCat, <T>(Todos)<T>)<BR>Asigna(Info.ArtFam, <T>(Todos)<T>)<BR>Asigna(Info.ArtGrupo, <T>(Todos)<T>)<BR>Asigna(Info.Fabricante, <T>(Todos)<T>)<BR>Asigna(Info.ArtLinea, <T>(Todos)<T>)<BR>Asigna(Rep.InvAcumU, <T>Inventario<T>)<BR>Asigna(Rep.InvVal, <T>(Sin Valuar)<T>)<BR>Asigna(Info.Almacen, <T>(Todos)<T>)<BR>Asigna(Rep.Titulo, <T>Kardex - Inventarios<T>)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarInveoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=81
FichaEspacioNombresAuto=S
FichaColorFondo=Plata
ListaEnCaptura=(Lista)
PermiteEditar=S
FichaNombres=Arriba
FichaAlineacion=Izquierda

[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
ValidaNombre=S
3D=S
Tamano=20
LineaNueva=S
EspacioPrevio=N
ColorFondo=Blanco

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ArticuloD]
Carpeta=(Variables)
Clave=Info.ArticuloD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[(Variables).Info.ArticuloA]
Carpeta=(Variables)
Clave=Info.ArticuloA
Editar=S
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


[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreDesplegar=&Preliminar
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=(Lista)
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


[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S

[(Variables).Rep.Titulo]
Carpeta=(Variables)
Clave=Rep.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

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



[(Variables).Info.ArtCat]
Carpeta=(Variables)
Clave=Info.ArtCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[(Variables).Info.ArtFam]
Carpeta=(Variables)
Clave=Info.ArtFam
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ArtGrupo]
Carpeta=(Variables)
Clave=Info.ArtGrupo
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



[(Variables).Info.Almacen]
Carpeta=(Variables)
Clave=Info.Almacen
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.SubCuenta]
Carpeta=(Variables)
Clave=Info.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ArtLinea]
Carpeta=(Variables)
Clave=Info.ArtLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[(Variables).ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.ArticuloD
Info.ArticuloD=Info.ArticuloA
Info.ArticuloA=Info.SubCuenta
Info.SubCuenta=Info.ArtCat
Info.ArtCat=Info.ArtFam
Info.ArtFam=Info.ArtGrupo
Info.ArtGrupo=Info.Fabricante
Info.Fabricante=Info.ArtLinea
Info.ArtLinea=Info.Almacen
Info.Almacen=Rep.Titulo
Rep.Titulo=(Fin)









[Acciones.RepPan.RepKardexUEPS]
Nombre=RepKardexUEPS
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=ReportePantalla(<T>REpInvKardexUEPS<T>)

[Acciones.Imprimir.RepKardexUEPS]
Nombre=RepKardexUEPS
Boton=0
TipoAccion=Expresion
Expresion=ReporteImpresora(<T>REpInvKardexUEPS<T>)
Activo=S
Visible=S

[Acciones.Imprimir.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=RepKardexUEPS
RepKardexUEPS=(Fin)






















[Acciones.RepPan.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=RepKardexUEPS
RepKardexUEPS=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
