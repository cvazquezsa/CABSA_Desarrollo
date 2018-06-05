[Forma]
Clave=RepInvAlmMaxMin
Nombre=<T>Máximos y Mínimos<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
ListaAcciones=(Lista)
PosicionInicialAltura=234
PosicionInicialAncho=315
PosicionInicialIzquierda=354
PosicionInicialArriba=267
VentanaExclusiva=S
VentanaEscCerrar=S

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.ArticuloD, SQL(<T>SELECT MIN(Articulo) FROM Art<T>))<BR>Asigna(Info.ArticuloA, SQL(<T>SELECT MAX(Articulo) FROM Art<T>))<BR>Asigna(Info.ArtCat, <T>(Todos)<T>)<BR>Asigna(Info.ArtFam, <T>(Todos)<T>)<BR>Asigna(Info.ArtGrupo, <T>(Todos)<T>)<BR>Asigna(Info.Fabricante, <T>(Todos)<T>)<BR>Asigna(Info.AlmacenRango, <T>(Todos)<T>)<BR>Asigna(Info.ConMovimientos, <T>Si<T>)
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
FichaNombres=Arriba
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

[(Variables).Info.ArtFam]
Carpeta=(Variables)
Clave=Info.ArtFam
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

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

[(Variables).Info.Fabricante]
Carpeta=(Variables)
Clave=Info.Fabricante
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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
Activo=S
Visible=S
NombreEnBoton=S
Multiple=S
EspacioPrevio=S
ListaAccionesMultiples=Variables Asignar<BR>InvAlmMaxMin

[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Imprimir.InvAlmMaxMin]
Nombre=InvAlmMaxMin
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=InvAlmMaxMin
Activo=S
Visible=S

[Acciones.Preliminar.Variables Asignar]
Nombre=Variables Asignar  
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Preliminar.InvAlmMaxMin]
Nombre=InvAlmMaxMin
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=InvAlmMaxMin
Activo=S
Visible=S

[Acciones.PrePan.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.PrePan.InvAlmMaxMin]
Nombre=InvAlmMaxMin
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=InvAlmMaxMin
Activo=S
Visible=S

[Acciones.PrePan]
Nombre=PrePan
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Variables Asignar<BR>InvAlmMaxMin
Activo=S
Visible=S

[(Variables).Info.AlmacenRango]
Carpeta=(Variables)
Clave=Info.AlmacenRango
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S


[(Variables).ListaEnCaptura]
(Inicio)=Info.ArticuloD
Info.ArticuloD=Info.ArticuloA
Info.ArticuloA=Info.ArtCat
Info.ArtCat=Info.ArtGrupo
Info.ArtGrupo=Info.ArtFam
Info.ArtFam=Info.Fabricante
Info.Fabricante=Info.AlmacenRango
Info.AlmacenRango=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=PrePan
PrePan=(Fin)
