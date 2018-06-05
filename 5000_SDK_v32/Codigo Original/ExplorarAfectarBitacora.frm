[Forma]
Clave=ExplorarAfectarBitacora
Nombre=Explorando - Bitácora Afectación
Icono=47
Modulos=(Todos)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=114
PosicionInicialArriba=151
PosicionInicialAlturaCliente=504
PosicionInicialAncho=795
ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista.Columnas]
0=113
1=130

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerAfectarBitacora
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroGrupo1=VerAfectarBitacora.Accion
FiltroValida1=VerAfectarBitacora.Accion
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
FiltroUsuarios=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=VerAfectarBitacora.FechaRegistro
FiltroFechasDefault=Hoy
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
ListaEnCaptura=(Lista)
FiltroAutoCampo=VerAfectarBitacora.Accion
FiltroAutoValidar=VerAfectarBitacora.Accion
FiltroTodo=S
IconosNombre=VerAfectarBitacora:VerAfectarBitacora.Movimiento
FiltroTodoFinal=S
FiltroGeneral=VerAfectarBitacora.Empresa=<T>{Empresa}<T>

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
NombreDesplegar=Personalizar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.VerAfectarBitacora.Accion]
Carpeta=Lista
Clave=VerAfectarBitacora.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerAfectarBitacora.Base]
Carpeta=Lista
Clave=VerAfectarBitacora.Base
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerAfectarBitacora.Ok]
Carpeta=Lista
Clave=VerAfectarBitacora.Ok
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerAfectarBitacora.Descripcion]
Carpeta=Lista
Clave=VerAfectarBitacora.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerAfectarBitacora.OkRef]
Carpeta=Lista
Clave=VerAfectarBitacora.OkRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VerAfectarBitacora.Accion
VerAfectarBitacora.Accion=VerAfectarBitacora.Base
VerAfectarBitacora.Base=VerAfectarBitacora.Ok
VerAfectarBitacora.Ok=VerAfectarBitacora.Descripcion
VerAfectarBitacora.Descripcion=VerAfectarBitacora.OkRef
VerAfectarBitacora.OkRef=(Fin)
