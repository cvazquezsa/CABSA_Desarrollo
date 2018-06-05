[Forma]
Clave=CteMovBitacora
Nombre=<T>Bitácora - Movimientos del Cliente<T>
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=241
PosicionInicialArriba=266
PosicionInicialAltura=296
PosicionInicialAncho=798
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Info.Mov+<T> <T>+Info.MovID
VentanaEscCerrar=S
VentanaExclusiva=S
PosicionInicialAlturaCliente=464

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteMovBitacora
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
OtroOrden=S
ListaOrden=CteMovBitacora.Fecha<TAB>(Acendente)
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Fecha/Hora<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Evento(s)
MenuLocal=S
ListaAcciones=Ampliar
ListaEnCaptura=(Lista)
BusquedaRapidaControles=S
FiltroUsuarios=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroProyectos=S
FiltroSucursales=S
FiltroUENs=S
FiltroUENsCampo=CteMovBitacora.UEN
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=CteMovBitacora.Fecha
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroFechasDefault=Este Mes
FiltroEstatus=S
FiltroSituacion=S
FiltroSituacionTodo=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
IconosNombre=FechaEnTexto(CteMovBitacora:CteMovBitacora.Fecha, <T>dd/mmm/aaaa hh:nn am/pm<T>)
FiltroGeneral=CteMovBitacora.Empresa=<T>{Empresa}<T> AND CteMovBitacora.Cliente=<T>{Info.Cuenta}<T>

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Evento=429
Fecha=117
0=136
1=126

[Acciones.Ampliar]
Nombre=Ampliar
Boton=0
NombreDesplegar=&Ampliar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=VerComentario(CampoNombre(CteMovBitacora:CteMovBitacora.Evento), CteMovBitacora:CteMovBitacora.Evento)

[Acciones.Agregar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.CteMovBitacora.Evento]
Carpeta=Lista
Clave=CteMovBitacora.Evento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Movimiento]
Carpeta=Lista
Clave=Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
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

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CteMovBitacora:CteMovBitacora.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, CteMovBitacora:CteMovBitacora.Modulo)<BR>Asigna(Info.ID, CteMovBitacora:CteMovBitacora.ID)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Propiedades
Propiedades=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Movimiento
Movimiento=CteMovBitacora.Evento
CteMovBitacora.Evento=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=(Fin)
