[Forma]
Clave=OfertaDVol
Nombre=Volumen del Artículo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=495
PosicionInicialArriba=191
PosicionInicialAlturaCliente=306
PosicionInicialAncho=375
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Articulo

VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OfertaDVol
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
OtroOrden=S
ListaOrden=OfertaDVol.Desde<TAB>(Acendente)
HojaAjustarColumnas=S
HojaMantenerSeleccion=S

FiltroGeneral=OfertaDVol.ID={Info.ID} AND OfertaDVol.Articulo=<T>{Info.Articulo}<T>
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Lista.Columnas]
Cantidad=48
Monto=66
Desde=55
Importe=112
Porcentaje=41
Precio=80
Hasta=60
ListaPrecios=124

[Lista.OfertaDVol.Desde]
Carpeta=Lista
Clave=OfertaDVol.Desde
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.OfertaDVol.Importe]
Carpeta=Lista
Clave=OfertaDVol.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.OfertaDVol.Porcentaje]
Carpeta=Lista
Clave=OfertaDVol.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.OfertaDVol.Cantidad]
Carpeta=Lista
Clave=OfertaDVol.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.OfertaDVol.Precio]
Carpeta=Lista
Clave=OfertaDVol.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.OfertaDVol.Hasta]
Carpeta=Lista
Clave=OfertaDVol.Hasta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.OfertaDVol.ListaPrecios]
Carpeta=Lista
Clave=OfertaDVol.ListaPrecios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
























[Lista.ListaEnCaptura]
(Inicio)=OfertaDVol.Desde
OfertaDVol.Desde=OfertaDVol.Hasta
OfertaDVol.Hasta=OfertaDVol.Porcentaje
OfertaDVol.Porcentaje=OfertaDVol.Cantidad
OfertaDVol.Cantidad=OfertaDVol.Precio
OfertaDVol.Precio=OfertaDVol.Importe
OfertaDVol.Importe=OfertaDVol.ListaPrecios
OfertaDVol.ListaPrecios=(Fin)































































































































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
