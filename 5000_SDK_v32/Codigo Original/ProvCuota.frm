[Forma]
Clave=ProvCuota
Nombre=Cuota del Proveedor
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=251
PosicionInicialArriba=288
PosicionInicialAlturaCliente=414
PosicionInicialAncho=777
Comentarios=Lista(Info.Proveedor, Info.Nombre)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProvCuota
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
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PermiteEditar=S
HojaAjustarColumnas=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=ProvCuota.FechaD
FiltroFechasDefault=Este Año
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroGeneral=ProvCuota.Proveedor=<T>{Info.Proveedor}<T>

[Lista.ProvCuota.Familia]
Carpeta=Lista
Clave=ProvCuota.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProvCuota.FechaD]
Carpeta=Lista
Clave=ProvCuota.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProvCuota.FechaA]
Carpeta=Lista
Clave=ProvCuota.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProvCuota.Cantidad]
Carpeta=Lista
Clave=ProvCuota.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProvCuota.Unidad]
Carpeta=Lista
Clave=ProvCuota.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProvCuota.Importe]
Carpeta=Lista
Clave=ProvCuota.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProvCuota.Moneda]
Carpeta=Lista
Clave=ProvCuota.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProvCuota.BaseDescuento]
Carpeta=Lista
Clave=ProvCuota.BaseDescuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
Familia=208
FechaD=97
FechaA=94
Cantidad=49
Unidad=50
Importe=92
Moneda=68
BaseDescuento=82

[Acciones.Descuentos]
Nombre=Descuentos
Boton=47
NombreEnBoton=S
NombreDesplegar=&Descuentos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ProvCuotaDesc
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ProvCuota:ProvCuota.Proveedor) y<BR>ConDatos(ProvCuota:ProvCuota.Familia) y<BR>ConDatos(ProvCuota:ProvCuota.FechaD) y<BR>ConDatos(ProvCuota:ProvCuota.FechaA)
AntesExpresiones=Asigna(Info.ArtFam, ProvCuota:ProvCuota.Familia)<BR>Asigna(Info.FechaD, ProvCuota:ProvCuota.FechaD)<BR>Asigna(Info.FechaA, ProvCuota:ProvCuota.FechaA)

[Acciones.Reporte]
Nombre=Reporte
Boton=68
NombreEnBoton=S
NombreDesplegar=&Reporte
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Pantalla
ClaveAccion=ProvCuota
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Asigna(Info.FechaD, PrimerDiaAño(Hoy))<BR>Asigna(Info.FechaA, UltimoDiaAño(Hoy))<BR>Forma(<T>EspecificarFechas<T>)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Descuentos
Descuentos=Reporte
Reporte=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProvCuota.Familia
ProvCuota.Familia=ProvCuota.FechaD
ProvCuota.FechaD=ProvCuota.FechaA
ProvCuota.FechaA=ProvCuota.Cantidad
ProvCuota.Cantidad=ProvCuota.Unidad
ProvCuota.Unidad=ProvCuota.Importe
ProvCuota.Importe=ProvCuota.Moneda
ProvCuota.Moneda=ProvCuota.BaseDescuento
ProvCuota.BaseDescuento=(Fin)
