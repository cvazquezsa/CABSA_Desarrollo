[Forma]
Clave=RecostearMovimientosVenta
Nombre=Recostear Movimientos - Ventas
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=393
PosicionInicialArriba=157
PosicionInicialAlturaCliente=419
PosicionInicialAncho=237
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Almacen, Nulo)<BR>Asigna(Info.Articulo, Nulo)<BR>Asigna(Info.ArtCat, Nulo)<BR>Asigna(Info.ArtGrupo, Nulo)<BR>Asigna(Info.ArtFam, Nulo)<BR>Asigna(Info.Fabricante, Nulo)<BR>Asigna(Info.ArtLinea, Nulo)<BR>Asigna(Info.ArtTemporada, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Sucursal, Nulo)
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
MovModulo=VTAS
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos

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
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Mov]
Carpeta=(Variables)
Clave=Info.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[(Variables).Info.Almacen]
Carpeta=(Variables)
Clave=Info.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Articulo]
Carpeta=(Variables)
Clave=Info.Articulo
Editar=S
LineaNueva=S
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
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.ArtTemporada]
Carpeta=(Variables)
Clave=Info.ArtTemporada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Proveedor]
Carpeta=(Variables)
Clave=Info.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ProcesarSQL(<T>spRecostearMovimientos :tEmpresa, :fFechaD, :fFechaA, :tTipoCosteo, :tModulo, :tMov, :tAlm, :tArt, :tCat, :tGrupo, :tFam, :tFab, :tLinea, :tTemp, :tProv, :nSuc<T>, Empresa, Info.FechaD, Info.FechaA, Info.TipoCosteo, <T>VTAS<T>, Info.Mov, Info.Almacen, Info.Articulo, Info.ArtCat, Info.ArtGrupo, Info.ArtFam, Info.Fabricante, Info.ArtLinea, Info.ArtTemporada, Info.Proveedor, Info.Sucursal) )

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=7
NombreDesplegar=&Recostear
Multiple=S
EnBarraHerramientas=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguroPrecaucion
ListaAccionesMultiples=Variables Asignar<BR>Expresion<BR>Aceptar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[(Variables).Info.TipoCosteo]
Carpeta=(Variables)
Clave=Info.TipoCosteo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.TipoCosteo
Info.TipoCosteo=Info.Mov
Info.Mov=Info.Almacen
Info.Almacen=Info.Articulo
Info.Articulo=Info.ArtCat
Info.ArtCat=Info.ArtFam
Info.ArtFam=Info.ArtGrupo
Info.ArtGrupo=Info.Fabricante
Info.Fabricante=Info.ArtLinea
Info.ArtLinea=Info.ArtTemporada
Info.ArtTemporada=Info.Proveedor
Info.Proveedor=Info.Sucursal
Info.Sucursal=(Fin)
