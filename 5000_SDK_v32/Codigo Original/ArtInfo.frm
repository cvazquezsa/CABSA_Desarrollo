
[Forma]
Clave=ArtInfo
Nombre=<T>Informaci�n del Art�culo<T>
Icono=6
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=209
PosicionInicialArriba=120
PosicionInicialAltura=420
PosicionInicialAncho=947
PosicionColumna1=42
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
AccionesDivision=S
VentanaExclusiva=S
Menus=S
VentanaEscCerrar=S
Comentarios=Info.Articulo
EsConsultaExclusiva=S
BarraAyudaBold=S
PosicionSeccion1=77
PosicionInicialAlturaCliente=450
PosicionCol1=526

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=3
ExpresionesAlCerrar=Asigna(Info.Almacen, Nulo)
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Pestana=S
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Art
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=$00C8D0D4
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=General
Filtros=S
FiltroPredefinido=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroGeneral=Art.Articulo={Comillas(Info.Articulo)}

[Ficha.Art.Descripcion1]
Carpeta=Ficha
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata

[Ficha.Art.Descripcion2]
Carpeta=Ficha
Clave=Art.Descripcion2
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=41
ColorFondo=Plata
Pegado=N

[Ficha.Art.Categoria]
Carpeta=Ficha
Clave=Art.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Ficha.Art.Familia]
Carpeta=Ficha
Clave=Art.Familia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Ficha.Art.Fabricante]
Carpeta=Ficha
Clave=Art.Fabricante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Ficha.Art.Unidad]
Carpeta=Ficha
Clave=Art.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Plata
EspacioPrevio=S

[Ficha.Art.Peso]
Carpeta=Ficha
Clave=Art.Peso
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Plata

[Ficha.Art.Volumen]
Carpeta=Ficha
Clave=Art.Volumen
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=$00BBCCD5

[Ficha.Art.PrecioLista]
Carpeta=Ficha
Clave=Art.PrecioLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
EspacioPrevio=S

[Ficha.Art.MonedaPrecio]
Carpeta=Ficha
Clave=Art.MonedaPrecio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Desc.Art.DescripcionAmplia]
Carpeta=Desc
Clave=Art.DescripcionAmplia
Editar=S
LineaNueva=S
3D=S
Tamano=41x19
ColorFondo=Plata
ConScroll=S

[Notas.Art.Notas]
Carpeta=Notas
Clave=Art.Notas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=41x15
ColorFondo=Plata

[Notas.Art.Mensaje]
Carpeta=Notas
Clave=Art.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ConScroll=S

[ArtDisponible]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Disponible
Clave=ArtDisponible
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ArtDisponibleAlm
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=Almac�n
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Dispo
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroTipo=M�ltiple (por Grupos)
FiltroEnOrden=S
FiltroTodoNombre=Almacenes
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=15
Pestana=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=AlmGrupo
FiltroAplicaEn=Alm.Grupo
FiltroTodo=S
FiltroAplicaEn1=Alm.Grupo
MenuLocal=S
ListaAcciones=(Lista)

IconosNombre=ArtDisponibleAlm:ArtDisponible.Almacen
FiltroGeneral=ArtDisponible.Empresa={Comillas(Empresa)} AND<BR>ArtDisponible.Articulo={Comillas(Info.Articulo)} AND <BR>ArtDisponible.Disponible<>0.0
[ArtDisponible.Columnas]
0=85
1=95

2=78
[Acciones.Capas]
Nombre=Capas
Boton=0
NombreEnBoton=S
NombreDesplegar=Ca&pas de costos
TipoAccion=Formas
ClaveAccion=InvCapa
Activo=S
Menu=&Ver
EnMenu=S
Antes=S
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.Moneda, Art:Art.MonedaCosto)<BR>Asigna(Info.Clave, <T>G<T>)
VisibleCondicion=Usuario.Costos y ((Config.FormaCosteo = <T>Articulo<T>) o (Config.TipoCosteo en (<T>UEPS<T>,<T>PEPS<T>)))

[Ficha.EstatusNombre]
Carpeta=Ficha
Clave=EstatusNombre
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]


[Ficha.Art.Tipo]
Carpeta=Ficha
Clave=Art.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[ArtReservado]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Reservados
Clave=ArtReservado
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ArtReservado
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=Almac�n
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ArtReservado.Reservado
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
MenuLocal=S
ListaAcciones=ArtReservadoTarima
IconosNombre=ArtReservado:ArtReservado.Almacen
FiltroGeneral=ArtReservado.Empresa={Comillas(Empresa)} AND<BR>ArtReservado.Articulo={Comillas(Info.Articulo)}

[ArtReservado.Columnas]
0=116
1=101

[Acciones.Desglose]
Nombre=Desglose
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Desglosar Disponible
EnMenu=S
TipoAccion=Expresion
Antes=S
EnBarraHerramientas=S
Activo=S
Expresion=Forma(Si((Art:Art.Tipo en (TipoSerie, TipoVIN, TipoLote)) y Config.SeriesLotesMayoreo, <T>ArtDesgloseSerieLote<T>, <T>ArtDesglose<T>))
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.ArtTipo, Art:Art.Tipo)<BR>Asigna(Info.ArtTipoOpcion, Art:Art.TipoOpcion)
VisibleCondicion=(Art:Art.Tipo noen (TipoNormal, TipoServicio)) o (Art:Art.TipoOpcion<>TipoNo)

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
BtnResaltado=

[ArtReservado.ArtReservado.Reservado]
Carpeta=ArtReservado
Clave=ArtReservado.Reservado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Art.ClaveFabricante]
Carpeta=Ficha
Clave=Art.ClaveFabricante
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Costos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Costos
Clave=Costos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtConCosto
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
Filtros=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
FiltroGeneral=Art.Articulo = <T>{Info.Articulo}<T>
CondicionVisible=Usuario.Costos

[ArtConsignacion.ArtConsignacion.Consignacion]
Carpeta=ArtConsignacion
Clave=ArtConsignacion.Consignacion
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[ArtConsignacion.Columnas]
0=114
1=96

[Acciones.ArtConsignacion]
Nombre=ArtConsignacion
Boton=0
Menu=&Ver
NombreDesplegar=&Existencias a Consignaci�n
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtConsignacion
Activo=S
VisibleCondicion=Config.CompraConsignacion<><T>No<T>
UsaTeclaRapida=S
TeclaRapida=Ctrl+E

[Acciones.Reservados]
Nombre=Reservados
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+R
NombreDesplegar=&Reservados
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtReservados
Activo=S
Visible=S
EspacioPrevio=S

[Accesorios]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Accesorios
Clave=Accesorios
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtAccesorio
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
HojaMantenerSeleccion=S
MenuLocal=S
ListaAcciones=AccesoriosInfo
FiltroGeneral=ArtAccesorio.Articulo=<T>{Info.Articulo}<T>
CondicionVisible=Art:Art.Accesorios

[Accesorios.ArtAccesorio.Accesorio]
Carpeta=Accesorios
Clave=ArtAccesorio.Accesorio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=33
ColorFondo=Blanco
ColorFuente=Negro

[Accesorios.Art.Descripcion1]
Carpeta=Accesorios
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=33
ColorFondo=Blanco
ColorFuente=Negro

[Accesorios.Columnas]
Accesorio=94
Descripcion1=186

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreEnBoton=
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F11
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PropInfo
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Rama, <T>INV<T>)<BR>Asigna(Info.Descripcion, Art:Art.Descripcion1)

[Acciones.ExplorarInv]
Nombre=ExplorarInv
Boton=51
NombreEnBoton=S
Menu=&Explorar
NombreDesplegar=&Inventarios
EnMenu=S
TipoAccion=Formas
ClaveAccion=VerAcum
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Almacen, Nulo)<BR>Asigna(Info.ContMoneda, Art:Art.MonedaCosto)<BR>IrModulo(<T>INV<T>)<BR>IrDireccion(<T>INV<T>, Art:Art.Articulo)

[Acciones.CompraPendiente]
Nombre=CompraPendiente
Boton=59
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
NombreDesplegar=por &Recibir
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtCompraPendiente
Visible=S
Antes=S
NombreEnBoton=S
EspacioPrevio=S
ActivoCondicion=Usuario.ConsultarCompraPendiente
AntesExpresiones=Asigna(Info.Almacen, Nulo)

[Acciones.VentaPendiente]
Nombre=VentaPendiente
Boton=58
Menu=&Ver
NombreDesplegar=Ven&tas Pendientes
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtVentaPendiente
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+V
NombreEnBoton=S

[Costos.Art.MonedaCosto]
Carpeta=Costos
Clave=Art.MonedaCosto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
EspacioPrevio=S
ColorFuente=Negro

[Acciones.ArtSerie]
Nombre=ArtSerie
Boton=0
Menu=&Ver
NombreDesplegar=<T>&Registro de <T>+Art:Art.Tipo+<T>s<T>
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtSerieLote
Activo=S
Antes=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.ArtTipo, Art:Art.Tipo)
VisibleCondicion=(Art:Art.Tipo en (TipoSerie, TipoVIN, TipoLote, TipoPartida)) y Config.SeriesLotesMayoreo

[Acciones.PorProcesar]
Nombre=PorProcesar
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=&Notas por Procesar
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtNotas
Activo=S
Visible=S

[Refacciones]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Refacciones
Clave=Refacciones
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtRefaccion
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=Refacciones
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
FiltroGeneral=ArtRefaccion.Articulo=<T>{Info.Articulo}<T>
CondicionVisible=Art:Art.Refacciones

[Refacciones.ArtRefaccion.Cantidad]
Carpeta=Refacciones
Clave=ArtRefaccion.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Refacciones.Art.Descripcion1]
Carpeta=Refacciones
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Refacciones.Columnas]
Refaccion=80
Descripcion1=152
Cantidad=49
0=93
1=144

[ArtPartida]
Estilo=Iconos
Pestana=S
Clave=ArtPartida
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ArtPartida
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>N�mero<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroAncho=15
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=M�ltiple (por Grupos)
FiltroGrupo1=ArtPartida.Almacen
PestanaOtroNombre=S
PestanaNombre=Partidas
FiltroTodo=S
FiltroTodoFinal=S
FiltroGrupo2=ArtPartida.SubCuenta
IconosNombre=ArtPartida:ArtPartida.SerieLote
FiltroGeneral=Empresa=<T>{Empresa}<T> AND Articulo=<T>{Info.Articulo}<T> AND ROUND(ArtPartida.Existencia, 2) <> 0
CondicionVisible=Art:Art.Tipo=TipoPartida

[ArtPartida.ArtPartida.Existencia]
Carpeta=ArtPartida
Clave=ArtPartida.Existencia
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[ArtPartida.ArtPartida.ExistenciaAlterna]
Carpeta=ArtPartida
Clave=ArtPartida.ExistenciaAlterna
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[ArtPartida.Columnas]
0=75
1=54

2=-2
3=-2
4=-2
5=-2
[ArtPartida.ArtPartida.Almacen]
Carpeta=ArtPartida
Clave=ArtPartida.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[ArtPartida.ArtPartida.SubCuenta]
Carpeta=ArtPartida
Clave=ArtPartida.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Compras.CompraPendienteD.CantidadPendiente]
Carpeta=Compras
Clave=CompraPendienteD.CantidadPendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Compras.CompraPendienteD.Costo]
Carpeta=Compras
Clave=CompraPendienteD.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Compras.CompraPendienteD.FechaEntrega]
Carpeta=Compras
Clave=CompraPendienteD.FechaEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Compras.CompraPendienteD.Almacen]
Carpeta=Compras
Clave=CompraPendienteD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Compras.Columnas]
CantidadPendiente=64
Costo=64
FechaEntrega=94
Almacen=64

[Acciones.SolicitudPendiente]
Nombre=SolicitudPendiente
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+S
NombreDesplegar=&Solicitudes Pendientes
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtSolicitudPendiente
Activo=S
Visible=S

[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Art:Art.Articulo)
AntesExpresiones=Asigna(Info.Rama, <T>INV<T>)<BR>Asigna(Info.Cuenta, Art:Art.Articulo)<BR>Asigna(Info.Descripcion, Art:Art.Descripcion1)

[ArtSustitutos.Columnas]
Sustituto=68
Descripcion1=157
Comentarios=604

[Sustitutos]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Sustitutos
Clave=Sustitutos
Filtros=S
OtroOrden=S
ValidarCampos=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtSustituto
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaCamposAValidar=(Lista)
ListaOrden=ArtSustituto.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=SustitutosInfo
FiltroGeneral=ArtSustituto.Articulo=<T>{Info.Articulo}<T>
CondicionVisible=Art:Art.Sustitutos

[Sustitutos.ArtSustituto.Sustituto]
Carpeta=Sustitutos
Clave=ArtSustituto.Sustituto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Sustitutos.Columnas]
Sustituto=94
Comentarios=604
Descripcion1=187

[Sustitutos.Art.Descripcion1]
Carpeta=Sustitutos
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AccesoriosInfo]
Nombre=AccesoriosInfo
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Informaci�n
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfoCopia
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ArtAccesorio:ArtAccesorio.Accesorio)
AntesExpresiones=Asigna(Info.ArticuloCopia, ArtAccesorio:ArtAccesorio.Accesorio)<BR>Asigna(Info.Descripcion, <T>del Accesorio<T>)

[Acciones.Refacciones]
Nombre=Refacciones
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Informaci�n
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfoCopia
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ArtRefaccion:ArtRefaccion.Refaccion)
AntesExpresiones=Asigna(Info.ArticuloCopia, ArtRefaccion:ArtRefaccion.Refaccion)<BR>Asigna(Info.Descripcion, <T>de la Refacci�n<T>)

[Acciones.SustitutosInfo]
Nombre=SustitutosInfo
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Informaci�n
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfoCopia
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ArtSustituto:ArtSustituto.Sustituto)
AntesExpresiones=Asigna(Info.ArticuloCopia, ArtSustituto:ArtSustituto.Sustituto)<BR>Asigna(Info.Descripcion, <T>del Sustituto<T>)

[Acciones.ArtProvInfo]
Nombre=ArtProvInfo
Boton=0
Menu=&Ver
NombreDesplegar=Proveedores del &Art�culo
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtProvInfo
Visible=S
ActivoCondicion=Usuario.Costos

[Acciones.ArtAlmInfo]
Nombre=ArtAlmInfo
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=Art�culo en Almacenes
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtAlmInfo
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
AntesExpresiones=Asigna(Info.Descripcion, Art:Art.Descripcion1)

[ArtPartidaAsignado]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Asignado
Clave=ArtPartidaAsignado
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=SerieLoteAsigando
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Color<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=SerieLoteAsigando:SubCuenta
FiltroGeneral=Empresa=<T>{Empresa}<T> AND Articulo=<T>{Info.Articulo}<T>
CondicionVisible=Art:Art.Tipo=TipoPartida
[ArtPartidaAsignado.Almacen]
Carpeta=ArtPartidaAsignado
Clave=Almacen
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[ArtPartidaAsignado.Cliente]
Carpeta=ArtPartidaAsignado
Clave=Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[ArtPartidaAsignado.Nombre]
Carpeta=ArtPartidaAsignado
Clave=Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[ArtPartidaAsignado.Existencia]
Carpeta=ArtPartidaAsignado
Clave=Existencia
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[ArtPartidaAsignado.ExistenciaAlterna]
Carpeta=ArtPartidaAsignado
Clave=ExistenciaAlterna
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[ArtPartidaAsignado.Columnas]
0=69
1=67

2=-2
3=-2
4=-2
5=-2
[Precios]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Precios
Clave=Precios
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Art
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CondicionVisible=Config.VentaPrecios>1
[Precios.Art.PrecioLista]
Carpeta=Precios
Clave=Art.PrecioLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Precios.Art.Precio2]
Carpeta=Precios
Clave=Art.Precio2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Plata

[Precios.Art.Precio3]
Carpeta=Precios
Clave=Art.Precio3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Precios.Art.Precio4]
Carpeta=Precios
Clave=Art.Precio4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Precios.Art.Precio5]
Carpeta=Precios
Clave=Art.Precio5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Precios.Art.PrecioMinimo]
Carpeta=Precios
Clave=Art.PrecioMinimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata

[Precios.Art.Precio6]
Carpeta=Precios
Clave=Art.Precio6
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
LineaNueva=S

[Precios.Art.Precio7]
Carpeta=Precios
Clave=Art.Precio7
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Precios.Art.Precio8]
Carpeta=Precios
Clave=Art.Precio8
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
LineaNueva=S

[Precios.Art.Precio9]
Carpeta=Precios
Clave=Art.Precio9
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Precios.Art.Precio10]
Carpeta=Precios
Clave=Art.Precio10
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
LineaNueva=S

[Acciones.PrecioHist]
Nombre=PrecioHist
Boton=0
Menu=&Ver
NombreDesplegar=&Hist�rico de Precios
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtPrecioHist
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.Descripcion, Art:Art.Descripcion1)

[Acciones.Partidas]
Nombre=Partidas
Boton=0
Menu=&Ver
NombreDesplegar=Par&tidas
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtPartidaCteInfo
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.ArtTipo, Art:Art.Tipo)
VisibleCondicion=Art:Art.Tipo=TipoPartida

[SubCostos]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Costos (Nivel Opci�n)
Clave=SubCostos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtSubCosto
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Opci�n<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=(Lista)
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSucursales=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
IconosNombre=ArtSubCosto:ArtSubCosto.SubCuenta
FiltroGeneral=ArtSubCosto.Empresa = <T>{Empresa}<T> AND ArtSubCosto.Articulo = <T>{Info.Articulo}<T>
CondicionVisible=Usuario.Costos y Config.CosteoNivelSubCuenta y (Art:Art.TipoOpcion<>TipoNo)

[SubCostos.Columnas]
0=83
1=160

2=-2
3=-2
[Acciones.ArtCostoHist]
Nombre=ArtCostoHist
Boton=0
Menu=&Ver
NombreDesplegar=Hist�rico de Costos
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtCostoHist
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.Descripcion, Art:Art.Descripcion1)
VisibleCondicion=Usuario.Costos

[Refacciones.ArtRefaccion.Refaccion]
Carpeta=Refacciones
Clave=ArtRefaccion.Refaccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Plan]
Nombre=Plan
Boton=88
Menu=&Ver
NombreDesplegar=&Plan
EnMenu=S
TipoAccion=Expresion
Visible=S
ListaParametros1=Art:Art.Articulo
Antes=S
EnBarraHerramientas=S
UsaTeclaRapida=S
TeclaRapida=May�s+Ctrl+P
Expresion=Si(Art:Art.Espacios, CalendarioReservaciones(Info.Articulo, <T><T>), ReportePantalla(<T>PlanArt<T>))
ActivoCondicion=Art:Art.Espacios o ((no Art:Art.EsFormula) y Usuario.ConsultarCompraPendiente)
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.Almacen, Art:Art.AlmacenROP)<BR>Asigna(Info.Descripcion, Art:Art.Descripcion1)<BR>Asigna(Info.ArtTipoOpcion, Art:Art.TipoOpcion)

[SubCostos.ArtSubCosto.UltimoCosto]
Carpeta=SubCostos
Clave=ArtSubCosto.UltimoCosto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=0

[SubCostos.ArtSubCosto.CostoPromedio]
Carpeta=SubCostos
Clave=ArtSubCosto.CostoPromedio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=0

[SubCostos.Art.MonedaCosto]
Carpeta=SubCostos
Clave=Art.MonedaCosto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.VerOpcion]
Nombre=VerOpcion
Boton=0
NombreDesplegar=&Interpretar Opci�n
EnMenu=S
TipoAccion=Expresion
Expresion=VerOpcionesArticulo(ArtSubCosto:ArtSubCosto.Articulo, ArtSubCosto:ArtSubCosto.SubCuenta)
ActivoCondicion=ConDatos(ArtSubCosto:ArtSubCosto.SubCuenta)
VisibleCondicion=Art:Art.TipoOpcion=TipoSi

[Acciones.ArtSubCostoHist]
Nombre=ArtSubCostoHist
Boton=0
NombreDesplegar=Hist�rico de Costos (nivel Opciones)
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtSubCostoHist
Activo=S
Menu=&Ver
Antes=S
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.Descripcion, Art:Art.Descripcion1)
VisibleCondicion=Usuario.Costos y Config.CosteoNivelSubCuenta y (Art:Art.TipoOpcion<>TipoNo)

[Acciones.Doc]
Nombre=Doc
Boton=17
Menu=&Ver
NombreDesplegar=&Documentaci�n
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=VerDocumentacion(<T>INV<T>, Info.Articulo, <T>Documentaci�n - <T>+Art:Art.Descripcion1)
EjecucionCondicion=ConDatos(Art:Art.Articulo)

[Servicios]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Servicios
Clave=Servicios
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtServicio
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=ArtServicio.Articulo=<T>{Info.Articulo}<T>
FiltroRespetar=S
FiltroTipo=General
CondicionVisible=Art:Art.Servicios

[Servicios.ArtServicio.Servicio]
Carpeta=Servicios
Clave=ArtServicio.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Servicios.ArtServicio.Cantidad]
Carpeta=Servicios
Clave=ArtServicio.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Servicios.Columnas]
Servicio=81
Cantidad=46
Descripcion1=153

[Servicios.Art.Descripcion1]
Carpeta=Servicios
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Consumibles]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Consumibles
Clave=Consumibles
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtConsumible
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=ArtConsumible.Articulo=<T>{Info.Articulo}<T>
FiltroRespetar=S
FiltroTipo=General
CondicionVisible=Art:Art.Consumibles

[Consumibles.ArtConsumible.Consumible]
Carpeta=Consumibles
Clave=ArtConsumible.Consumible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Consumibles.Art.Descripcion1]
Carpeta=Consumibles
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Consumibles.ArtConsumible.Cantidad]
Carpeta=Consumibles
Clave=ArtConsumible.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Consumibles.Columnas]
Consumible=80
Descripcion1=153
Cantidad=48

[Acciones.Sustitutos]
Nombre=Sustitutos
Boton=0
Menu=&Ver
NombreDesplegar=Sustitutos Disponibles
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtSustitutoDisponible
Activo=S
VisibleCondicion=Art:Art.Sustitutos

[Costos.ArtCostoEmpresa.UltimoCosto]
Carpeta=Costos
Clave=ArtCostoEmpresa.UltimoCosto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Costos.ArtCostoEmpresa.CostoPromedio]
Carpeta=Costos
Clave=ArtCostoEmpresa.CostoPromedio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Costos.Art.CostoEstandar]
Carpeta=Costos
Clave=Art.CostoEstandar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Costos.Art.CostoReposicion]
Carpeta=Costos
Clave=Art.CostoReposicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Opciones]
Nombre=Opciones
Boton=0
Menu=&Ver
NombreDesplegar=Disponible a &Nivel Opci�n 
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtDesglose
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.ArtTipo, Art:Art.Tipo)<BR>Asigna(Info.ArtTipoOpcion, Art:Art.TipoOpcion)
VisibleCondicion=(Art:Art.Tipo noen (TipoNormal, TipoServicio)) y (Art:Art.TipoOpcion<>TipoNo)

[ArtPartida.SubCuentaDesc]
Carpeta=ArtPartida
Clave=SubCuentaDesc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=200
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Art.Impuesto1]
Carpeta=Ficha
Clave=Art.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=$00C8D0D4

[Ficha.Art.Impuesto2]
Carpeta=Ficha
Clave=Art.Impuesto2
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=$00C8D0D4

[Ficha.Art.Impuesto3]
Carpeta=Ficha
Clave=Art.Impuesto3
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=$00C8D0D4

[Acciones.SubCostoCampos]
Nombre=SubCostoCampos
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[ArtCosto]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Costos (Nivel Sucursal)
Clave=ArtCosto
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtCosto
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Sucursal<T>
IconosNombreNumerico=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
Filtros=S
BusquedaRapidaControles=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSucursales=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
IconosNombre=ArtCosto:ArtCosto.Sucursal
FiltroGeneral=ArtCosto.Empresa=<T>{Empresa}<T> AND ArtCosto.Articulo=<T>{Info.Articulo}<T>
CondicionVisible=Usuario.Costos

[ArtCosto.ArtCosto.CostoPromedio]
Carpeta=ArtCosto
Clave=ArtCosto.CostoPromedio
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[ArtCosto.ArtCosto.UltimoCosto]
Carpeta=ArtCosto
Clave=ArtCosto.UltimoCosto
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[ArtCosto.Columnas]
0=57
1=114

2=-2
[Acciones.VentasAcum]
Nombre=VentasAcum
Boton=51
NombreEnBoton=S
Menu=&Explorar
NombreDesplegar=Ventas &Acumuladas
EnMenu=S
TipoAccion=Formas
ClaveAccion=VerAcum
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=IrModulo(<T>VTAS<T>)<BR>IrDireccion(<T>VTAS<T>, Art:Art.Articulo)

[Acciones.ComprasAcum]
Nombre=ComprasAcum
Boton=51
NombreEnBoton=S
Menu=&Explorar
NombreDesplegar=Compras A&cumuladas
EnMenu=S
TipoAccion=Formas
ClaveAccion=VerAcum
Activo=S
Antes=S
AntesExpresiones=IrModulo(<T>COMS<T>)<BR>IrDireccion(<T>COMS<T>, Art:Art.Articulo)
Visible=S

[Acciones.ExplorarVentaD]
Nombre=ExplorarVentaD
Boton=0
Menu=&Explorar
NombreDesplegar=&Ventas
EnMenu=S
TipoAccion=Formas
ClaveAccion=ExplorarVentaD
Activo=S
Antes=S
AntesExpresiones=Asigna(Filtro.Articulo, Info.Articulo)
Visible=S

[Acciones.Cubos]
Nombre=Cubos
Boton=100
Menu=&Ver
NombreDesplegar=<T>Cubos<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=CuboArticulo
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Nombre, Art:Art.Descripcion1)
Visible=S

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=103
Menu=&Ver
NombreDesplegar=E&valuaciones
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EvaluacionCalificacionInfo
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Clave, Art:Art.Articulo)<BR>Asigna(Info.Nombre, Art:Art.Descripcion1)<BR>Asigna(Info.Aplica, <T>Articulos<T>)<BR>Asigna(Info.Nombre2, Nulo)
Visible=S

[Acciones.SerieLoteCosto]
Nombre=SerieLoteCosto
Boton=0
Menu=&Ver
NombreDesplegar=Costos a Nivel Serie/Lote
EnMenu=S
TipoAccion=Formas
ClaveAccion=SerieLoteCosto
ActivoCondicion=Usuario.Costos
VisibleCondicion=(Art:Art.Tipo en (TipoSerie, TipoLote, TipoVIN, TipoPartida)) y Config.CosteoLotes

[Acciones.Politica]
Nombre=Politica
Boton=22
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=May�s+Ctrl+O
NombreDesplegar=Pol�tica
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=PoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Art:Art.Articulo)
AntesExpresiones=Asigna(Info.Rama, <T>ART<T>)<BR>Asigna(Info.Clave, Art:Art.Articulo)

[Acciones.CapasUEPS]
Nombre=CapasUEPS
Boton=0
Menu=&Ver
NombreDesplegar=Capas de costos (UEPS)
EnMenu=S
TipoAccion=Formas
ClaveAccion=InvCapa
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.Moneda, Art:Art.MonedaCosto)<BR>Asigna(Info.Clave, <T>U<T>)
VisibleCondicion=Usuario.Costos

[Acciones.CapasPEPS]
Nombre=CapasPEPS
Boton=0
Menu=&Ver
NombreDesplegar=Capas de costos (PEPS)
EnMenu=S
TipoAccion=Formas
ClaveAccion=InvCapa
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.Moneda, Art:Art.MonedaCosto)<BR>Asigna(Info.Clave, <T>P<T>)
VisibleCondicion=Usuario.Costos

[Acciones.ArtPosicionExistencia]
Nombre=ArtPosicionExistencia
Boton=0
Menu=&Ver
NombreDesplegar=Existencias por Posici�n
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtPosicionExistencia
Activo=S
VisibleCondicion=Config.Posiciones

[Presupuesto]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Presupuesto
Clave=Presupuesto
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Presupuesto
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>UEN<T>
ElementosPorPagina=200
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
BusquedaRapidaControles=S
FiltroPeriodos=S
FiltroEjercicios=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroEditarFueraPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroMonedas=S
FiltroMonedasCampo=Presupuesto.Moneda
FiltroTodo=S
FiltroAutoCampo=Presupuesto.UEN
FiltroUENsCampo=Presupuesto.UEN

IconosNombre=Presupuesto:Presupuesto.UEN
FiltroGeneral=Presupuesto.Empresa=<T>{Empresa}<T>
CondicionVisible=General.PPTO
[Presupuesto.Presupuesto.Periodo]
Carpeta=Presupuesto
Clave=Presupuesto.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Presupuesto.Presupuesto.Presupuesto]
Carpeta=Presupuesto
Clave=Presupuesto.Presupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Totalizador=1

[Presupuesto.Presupuesto.Reservado]
Carpeta=Presupuesto
Clave=Presupuesto.Reservado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Totalizador=1

[Presupuesto.Presupuesto.Ejercido]
Carpeta=Presupuesto
Clave=Presupuesto.Ejercido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Totalizador=1

[Presupuesto.Disponible]
Carpeta=Presupuesto
Clave=Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Totalizador=1

[Presupuesto.Columnas]
0=33
1=48

2=-2
3=-2
4=-2
5=-2
[Acciones.ArtDisponibleDesglosar]
Nombre=ArtDisponibleDesglosar
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Desglosar Opciones
EnMenu=S
TipoAccion=Expresion
Expresion=VerOpcionesArticuloAlmacen(ArtDisponibleAlm:ArtDisponible.Articulo, ArtDisponibleAlm:ArtDisponible.Almacen)
Activo=S
VisibleCondicion=Art:Art.TipoOpcion=<T>Si<T>

[FormaExtraValor]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Caracter�sticas
Clave=FormaExtraValor
Filtros=S
OtroOrden=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaExtraValor
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaSinBorde=S
HojaFondoGris=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleArticulo(<T>{Art:Art.Categoria}<T>, <T>{Art:Art.Grupo}<T>, <T>{Art:Art.Familia}<T>)) AND FormaExtraValor.Aplica=<T>Articulo<T> AND FormaExtraValor.AplicaClave=<T>{Art:Art.Articulo}<T>
CondicionVisible=General.CamposExtras<><T>Campos Extras<T>

[FormaExtraValor.VerCampo]
Carpeta=FormaExtraValor
Clave=VerCampo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[FormaExtraValor.VerValor]
Carpeta=FormaExtraValor
Clave=VerValor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[FormaExtraValor.Columnas]
VerCampo=173
VerValor=153

[Acciones.ArtDisponibleTarima]
Nombre=ArtDisponibleTarima
Boton=0
NombreDesplegar=Disponible a Nivel &Tarima
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtDisponibleTarima
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Almacen, ArtDisponibleAlm:ArtDisponible.Almacen)
VisibleCondicion=ArtDisponibleAlm:Alm.WMS

[Acciones.ArtReservadoTarima]
Nombre=ArtReservadoTarima
Boton=0
NombreDesplegar=Reservado a Nivel &Tarima
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtReservadoTarima
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Almacen, ArtReservado:ArtReservado.Almacen)
VisibleCondicion=ArtReservado:Alm.WMS





[Costos.ListaEnCaptura]
(Inicio)=ArtCostoEmpresa.UltimoCosto
ArtCostoEmpresa.UltimoCosto=ArtCostoEmpresa.CostoPromedio
ArtCostoEmpresa.CostoPromedio=Art.CostoEstandar
Art.CostoEstandar=Art.CostoReposicion
Art.CostoReposicion=Art.MonedaCosto
Art.MonedaCosto=(Fin)

[Accesorios.ListaEnCaptura]
(Inicio)=ArtAccesorio.Accesorio
ArtAccesorio.Accesorio=Art.Descripcion1
Art.Descripcion1=(Fin)

[Accesorios.ListaCamposAValidar]
(Inicio)=Art.PrecioLista
Art.PrecioLista=Art.MonedaPrecio
Art.MonedaPrecio=(Fin)

[Refacciones.ListaEnCaptura]
(Inicio)=ArtRefaccion.Refaccion
ArtRefaccion.Refaccion=Art.Descripcion1
Art.Descripcion1=ArtRefaccion.Cantidad
ArtRefaccion.Cantidad=(Fin)

[ArtPartida.ListaEnCaptura]
(Inicio)=ArtPartida.SubCuenta
ArtPartida.SubCuenta=SubCuentaDesc
SubCuentaDesc=ArtPartida.Existencia
ArtPartida.Existencia=ArtPartida.ExistenciaAlterna
ArtPartida.ExistenciaAlterna=ArtPartida.Almacen
ArtPartida.Almacen=(Fin)

[Sustitutos.ListaEnCaptura]
(Inicio)=ArtSustituto.Sustituto
ArtSustituto.Sustituto=Art.Descripcion1
Art.Descripcion1=(Fin)

[Sustitutos.ListaCamposAValidar]
(Inicio)=Art.PrecioLista
Art.PrecioLista=ArtSustituto.Comentarios
ArtSustituto.Comentarios=(Fin)


[SubCostos.ListaEnCaptura]
(Inicio)=ArtSubCosto.UltimoCosto
ArtSubCosto.UltimoCosto=ArtSubCosto.CostoPromedio
ArtSubCosto.CostoPromedio=Art.MonedaCosto
Art.MonedaCosto=(Fin)

[SubCostos.ListaAcciones]
(Inicio)=VerOpcion
VerOpcion=SubCostoCampos
SubCostoCampos=(Fin)

[Servicios.ListaEnCaptura]
(Inicio)=ArtServicio.Servicio
ArtServicio.Servicio=Art.Descripcion1
Art.Descripcion1=ArtServicio.Cantidad
ArtServicio.Cantidad=(Fin)

[Consumibles.ListaEnCaptura]
(Inicio)=ArtConsumible.Consumible
ArtConsumible.Consumible=Art.Descripcion1
Art.Descripcion1=ArtConsumible.Cantidad
ArtConsumible.Cantidad=(Fin)

[ArtCosto.ListaEnCaptura]
(Inicio)=ArtCosto.CostoPromedio
ArtCosto.CostoPromedio=ArtCosto.UltimoCosto
ArtCosto.UltimoCosto=(Fin)


[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)


[Ficha.Art.ObjetoGasto]
Carpeta=Ficha
Clave=Art.ObjetoGasto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41












ColorFondo=$00C8D0D4
[Precios.ListaEnCaptura]
(Inicio)=Art.PrecioLista
Art.PrecioLista=Art.Precio2
Art.Precio2=Art.Precio3
Art.Precio3=Art.Precio4
Art.Precio4=Art.Precio5
Art.Precio5=Art.Precio6
Art.Precio6=Art.Precio7
Art.Precio7=Art.Precio8
Art.Precio8=Art.Precio9
Art.Precio9=Art.Precio10
Art.Precio10=Art.PrecioMinimo
Art.PrecioMinimo=(Fin)





[Ficha.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=Art.Descripcion2
Art.Descripcion2=Art.Tipo
Art.Tipo=EstatusNombre
EstatusNombre=Art.PrecioLista
Art.PrecioLista=Art.MonedaPrecio
Art.MonedaPrecio=Art.Categoria
Art.Categoria=Art.Familia
Art.Familia=Art.Fabricante
Art.Fabricante=Art.ClaveFabricante
Art.ClaveFabricante=Art.Unidad
Art.Unidad=Art.Peso
Art.Peso=Art.Volumen
Art.Volumen=Art.Impuesto1
Art.Impuesto1=Art.Impuesto2
Art.Impuesto2=Art.Impuesto3
Art.Impuesto3=Art.ObjetoGasto
Art.ObjetoGasto=(Fin)







[Tarima]
Estilo=Iconos
Pestana=S
Clave=Tarima
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtDisponibleTarima
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
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Tarima
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Almacen<T>
ElementosPorPagina=200


IconosNombre=ArtDisponibleTarima:Tarima.Almacen
FiltroGeneral=1=1<BR>AND ArtDisponibleTarima.Articulo = <T>{Info.Articulo}<T><BR>{Si(ConDatos(Info.Almacen), <T> AND ArtDisponibleTarima.Almacen= <T>+Comillas(Info.Almacen), <T><T>)}<BR>AND ArtDisponibleTarima.Disponible <>0
[Tarima.ArtDisponibleTarima.Disponible]
Carpeta=Tarima
Clave=ArtDisponibleTarima.Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Tarima.Columnas]
Empresa=45
Articulo=124
Almacen=64
Tarima=124
Disponible=64
0=-2
1=-2
2=-2
3=-2
4=-2

5=-2
6=-2
7=-2
[Tarima.AlmPos.Descripcion]
Carpeta=Tarima
Clave=AlmPos.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Tarima.Tarima.Tarima]
Carpeta=Tarima
Clave=Tarima.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[Tarima.Tarima.Posicion]
Carpeta=Tarima
Clave=Tarima.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco








[Tarima.Tarima.Almacen]
Carpeta=Tarima
Clave=Tarima.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco











[ArtPendientes]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Apartados
Clave=ArtPendientes
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=WMSSurtidoPendienteD
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


CondicionVisible=0
[ArtPendientes.Movimiento]
Carpeta=ArtPendientes
Clave=Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ArtPendientes.Estatus]
Carpeta=ArtPendientes
Clave=Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[ArtPendientes.Tarima]
Carpeta=ArtPendientes
Clave=Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ArtPendientes.Articulo]
Carpeta=ArtPendientes
Clave=Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ArtPendientes.Almacen]
Carpeta=ArtPendientes
Clave=Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[ArtPendientes.Cantidad]
Carpeta=ArtPendientes
Clave=Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[ArtPendientes.Columnas]
Movimiento=132
Estatus=94
Tarima=71
Articulo=67
Almacen=64
Cantidad=64













[Tarima.ArtDisponibleTarima.Apartado]
Carpeta=Tarima
Clave=ArtDisponibleTarima.Apartado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



















[ArtPendientes.ListaEnCaptura]
(Inicio)=Movimiento
Movimiento=Estatus
Estatus=Tarima
Tarima=Articulo
Articulo=Almacen
Almacen=Cantidad
Cantidad=(Fin)
























[Tarima.Dispo]
Carpeta=Tarima
Clave=Dispo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






















[ArtDisponible.ListaEnCaptura]
(Inicio)=ArtDisponible.Disponible
ArtDisponible.Disponible=Dispo
Dispo=(Fin)


[ArtDisponible.Dispo]
Carpeta=ArtDisponible
Clave=Dispo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
























[Tarima.ListaEnCaptura]
(Inicio)=Tarima.Tarima
Tarima.Tarima=ArtDisponibleTarima.Disponible
ArtDisponibleTarima.Disponible=ArtDisponibleTarima.Apartado
ArtDisponibleTarima.Apartado=Dispo
Dispo=Tarima.Almacen
Tarima.Almacen=Tarima.Posicion
Tarima.Posicion=AlmPos.Descripcion
AlmPos.Descripcion=(Fin)





































































































[ArtDisponible.ListaAcciones]
(Inicio)=ArtDisponibleDesglosar
ArtDisponibleDesglosar=ArtDisponibleTarima
ArtDisponibleTarima=(Fin)





































































































































[ArtPartidaAsignado.ListaEnCaptura]
(Inicio)=Cliente
Cliente=Nombre
Nombre=Existencia
Existencia=ExistenciaAlterna
ExistenciaAlterna=Almacen
Almacen=(Fin)













[Presupuesto.ListaEnCaptura]
(Inicio)=Presupuesto.Periodo
Presupuesto.Periodo=Presupuesto.Presupuesto
Presupuesto.Presupuesto=Presupuesto.Reservado
Presupuesto.Reservado=Presupuesto.Ejercido
Presupuesto.Ejercido=Disponible
Disponible=(Fin)










[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Precios
Precios=Accesorios
Accesorios=Refacciones
Refacciones=Servicios
Servicios=Consumibles
Consumibles=Sustitutos
Sustitutos=Costos
Costos=ArtCosto
ArtCosto=SubCostos
SubCostos=FormaExtraValor
FormaExtraValor=ArtDisponible
ArtDisponible=ArtPartidaAsignado
ArtPartidaAsignado=ArtReservado
ArtReservado=ArtPartida
ArtPartida=Presupuesto
Presupuesto=Tarima
Tarima=ArtPendientes
ArtPendientes=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Propiedades
Propiedades=Evaluaciones
Evaluaciones=Anexos
Anexos=Doc
Doc=Politica
Politica=PrecioHist
PrecioHist=ArtCostoHist
ArtCostoHist=ArtSubCostoHist
ArtSubCostoHist=ArtAlmInfo
ArtAlmInfo=Plan
Plan=Cubos
Cubos=Sustitutos
Sustitutos=Desglose
Desglose=Opciones
Opciones=ArtSerie
ArtSerie=Partidas
Partidas=Reservados
Reservados=CompraPendiente
CompraPendiente=VentaPendiente
VentaPendiente=SolicitudPendiente
SolicitudPendiente=PorProcesar
PorProcesar=ArtPosicionExistencia
ArtPosicionExistencia=Capas
Capas=CapasUEPS
CapasUEPS=CapasPEPS
CapasPEPS=SerieLoteCosto
SerieLoteCosto=ArtConsignacion
ArtConsignacion=ArtProvInfo
ArtProvInfo=ExplorarVentaD
ExplorarVentaD=VentasAcum
VentasAcum=ExplorarInv
ExplorarInv=ComprasAcum
ComprasAcum=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Ver
&Ver=&Explorar
&Explorar=(Fin)
