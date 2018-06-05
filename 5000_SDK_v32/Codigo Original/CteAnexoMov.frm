[Forma]
Clave=CteAnexoMov
Nombre=<T>Anexos Movimientos - <T>+Info.Descripcion
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=112
PosicionInicialArriba=153
PosicionInicialAltura=301
PosicionInicialAncho=799
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=427
Comentarios=Info.Cuenta
ExpresionesAlCerrar=Asigna(Info.AnexoCfg, Falso)

[Lista]
Estilo=Iconos
PestanaNombre=Anexo(s)
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteAnexoMov
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaOrden=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
IconosCampo=CteAnexoMov.Icono
IconosEstilo=Iconos grandes
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Nombre<T>
ElementosPorPagina=200
PestanaOtroNombre=S
ListaEnCaptura=(Lista)
MenuLocal=S
ListaAcciones=Examinar
FiltroGrupo1=CteAnexoMov.Mov
FiltroValida1=CteAnexoMov.Mov
FiltroGrupo2=CteAnexoMov.MovID
FiltroValida2=CteAnexoMov.MovID
FiltroTodo=S
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSituacion=S
FiltroSituacionTodo=S
FiltroSucursales=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
FiltroFechasCampo=CteAnexoMov.FechaEmision
FiltroFechasDefault=Este Mes
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroProyectos=S
FiltroUENs=S
FiltroUENsCampo=CteAnexoMov.UEN
IconosNombre=CteAnexoMov:CteAnexoMov.Nombre+<T> - <T>+CteAnexoMov:CteAnexoMov.Mov+<T> <T>+CteAnexoMov:CteAnexoMov.MovID
FiltroGeneral=CteAnexoMov.Cliente=<T>{Info.Cuenta}<T> AND CteAnexoMov.Empresa=<T>{Empresa}<T>
FiltroUsuarios=S
FiltroUsuarioDefault=(Todos)

[Detalle.Anexo.Nombre]
Carpeta=Detalle
Clave=Anexo.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Anexo.Direccion]
Carpeta=Detalle
Clave=Anexo.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Detalle.Anexo.Icono]
Carpeta=Detalle
Clave=Anexo.Icono
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Detalle.Anexo.Orden]
Carpeta=Detalle
Clave=Anexo.Orden
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=6

[Lista.Columnas]
Nombre=289
Direccion=321
Tipo=105
0=130
1=82

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

[Detalle.Anexo.Tipo]
Carpeta=Detalle
Clave=Anexo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Imagen.Anexo.Imagen]
Carpeta=Imagen
Clave=Anexo.Imagen
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Comentario.Anexo.Comentario]
Carpeta=Comentario
Clave=Anexo.Comentario
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Anexo.Comentario]
Carpeta=Detalle
Clave=Anexo.Comentario
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=N
Tamano=57x12
ColorFondo=Blanco
ColorFuente=Negro
ConScroll=N

[Acciones.Editar.Anexo]
Nombre=Anexo
Boton=0
TipoAccion=Formas
ClaveAccion=AnexoMovCfg
Activo=S
Visible=S

[Acciones.Editar.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.Cambiar Estilo]
Nombre=Cambiar Estilo
Boton=0
NombreDesplegar=Cambiar Estilo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Estilo (Iconos)
Activo=S
Visible=S

[Acciones.Examinar]
Nombre=Examinar
Boton=0
NombreDesplegar=Examinar
TipoAccion=Expresion
Activo=S
EnMenu=S
Expresion=Caso CteAnexoMov:CteAnexoMov.Tipo<BR>  Es <T>Comentario<T> Entonces  VerComentario(CteAnexoMov:CteAnexoMov.Nombre+<T> - <T>+Info.Descripcion, CteAnexoMov:CteAnexoMov.Comentario) <BR>  Es <T>Mensaje<T> Entonces  VerComentario(CteAnexoMov:CteAnexoMov.Nombre+<T> - <T>+Info.Descripcion, CteAnexoMov:CteAnexoMov.Comentario) <BR>  Es <T>Imagen<T> Entonces VerImagen(CteAnexoMov:CteAnexoMov.Nombre+<T> - <T>+Info.Descripcion, CteAnexoMov:CteAnexoMov.Direccion)<BR>Sino<BR>  URL(CteAnexoMov:CteAnexoMov.Direccion)<BR>Fin
VisibleCondicion=ConDatos(CteAnexoMov:CteAnexoMov.Nombre)

[Lista.CteAnexoMov.Tipo]
Carpeta=Lista
Clave=CteAnexoMov.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteAnexoMov.Direccion]
Carpeta=Lista
Clave=CteAnexoMov.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreEnBoton=S
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CteAnexoMov:CteAnexoMov.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, CteAnexoMov:CteAnexoMov.Rama)<BR>Asigna(Info.ID, CteAnexoMov:CteAnexoMov.ID)
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

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cambiar Estilo
Cambiar Estilo=Propiedades
Propiedades=Personalizar
Personalizar=(Fin)

[Lista.ListaOrden]
(Inicio)=CteAnexoMov.ID<TAB>(Acendente)
CteAnexoMov.ID<TAB>(Acendente)=CteAnexoMov.Orden<TAB>(Acendente)
CteAnexoMov.Orden<TAB>(Acendente)=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CteAnexoMov.Tipo
CteAnexoMov.Tipo=CteAnexoMov.Direccion
CteAnexoMov.Direccion=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=(Fin)
