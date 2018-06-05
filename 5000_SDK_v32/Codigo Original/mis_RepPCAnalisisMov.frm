[Forma]
Clave=mis_RepPCAnalisisMov
Nombre=General Movimientos ( Precios y Costos)
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
AccionesTamanoBoton=15x5
PosicionInicialAltura=368
PosicionInicialAncho=569
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialIzquierda=355
PosicionInicialArriba=328
SinCondicionDespliege=S
MovModulo=PC
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos
BarraHerramientas=S
PosicionInicialAlturaCliente=341

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.ArticuloD, SQL(<T>SELECT Min(Articulo) FROM Art<T>))<BR>Asigna(Info.ArticuloA, SQL(<T>SELECT Max(Articulo) FROM Art<T>))<BR>Asigna(Info.MovClaveAfecta, <T><T>)<BR>Asigna(Info.Modulo, <T>PC<T>)<BR>Asigna(Info.ArtCat, <T>(Todos)<T>)<BR>Asigna(Info.ArtGrupo, <T>(Todos)<T>)<BR>Asigna(Info.ArtFam, <T>(Todos)<T>)<BR>Asigna(Info.ArtLinea, <T>(Todos)<T>)<BR>Asigna(Info.Fabricante, <T>(Todos)<T>)<BR>Asigna(Info.Estatus, <T>Concluido<T>)<BR>Asigna(Info.Moneda, Config.ContMoneda)<BR>Asigna(Info.Sucursal, Nulo)<BR>Asigna(Info.UEN, Nulo)<BR>Asigna(Info.Desglosar, <T>No<T>)
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
EspacioPrevio=S

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

[(Variables).Info.Estatus]
Carpeta=(Variables)
Clave=Info.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

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

[(Variables).Info.ArtGrupo]
Carpeta=(Variables)
Clave=Info.ArtGrupo
Editar=S
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

[(Variables).Info.ArtLinea]
Carpeta=(Variables)
Clave=Info.ArtLinea
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Fabricante]
Carpeta=(Variables)
Clave=Info.Fabricante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Desglosar]
Carpeta=(Variables)
Clave=Info.Desglosar
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
NombreEnBoton=S
NombreDesplegar=&Imprimir
Multiple=S
EnBarraHerramientas=S
EnMenu=S
EnBarraAcciones=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
ListaAccionesMultiples=Variables Asignar<BR>mis_PCAnalisisMov
Activo=S
Visible=S

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
ListaAccionesMultiples=Variables Asignar<BR>mis_PCAnalisisMov
Activo=S
Visible=S

[Acciones.Imprimir.mis_PCAnalisisMov]
Nombre=mis_PCAnalisisMov
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=mis_PCAnalisisMov

[Acciones.Preliminar.mis_PCAnalisisMov]
Nombre=mis_PCAnalisisMov
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=mis_PCAnalisisMov

[(Variables).Info.UEN]
Carpeta=(Variables)
Clave=Info.UEN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.MovClaveAfecta]
Carpeta=(Variables)
Clave=Info.MovClaveAfecta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[(Variables).ListaEnCaptura]
(Inicio)=Info.ArticuloD
Info.ArticuloD=Info.ArticuloA
Info.ArticuloA=Info.ArtCat
Info.ArtCat=Info.ArtGrupo
Info.ArtGrupo=Info.ArtFam
Info.ArtFam=Info.ArtLinea
Info.ArtLinea=Info.Fabricante
Info.Fabricante=Info.Sucursal
Info.Sucursal=Info.UEN
Info.UEN=Info.MovClaveAfecta
Info.MovClaveAfecta=Info.Estatus
Info.Estatus=Info.Moneda
Info.Moneda=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.Desglosar
Info.Desglosar=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=(Fin)
