[Forma]
Clave=ArtCuota
Nombre=Cuota del articulo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=414
PosicionInicialAncho=791
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=304
PosicionInicialArriba=301
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
Comentarios=Lista(Info.Articulo, Info.Nombre)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
PermiteEditar=S
Vista=ArtCuota
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=ArtCuota.FechaD
FiltroFechasDefault=Este Año
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
ValidarCampos=S
ListaCamposAValidar=Prov.Nombre
FiltroGeneral=ArtCuota.Articulo=<T>{Info.Articulo}<T>

[Lista.ArtCuota.FechaD]
Carpeta=Lista
Clave=ArtCuota.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCuota.FechaA]
Carpeta=Lista
Clave=ArtCuota.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCuota.Cantidad]
Carpeta=Lista
Clave=ArtCuota.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCuota.Unidad]
Carpeta=Lista
Clave=ArtCuota.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCuota.Importe]
Carpeta=Lista
Clave=ArtCuota.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCuota.Moneda]
Carpeta=Lista
Clave=ArtCuota.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCuota.BaseDescuento]
Carpeta=Lista
Clave=ArtCuota.BaseDescuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
FechaD=86
FechaA=83
Cantidad=64
Unidad=76
Importe=106
Moneda=93
BaseDescuento=124
Proveedor=120

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Descuento]
Nombre=Descuento
Boton=47
NombreEnBoton=S
NombreDesplegar=&Descuentos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtCuotaDesc
Activo=S
Visible=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(ArtCuota:ArtCuota.Articulo) y<BR>ConDatos(ArtCuota:ArtCuota.Proveedor) y<BR>ConDatos(ArtCuota:ArtCuota.FechaD) y<BR>ConDatos(ArtCuota:ArtCuota.FechaA)
AntesExpresiones=Asigna( Info.Proveedor, ArtCuota:ArtCuota.Proveedor )<BR>Asigna( Info.FechaD, ArtCuota:ArtCuota.FechaD )<BR>Asigna( Info.FechaA, ArtCuota:ArtCuota.FechaA )

[Acciones.Reporte]
Nombre=Reporte
Boton=6
NombreEnBoton=S
NombreDesplegar=&Reporte
EnBarraHerramientas=S
Activo=S
Visible=S
TipoAccion=Reportes Pantalla
ClaveAccion=ArtCuota
ConCondicion=S
EjecucionCondicion=Asigna(Info.FechaD, PrimerDiaAño(Hoy))<BR>Asigna(Info.FechaA, UltimoDiaAño(Hoy))<BR>Forma(<T>EspecificarFechas<T>)

[Lista.ArtCuota.Proveedor]
Carpeta=Lista
Clave=ArtCuota.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Descuento
Descuento=Reporte
Reporte=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtCuota.Proveedor
ArtCuota.Proveedor=ArtCuota.FechaD
ArtCuota.FechaD=ArtCuota.FechaA
ArtCuota.FechaA=ArtCuota.Cantidad
ArtCuota.Cantidad=ArtCuota.Unidad
ArtCuota.Unidad=ArtCuota.Importe
ArtCuota.Importe=ArtCuota.Moneda
ArtCuota.Moneda=ArtCuota.BaseDescuento
ArtCuota.BaseDescuento=(Fin)
