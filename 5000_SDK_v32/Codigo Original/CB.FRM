[Forma]
Clave=CB
Nombre=<T>Códigos Barras<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=294
PosicionInicialArriba=304
PosicionInicialAltura=416
PosicionInicialAncho=691
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSeccion1=33
PosicionSeccion2=66
VentanaBloquearAjuste=
ExpresionesAlMostrar=
PosicionInicialAlturaCliente=389

[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CB
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaMantenerSeleccion=S
Filtros=S
OtroOrden=S
ListaOrden=(Lista)
FiltroPredefinido1=
FiltroPredefinido2=
PermiteEditar=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=TipoCuenta
FiltroAplicaEn=CB.TipoCuenta
FiltroTipo=Automático
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroTodoFinal=S
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=18
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=TipoCuenta
FiltroEstilo=Folder (1 línea)
HojaAjustarColumnas=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
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

[Lista.CB.Codigo]
Carpeta=Lista
Clave=CB.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CB.TipoCuenta]
Carpeta=Lista
Clave=CB.TipoCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
IgnoraFlujo=S

[Lista.CB.Cuenta]
Carpeta=Lista
Clave=CB.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Codigo=130
SubCodigo=75
TipoCuenta=78
Cuenta=121
Cantidad=49
SubCuenta=103
Unidad=69
SerieLote=97

[Detalles.CB.Codigo]
Carpeta=Detalles
Clave=CB.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Detalles.CB.SubCodigo]
Carpeta=Detalles
Clave=CB.SubCodigo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
Pegado=N

[Detalles.CB.TipoCuenta]
Carpeta=Detalles
Clave=CB.TipoCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S

[Detalles.CB.Cuenta]
Carpeta=Detalles
Clave=CB.Cuenta
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20

[Detalles.CB.SubCuenta]
Carpeta=Detalles
Clave=CB.SubCuenta
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
Pegado=N

[Detalles.CB.Cantidad]
Carpeta=Detalles
Clave=CB.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
EnMenu=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
ConfirmarAntes=S
EspacioPrevio=
Menu=&Archivo
EnMenu=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
EnMenu=S
NombreEnBoton=S
EspacioPrevio=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S
EspacioPrevio=S
ActivoCondicion=Usuario.EnviarExcel

[Acciones.Reporte]
Nombre=Reporte
Boton=68
NombreDesplegar=Reporte
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=CB
ListaParametros1=Vacio(CB:CB.TipoCuenta, <T><T>)
ListaParametros=S
Activo=S
Visible=S

[Acciones.ArtExpress]
Nombre=ArtExpress
Boton=14
NombreEnBoton=S
NombreDesplegar=Agregar &Artículo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtExpress
Activo=S
EspacioPrevio=S
VisibleCondicion=Usuario.AgregarArtExpress

[Acciones.CteExpress]
Nombre=CteExpress
Boton=60
NombreEnBoton=S
NombreDesplegar=Agregar &Cliente
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteExpress
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Tipo, <T>Cliente<T>)
VisibleCondicion=Usuario.AgregarCteExpress

[Lista.CB.SubCuenta]
Carpeta=Lista
Clave=CB.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Lista.CB.Cantidad]
Carpeta=Lista
Clave=CB.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CB.Unidad]
Carpeta=Lista
Clave=CB.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CB.SerieLote]
Carpeta=Lista
Clave=CB.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Nuevo
Nuevo=Eliminar
Eliminar=ArtExpress
ArtExpress=CteExpress
CteExpress=Excel
Excel=Reporte
Reporte=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CB.Codigo
CB.Codigo=CB.Cuenta
CB.Cuenta=CB.SubCuenta
CB.SubCuenta=CB.Cantidad
CB.Cantidad=CB.Unidad
CB.Unidad=CB.SerieLote
CB.SerieLote=CB.TipoCuenta
CB.TipoCuenta=(Fin)

[Lista.ListaOrden]
(Inicio)=CB.Cuenta<TAB>(Acendente)
CB.Cuenta<TAB>(Acendente)=CB.SubCuenta<TAB>(Acendente)
CB.SubCuenta<TAB>(Acendente)=(Fin)
