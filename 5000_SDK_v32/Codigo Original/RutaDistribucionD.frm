[Forma]
Clave=RutaDistribucionD
Nombre=Rutas Distribución
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=163
PosicionInicialArriba=147
PosicionInicialAltura=466
PosicionInicialAncho=697
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Ruta
PosicionInicialAlturaCliente=439

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RutaDistribucionD
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
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroArbolClave=RutaDistribucionD.AlmacenOrigen
FiltroArbolRama=RutaDistribucionD.AlmacenDestino
OtroOrden=S
ListaOrden=(Lista)
FiltroGeneral=RutaDistribucionD.Ruta=<T>{Info.Ruta}<T>

[Lista.Alm.Nombre]
Carpeta=Lista
Clave=Alm.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.AlmDestino.Nombre]
Carpeta=Lista
Clave=AlmDestino.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Columnas]
AlmacenOrigen=98
Nombre=165
AlmacenDestino=89
Nombre_1=171
TiempoEntrega=79
TiempoEntregaUnidad=62

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

[Lista.RutaDistribucionD.AlmacenOrigen]
Carpeta=Lista
Clave=RutaDistribucionD.AlmacenOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RutaDistribucionD.AlmacenDestino]
Carpeta=Lista
Clave=RutaDistribucionD.AlmacenDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RutaDistribucionD.TiempoEntrega]
Carpeta=Lista
Clave=RutaDistribucionD.TiempoEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RutaDistribucionD.TiempoEntregaUnidad]
Carpeta=Lista
Clave=RutaDistribucionD.TiempoEntregaUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=RutaDistribucionD.AlmacenOrigen
RutaDistribucionD.AlmacenOrigen=Alm.Nombre
Alm.Nombre=RutaDistribucionD.AlmacenDestino
RutaDistribucionD.AlmacenDestino=AlmDestino.Nombre
AlmDestino.Nombre=RutaDistribucionD.TiempoEntrega
RutaDistribucionD.TiempoEntrega=RutaDistribucionD.TiempoEntregaUnidad
RutaDistribucionD.TiempoEntregaUnidad=(Fin)

[Lista.ListaOrden]
(Inicio)=RutaDistribucionD.AlmacenOrigen<TAB>(Acendente)
RutaDistribucionD.AlmacenOrigen<TAB>(Acendente)=RutaDistribucionD.AlmacenDestino<TAB>(Acendente)
RutaDistribucionD.AlmacenDestino<TAB>(Acendente)=(Fin)
