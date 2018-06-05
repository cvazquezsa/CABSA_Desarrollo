[Forma]
Clave=TorreControl
Nombre=<T>Torre Control<T>
Icono=48
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=118
PosicionInicialArriba=84
PosicionInicialAltura=479
PosicionInicialAncho=787
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Cliente, Info.Proyecto, Info.VIN)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
EsMovimiento=S
TituloAuto=S
MovModulo=VTAS
MovEspecificos=Todos
PosicionInicialAlturaCliente=559
PosicionSeccion1=50
ExpresionesAlMostrar=Asigna(Info.VIN, Nulo)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proyecto, Nulo)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaPendienteD
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Movimientos Pendientes
ListaEnCaptura=(Lista)
Filtros=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=15
FiltroPredefinido=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
IconosSeleccionMultiple=S
FiltroGrupo1=VentaPendienteD.Articulo
FiltroValida1=VentaPendienteD.Articulo
FiltroTodo=S
BusquedaRapidaControles=S
IconosNombre=VentaPendienteD:Movimiento
FiltroGeneral=VentaPendienteD.Empresa = <T>{Empresa}<T><BR>AND VentaPendienteD.Estatus = <T>PENDIENTE<T><BR>AND VentaPendienteD.MovTipo NOT IN (<T>VTAS.F<T>, <T>VTAS.FAR<T>, <T>VTAS.FC<T>, <T>VTAS.FG<T>, <T>VTAS.FX<T>, <T>VTAS.FB<T>)<BR>AND (VentaPendienteD.CantidadPendiente > 0 OR VentaPendienteD.CantidadReservada > 0)<BR>{Si(ConDatos(Info.Cliente),  <T> AND VentaPendienteD.Cliente      =<T>+Comillas(Info.Cliente), <T><T>)}<BR>{Si(ConDatos(Info.Proyecto), <T> AND VentaPendienteD.Proyecto     =<T>+Comillas(Info.Proyecto), <T><T>)}<BR>{Si(ConDatos(Info.VIN),      <T> AND VentaPendienteD.ServicioSerie=<T>+Comillas(Info.VIN), <T><T>)}<BR>{Si(Vacio(Info.Cliente) y Vacio(Info.Proyecto) y Vacio(Info.VIN), <T>AND VentaPendienteD.ID IS NULL<T>, <T><T>)}
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

[Lista.Columnas]
0=100
1=81
Mov=106
MovID=64
FechaEmision=74
Articulo=88
CantidadPendiente=54
Precio=80
DescuentoTipo=29
DescuentoLinea=35
SubCuenta=92
Cliente=69
Movimiento=114
Almacen=64
CantidadReservada=57
CantidadOrdenada=51
Unidad=43

[Lista.VentaPendienteD.Articulo]
Carpeta=Lista
Clave=VentaPendienteD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.CantidadPendiente]
Carpeta=Lista
Clave=VentaPendienteD.CantidadPendiente
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.Precio]
Carpeta=Lista
Clave=VentaPendienteD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.DescuentoLinea]
Carpeta=Lista
Clave=VentaPendienteD.DescuentoLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.Cliente]
Carpeta=Lista
Clave=VentaPendienteD.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.Almacen]
Carpeta=Lista
Clave=VentaPendienteD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.Unidad]
Carpeta=Lista
Clave=VentaPendienteD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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
EjecucionCondicion=ConDatos(VentaPendienteD:VentaPendienteD.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaPendienteD:VentaPendienteD.ID)
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

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.VentaPendienteD.CantidadReservada]
Carpeta=Lista
Clave=VentaPendienteD.CantidadReservada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaPendienteD.FechaRequerida]
Carpeta=Lista
Clave=VentaPendienteD.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=55
NombreEnBoton=S
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

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

[Acciones.VIN]
Nombre=VIN
Boton=42
NombreEnBoton=S
NombreDesplegar=&VIN
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
ConCondicion=S
Visible=S
ActivoCondicion=Config.VIN
EjecucionCondicion=Si<BR>  Forma(<T>EspecificarVIN<T>)<BR>Entonces<BR>  Asigna(Info.Cliente, Nulo)<BR>  Asigna(Info.Proyecto, Nulo)<BR>  Verdadero<BR>Sino<BR>  Falso<BR>Fin

[Tareas]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Tareas
Clave=Tareas
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ServicioTareaVenta
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tarea<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroAncho=20
FiltroEstilo=Folder (varias líneas)
FiltroRespetar=S
FiltroTipo=Automático
CarpetaVisible=S
FiltroAutoValidar=TareaEstado
FiltroTodo=S
FiltroTodoFinal=S
FiltroAplicaEn=ServicioTarea.Estado
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=ServicioTareaVenta:ServicioTarea.Tarea
FiltroGeneral=Venta.Empresa=<T>{Empresa}<T> <BR>AND Venta.Estatus IN (<T>PENDIENTE<T>, <T>CONCLUIDO<T>)<BR>{Si(ConDatos(Info.Cliente),  <T> AND Venta.Cliente      =<T>+Comillas(Info.Cliente), <T><T>)}<BR>{Si(ConDatos(Info.Proyecto), <T> AND Venta.Proyecto     =<T>+Comillas(Info.Proyecto), <T><T>)}<BR>{Si(ConDatos(Info.VIN),      <T> AND Venta.ServicioSerie=<T>+Comillas(Info.VIN), <T><T>)}<BR>{Si(Vacio(Info.Cliente) y Vacio(Info.Proyecto) y Vacio(Info.VIN), <T>AND Venta.ID IS NULL<T>, <T><T>)}

[Tareas.ServicioTarea.Fecha]
Carpeta=Tareas
Clave=ServicioTarea.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Tareas.Columnas]
0=275
1=109

[Acciones.TareaImprimir]
Nombre=TareaImprimir
Boton=0
NombreDesplegar=&Imprimir...
EnMenu=S
Carpeta=Tareas
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.TareaPreliminar]
Nombre=TareaPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=Tareas
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.TareaExcel]
Nombre=TareaExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=Tareas
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.TareaPersonalizar]
Nombre=TareaPersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Tareas.MovimientoNombre]
Carpeta=Tareas
Clave=MovimientoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cliente]
Nombre=Cliente
Boton=60
NombreEnBoton=S
NombreDesplegar=C&liente
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
ConCondicion=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=Si<BR>  Forma(<T>EspecificarCliente<T>)<BR>Entonces<BR>  Asigna(Info.VIN, Nulo)<BR>  Asigna(Info.Proyecto, Nulo)<BR>  Verdadero<BR>Sino<BR>  Falso<BR>Fin

[Acciones.Proyecto]
Nombre=Proyecto
Boton=87
NombreEnBoton=S
NombreDesplegar=Pro&yecto
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Si<BR>  Forma(<T>EspecificarProyecto<T>)<BR>Entonces<BR>  Asigna(Info.Cliente, Nulo)<BR>  Asigna(Info.VIN, Nulo)<BR>  Verdadero<BR>Sino<BR>  Falso<BR>Fin

[Tareas.ServicioTarea.Usuario]
Carpeta=Tareas
Clave=ServicioTarea.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.TareaEditar]
Nombre=TareaEditar
Boton=0
NombreDesplegar=&Editar...
EnMenu=S
TipoAccion=Formas
ClaveAccion=ServicioTareaEditar
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(ServicioTareaVenta:ServicioTarea.RenglonID)
Antes=S
AntesExpresiones=Asigna(Info.ID, ServicioTareaVenta:ServicioTarea.ID)<BR>Asigna(Info.RenglonID, ServicioTareaVenta:ServicioTarea.RenglonID)
Visible=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=Actualizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
GuardarAntes=S

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Afectar Selección
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Antes=S
Visible=S
Expresion=Si<BR>  Dialogo(<T>TorreControlAfectar<T>)<BR>Entonces<BR>  RegistrarSeleccionIDRenglon(<T>Lista<T>, <T>VTAS<T>, <T>VentaPendienteD.ID<T>, <T>VentaPendienteD.Renglon<T>, <T>VentaPendienteD.RenglonSub<T>) <BR>  ProcesarSQL(<T>spVentaPendienteGenerar :nEstacion, :tEmpresa, :nSucursal, :tUsuario, :fFecha, :tMov<T>, EstacionTrabajo, Empresa, Sucursal, Usuario, FechaTrabajo, Info.Mov)<BR>  ActualizarVista<BR>Fin
ActivoCondicion=Usuario.AfectarLote
AntesExpresiones=Si(SQL(<T>SELECT COUNT(*) FROM ServicioTarea s, Venta v where v.ID = s.ID and v.Empresa=:tEmpresa AND v.ServicioSerie=:tVIN AND s.Estado<>:tEstado<T>, Empresa, Info.VIN, <T>Completada<T>)>0,  Si(Precaucion( <T>Existen Tareas Pendientes.<T>+NuevaLinea+NuevaLinea+<T> ¿ Desea Continuar ?<T>, BotonSi, BotonNo )<>BotonSi, AbortarOperacion))

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Tareas
Tareas=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Cliente
Cliente=Proyecto
Proyecto=VIN
VIN=Seleccionar Todo
Seleccionar Todo=Propiedades
Propiedades=Afectar
Afectar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Actualizar
Actualizar=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VentaPendienteD.Cliente
VentaPendienteD.Cliente=VentaPendienteD.Almacen
VentaPendienteD.Almacen=VentaPendienteD.FechaRequerida
VentaPendienteD.FechaRequerida=VentaPendienteD.Articulo
VentaPendienteD.Articulo=VentaPendienteD.CantidadReservada
VentaPendienteD.CantidadReservada=VentaPendienteD.CantidadPendiente
VentaPendienteD.CantidadPendiente=VentaPendienteD.Unidad
VentaPendienteD.Unidad=VentaPendienteD.Precio
VentaPendienteD.Precio=VentaPendienteD.DescuentoLinea
VentaPendienteD.DescuentoLinea=(Fin)

[Tareas.ListaEnCaptura]
(Inicio)=ServicioTarea.Fecha
ServicioTarea.Fecha=ServicioTarea.Usuario
ServicioTarea.Usuario=MovimientoNombre
MovimientoNombre=(Fin)

[Tareas.ListaAcciones]
(Inicio)=TareaEditar
TareaEditar=TareaImprimir
TareaImprimir=TareaPreliminar
TareaPreliminar=TareaExcel
TareaExcel=TareaPersonalizar
TareaPersonalizar=(Fin)
