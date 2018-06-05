[Forma]
Clave=CorteGrupoLista
Icono=0
Modulos=CORTE
MovModulo=CORTE
Nombre=Grupos de Corte
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
PosicionInicialIzquierda=435
PosicionInicialArriba=172
PosicionInicialAltura=373
PosicionInicialAncho=496
PosicionInicialAlturaCliente=346

Comentarios=Info.Titulo
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CorteGrupo
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=CorteGrupo.Grupo
CarpetaVisible=S
PestanaNombre=Lista
HojaTitulos=S
HojaMostrarColumnas=S



BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
[Lista.Columnas]
Grupo=218
csExibith=64
csDescripcion=304
csDescuento=67
Tarifa=85
TablaComision=113
Puntos=40
Clave=81
Comision=62
ComisionImporte=64

[Detalles.ArtGrupo.Grupo]
Carpeta=Detalles
Clave=ArtGrupo.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Detalles.ArtGrupo.Descripcion]
Carpeta=Detalles
Clave=ArtGrupo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Detalles.ArtGrupo.Descuento]
Carpeta=Detalles
Clave=ArtGrupo.Descuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=ArtGrupo.Grupo
ArtGrupo.Grupo=ArtGrupo.Clave
ArtGrupo.Clave=ArtGrupo.Puntos
ArtGrupo.Puntos=ArtGrupo.TablaComision
ArtGrupo.TablaComision=(Fin)

[Lista.CorteGrupo.Grupo]
Carpeta=Lista
Clave=CorteGrupo.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco











[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
