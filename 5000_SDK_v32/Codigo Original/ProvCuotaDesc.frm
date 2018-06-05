[Forma]
Clave=ProvCuotaDesc
Nombre=Descuentos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=412
PosicionInicialArriba=302
PosicionInicialAlturaCliente=386
PosicionInicialAncho=455
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.ArtFam, FechaEnTexto(Info.FechaD, <T>dd/mmm/aa<T>), FechaEnTexto(Info.FechaA, <T>dd/mmm/aa<T>))

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProvCuotaDesc
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
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=ProvCuotaDesc.Porcentaje<TAB>(Acendente)
FiltroGeneral=ProvCuotaDesc.Proveedor=<T>{Info.Proveedor}<T> AND<BR>ProvCuotaDesc.Familia=<T>{Info.ArtFam}<T> AND<BR>ProvCuotaDesc.FechaD=<T>{FechaFormatoServidor(Info.FechaD)}<T> AND<BR>ProvCuotaDesc.FechaA=<T>{FechaFormatoServidor(Info.FechaA)}<T>

[Lista.ProvCuotaDesc.Porcentaje]
Carpeta=Lista
Clave=ProvCuotaDesc.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProvCuotaDesc.Descuento]
Carpeta=Lista
Clave=ProvCuotaDesc.Descuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Porcentaje=74
Descuento=116

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

[Lista.ListaEnCaptura]
(Inicio)=ProvCuotaDesc.Porcentaje
ProvCuotaDesc.Porcentaje=ProvCuotaDesc.Descuento
ProvCuotaDesc.Descuento=(Fin)
