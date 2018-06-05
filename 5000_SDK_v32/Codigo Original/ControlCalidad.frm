[Forma]
Clave=ControlCalidad
Nombre=Control de Calidad
Icono=48
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=303
PosicionInicialArriba=204
PosicionInicialAlturaCliente=581
PosicionInicialAncho=673
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Almacen, Info.Articulo)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Asigna(Info.Articulo, Nulo)<BR>Asigna(Info.Almacen, Nulo)<BR>Forma(<T>EspecificarArtAlm<T>)

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SerieLoteEstatus
Fuente={Tahoma, 8, Negro, []}
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
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Serie / Lote<T>
ElementosPorPagina=200
PestanaOtroNombre=S
BusquedaRapida=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
BusquedaInicializar=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
IconosNombre=SerieLoteEstatus:SerieLoteEstatus.SerieLote
FiltroGeneral=SerieLoteEstatus.Empresa=<T>{Empresa}<T> AND SerieLoteEstatus.Almacen=<T>{Info.Almacen}<T> AND SerieLoteEstatus.Existencia>0<BR>{Si(ConDatos(Info.Articulo), <T> AND SerieLoteEstatus.Articulo=<T>+Comillas(Info.Articulo), <T><T>)}

[Lista.Columnas]
Articulo=190
SerieLote=276
Almacen=98
Existencia=64
0=178
1=183

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.LocalCalidad]
Nombre=LocalCalidad
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
NombreDesplegar=&Evaluaciones
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Asigna(Info.Articulo, SerieLoteEstatus:SerieLoteEstatus.Articulo)<BR>Asigna(Info.SubCuenta, SerieLoteEstatus:SerieLoteEstatus.SubCuenta)<BR>Asigna(Info.SerieLote, SerieLoteEstatus:SerieLoteEstatus.SerieLote)<BR>Forma(<T>SerieLoteCalidad<T>)

[Lista.SerieLoteEstatus.Existencia]
Carpeta=Lista
Clave=SerieLoteEstatus.Existencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EstatusNombre]
Carpeta=Lista
Clave=EstatusNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Actualizar Vista]
Nombre=Actualizar Vista
Boton=82
NombreDesplegar=Actualizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.LocalActualizar]
Nombre=LocalActualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Articulo]
Nombre=Articulo
Boton=107
NombreEnBoton=S
NombreDesplegar=&Artículo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Forma(<T>EspecificarArticulo<T>)

[Acciones.Almacen]
Nombre=Almacen
Boton=107
NombreEnBoton=S
NombreDesplegar=A&lmacén
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=Forma(<T>EspecificarAlmacen<T>)

[Acciones.Transferir]
Nombre=Transferir
Boton=7
NombreEnBoton=S
NombreDesplegar=&Transferir
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si(Forma(<T>EspecificarAlmacenDestino<T>),  <BR>ProcesarSQL(<T>spSerieLoteTransferir :tEmpresa, :nSuc, :tUsuario, :fFecha, :tArt, :tAlm, :tDestino<T>, Empresa, Sucursal, Usuario, FechaTrabajo, Info.Articulo, Info.Almacen, Info.AlmacenDestino)<BR>Forma.ActualizarVista<BR>)

[Acciones.Evaluacion]
Nombre=Evaluacion
Boton=35
NombreEnBoton=S
NombreDesplegar=&Evaluación
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=Asigna(Info.Articulo, SerieLoteEstatus:SerieLoteEstatus.Articulo)<BR>Asigna(Info.SubCuenta, SerieLoteEstatus:SerieLoteEstatus.SubCuenta)<BR>Asigna(Info.SerieLote, SerieLoteEstatus:SerieLoteEstatus.SerieLote)<BR>Forma(<T>SerieLoteCalidad<T>)

[Acciones.Autorizar]
Nombre=Autorizar
Boton=83
NombreEnBoton=S
NombreDesplegar=A&utorizar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
ConCondicion=S
Antes=S
Expresion=Si<BR>  Forma(<T>SerieLoteAutorizar<T>)<BR>Entonces<BR>  Forma.ActualizarVista <BR>Fin
EjecucionCondicion=ConDatos(SerieLoteEstatus:SerieLoteEstatus.SerieLote) y (SerieLoteEstatus:SerieLoteEstatus.Estatus=EstatusRechazado)
AntesExpresiones=Asigna(Info.SerieLote, SerieLoteEstatus:SerieLoteEstatus.SerieLote)

[Lista.SerieLoteEstatus.Articulo]
Carpeta=Lista
Clave=SerieLoteEstatus.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Almacen
Almacen=Articulo
Articulo=Evaluacion
Evaluacion=Autorizar
Autorizar=Transferir
Transferir=Actualizar Vista
Actualizar Vista=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SerieLoteEstatus.Articulo
SerieLoteEstatus.Articulo=SerieLoteEstatus.Existencia
SerieLoteEstatus.Existencia=EstatusNombre
EstatusNombre=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalCalidad
LocalCalidad=LocalActualizar
LocalActualizar=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=APROBADO
APROBADO=AUTORIZADO
AUTORIZADO=RECHAZADO
RECHAZADO=(Fin)
