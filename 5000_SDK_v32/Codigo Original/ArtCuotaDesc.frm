[Forma]
Clave=ArtCuotaDesc
Nombre=Descuentos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=377
PosicionInicialAncho=428
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=481
PosicionInicialArriba=314
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
Comentarios=Lista(Info.Proveedor, FechaEnTexto(Info.FechaD, <T>dd/mmm/aa<T>), FechaEnTexto(Info.FechaA, <T>dd/mmm/aa<T>))

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtCuotaDesc
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
PermiteEditar=S
Filtros=S
OtroOrden=S
ListaEnCaptura=(Lista)
ListaOrden=ArtCuotaDesc.Porcentaje<TAB>(Decendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ArtCuotaDesc.Articulo=<T>{Info.Articulo}<T> AND<BR>ArtCuotaDesc.FechaD=<T>{FechaFormatoServidor(Info.FechaD)}<T> AND<BR>ArtCuotaDesc.FechaA= <T>{FechaFormatoServidor(Info.FechaA)}<T> AND<BR>ArtCuotaDesc.Proveedor = <T>{Info.Proveedor}<T>

[Lista.ArtCuotaDesc.Porcentaje]
Carpeta=Lista
Clave=ArtCuotaDesc.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCuotaDesc.Descuento]
Carpeta=Lista
Clave=ArtCuotaDesc.Descuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Porcentaje=72
Descuento=126
PorcentajeIncremento=87
Factor=101

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.ArtCuotaDesc.PorcentajeIncremento]
Carpeta=Lista
Clave=ArtCuotaDesc.PorcentajeIncremento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCuotaDesc.Factor]
Carpeta=Lista
Clave=ArtCuotaDesc.Factor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=ArtCuotaDesc.Porcentaje
ArtCuotaDesc.Porcentaje=ArtCuotaDesc.Descuento
ArtCuotaDesc.Descuento=ArtCuotaDesc.PorcentajeIncremento
ArtCuotaDesc.PorcentajeIncremento=ArtCuotaDesc.Factor
ArtCuotaDesc.Factor=(Fin)
