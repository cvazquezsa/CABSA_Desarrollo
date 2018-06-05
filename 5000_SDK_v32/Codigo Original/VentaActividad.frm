[Forma]
Clave=VentaActividad
Nombre=Actividades - Movimientos Pendientes
Icono=48
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=541
PosicionInicialArriba=343
PosicionInicialAlturaCliente=477
PosicionInicialAncho=837
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSeccion1=82
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Si(no Ver.Todo, Vacio(Info.Agente, <T>(Sin Asignar)<T>))
ExpresionesAlMostrar=Asigna(Info.Agente, Usuario.DefAgente)<BR>Asigna(Ver.Todo, Falso)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaActividad
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroAplicaEn=VentaDAgente.Estado
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=TareaEstado
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroTodoFinal=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
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
HojaAjustarColumnas=S
FiltroGeneral=Venta.Empresa=<T>{Empresa}<T> <BR>AND Venta.Estatus=<T>PENDIENTE<T><BR>AND (ISNULL(VentaD.CantidadPendiente,0)+ISNULL(VentaD.CantidadOrdenada, 0)+ISNULL(VentaD.CantidadReservada, 0))>0<BR>{Si(no Ver.Todo, <T> AND VentaDAgente.Agente=<T>+Si(Vacio(Info.Agente), <T>NULL<T>, Comillas(Info.Agente)), <T><T>)}

[Lista.VentaDAgente.Actividad]
Carpeta=Lista
Clave=VentaDAgente.Actividad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

[Lista.VentaDAgente.Estado]
Carpeta=Lista
Clave=VentaDAgente.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaDAgente.Agente]
Carpeta=Lista
Clave=VentaDAgente.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaDAgente.Fecha]
Carpeta=Lista
Clave=VentaDAgente.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaDAgente.HoraD]
Carpeta=Lista
Clave=VentaDAgente.HoraD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaDAgente.HoraA]
Carpeta=Lista
Clave=VentaDAgente.HoraA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Tiempo]
Carpeta=Lista
Clave=Tiempo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Columnas]
Actividad=181
Estado=95
Agente=61
Fecha=69
HoraD=43
HoraA=37
Tiempo=39
Comentarios=97
MovNombre=94
Cliente=76
Articulo=83

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

[Lista.MovNombre]
Carpeta=Lista
Clave=MovNombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris

[Comentarios.VentaDAgente.Comentarios]
Carpeta=Comentarios
Clave=VentaDAgente.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=50x3
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaDAgente.Comentarios]
Carpeta=Lista
Clave=VentaDAgente.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Agente]
Nombre=Agente
Boton=60
NombreEnBoton=S
NombreDesplegar=Especificar &Agente
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=Si<BR>  Forma(<T>EspecificarAgente<T>)<BR>Entonces<BR>  Asigna(Ver.Todo, Falso)<BR>  Verdadero<BR>Sino<BR>  Falso<BR>Fin

[Acciones.Todas]
Nombre=Todas
Boton=55
NombreEnBoton=S
NombreDesplegar=&Todas
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Antes=S
Visible=S
ActivoCondicion=no Ver.Todo
AntesExpresiones=Asigna(Ver.Todo, no Ver.Todo)

[Lista.VentaD.Articulo]
Carpeta=Lista
Clave=VentaD.Articulo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=&Actualizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar Cambios
Guardar Cambios=Agente
Agente=Todas
Todas=Actualizar
Actualizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=MovNombre
MovNombre=VentaD.Articulo
VentaD.Articulo=VentaDAgente.Actividad
VentaDAgente.Actividad=VentaDAgente.Estado
VentaDAgente.Estado=VentaDAgente.Agente
VentaDAgente.Agente=VentaDAgente.Fecha
VentaDAgente.Fecha=VentaDAgente.HoraD
VentaDAgente.HoraD=VentaDAgente.HoraA
VentaDAgente.HoraA=Tiempo
Tiempo=VentaDAgente.Comentarios
VentaDAgente.Comentarios=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Agente.Nombre
Agente.Nombre=Venta.Cliente
Venta.Cliente=Venta.ServicioSerie
Venta.ServicioSerie=(Fin)
