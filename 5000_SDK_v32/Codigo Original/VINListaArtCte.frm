[Forma]
Clave=VINListaArtCte
Nombre=VINs
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=499
PosicionInicialArriba=288
PosicionInicialAltura=436
PosicionInicialAncho=281
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
Comentarios=Lista(Info.Articulo, Info.Cliente)
PosicionInicialAlturaCliente=414
MovModulo=AUTO

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=VIN.VIN
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
PestanaOtroNombre=S
PestanaNombre=VINs
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroFechasCampo=VIN.Fecha
FiltroFechasDefault=(Todo)
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroAplicaEn=VIN.TipoUnidad
FiltroAutoCampo=VIN.TipoUnidad
FiltroAutoValidar=VIN.TipoUnidad
HojaMantenerSeleccion=S
FiltroPredefinido1=por Recibir<BR>por Surtir<BR>Nuevos<BR>Seminuevos<BR>Todos
FiltroPredefinido2=VIN.FechaEntrada IS NULL<BR>VIN.FechaSalida IS NULL AND VIN.NumeroEconomico IS NOT NULL <BR>VIN.TipoUnidad=<T>Nuevo<T> AND VIN.NumeroEconomico IS NOT NULL AND VIN.FechaSalida IS NULL<BR>VIN.TipoUnidad=<T>Seminuevo<T> AND VIN.NumeroEconomico IS NOT NULL AND VIN.FechaSalida IS NULL<BR>1=1
FiltroPredefinido3=VIN.Fecha<BR>VIN.Fecha<BR>VIN.Fecha<BR>VIN.Fecha<BR>VIN.Fecha
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
FiltroGeneral={Si(ConDatos(Info.Articulo), <T>VIN.Articulo=<T>+Comillas(Info.Articulo), Si(ConDatos(Info.Cliente), <T>VIN.Cliente=<T>+Comillas(Info.Cliente), <T>1=1<T>))}

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.Columnas]
VIN=252
Articulo=118
Descripcion1=244
0=118
1=116
Descripcion1_1=171
NumeroEconomico=101
Fecha=67

[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreDesplegar=&Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SerieLoteInfo
Activo=S
Visible=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(VIN:VIN.VIN) y ConDatos(VIN:VIN.Articulo)
AntesExpresiones=Asigna(Info.SerieLote, VIN:VIN.VIN)<BR>Asigna(Info.Articulo, VIN:VIN.Articulo)<BR>Asigna(Info.SubCuenta, <T><T>)<BR>Asigna(Info.ArtTipo, TipoVIN)

[Lista.VIN.VIN]
Carpeta=Lista
Clave=VIN.VIN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Informacion
Informacion=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ORDENADO
ORDENADO=RESERVADO
RESERVADO=DISPONIBLE
DISPONIBLE=ENFIRME
ENFIRME=SERVICIO
SERVICIO=FACTURADO
FACTURADO=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)
