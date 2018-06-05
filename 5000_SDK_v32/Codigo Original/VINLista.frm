[Forma]
Clave=VINLista
Nombre=VINs
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=243
PosicionInicialArriba=241
PosicionInicialAltura=436
PosicionInicialAncho=793
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
Comentarios=Lista(Info.Articulo, Info.Cliente)
PosicionInicialAlturaCliente=515
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
ListaEnCaptura=(Lista)
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
FiltroTipo=Predefinido
FiltroFechas=S
FiltroFechasCampo=VIN.Fecha
FiltroFechasDefault=(Todo)
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroAplicaEn=VIN.TipoUnidad
FiltroAutoCampo=VIN.TipoUnidad
FiltroAutoValidar=VIN.TipoUnidad
FiltroEstilo=Folder (1 línea)
HojaMantenerSeleccion=S
FiltroPredefinido1=Nuevos (por Recibir)<BR>Seminuevos (por Recibir)<BR>Todos
FiltroPredefinido2=VIN.TipoUnidad=<T>Nuevo<T> AND VIN.FechaEntrada IS NULL<BR>VIN.TipoUnidad=<T>Seminuevo<T> AND VIN.FechaEntrada IS NULL<BR>1=1
FiltroPredefinido3=VIN.Fecha<BR>VIN.Fecha<BR>VIN.Fecha
FiltroEstatus=S
FiltroSituacion=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
FiltroGeneral={Si(ConDatos(Info.Articulo), <T>VIN.Articulo=<T>+Comillas(Info.Articulo), Si(ConDatos(Info.Cliente), <T>VIN.Cliente=<T>+Comillas(Info.Cliente), <T>1=1<T>))}

[Lista.VIN.Articulo]
Carpeta=Lista
Clave=VIN.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

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
VIN=170
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

[Lista.VIN.Fecha]
Carpeta=Lista
Clave=VIN.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VIN.NumeroEconomico]
Carpeta=Lista
Clave=VIN.NumeroEconomico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.ListaEnCaptura]
(Inicio)=VIN.VIN
VIN.VIN=VIN.Articulo
VIN.Articulo=Art.Descripcion1
Art.Descripcion1=VIN.NumeroEconomico
VIN.NumeroEconomico=VIN.Fecha
VIN.Fecha=(Fin)

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
