[Forma]
Clave=InvReciboTraspaso
Nombre=Herramienta - Recibo Traspaso
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=264
PosicionInicialArriba=253
PosicionInicialAlturaCliente=484
PosicionInicialAncho=751
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Iconos
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InvA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroUsuarios=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSituacionTodo=S
FiltroSucursales=S
FiltroListaEstatus=PENDIENTE
FiltroEstatusDefault=PENDIENTE
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=Inv.FechaEmision
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasCancelacion=Inv.FechaCancelacion
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Movimientos
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=InvA:Inv.Mov+<T> <T>+InvA:Inv.MovID
FiltroGeneral=Inv.Empresa=<T>{Empresa}<T> AND Inv.Estatus=<T>PENDIENTE<T> AND MovTipo.Clave=<T>INV.TI<T>

[Lista.Inv.FechaEmision]
Carpeta=Lista
Clave=Inv.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Inv.Referencia]
Carpeta=Lista
Clave=Inv.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Inv.Concepto]
Carpeta=Lista
Clave=Inv.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Inv.Almacen]
Carpeta=Lista
Clave=Inv.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Inv.AlmacenDestino]
Carpeta=Lista
Clave=Inv.AlmacenDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=135
1=79

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

[Acciones.LocalPropiedades]
Nombre=LocalPropiedades
Boton=0
NombreDesplegar=Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(InvA:Inv.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, InvA:Inv.ID)
Visible=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(InvA:Inv.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, InvA:Inv.ID)
Visible=S

[Acciones.Examinar]
Nombre=Examinar
Boton=57
NombreDesplegar=Examinar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=ReportePantalla(<T>INV<T>, InvA:Inv.ID)
EjecucionCondicion=ConDatos(InvA:Inv.ID)

[Acciones.LocalExaminar]
Nombre=LocalExaminar
Boton=0
NombreDesplegar=Examinar
EnMenu=S
TipoAccion=Expresion
Expresion=ReportePantalla(<T>INV<T>, InvA:Inv.ID)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(InvA:Inv.ID)
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

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
NombreDesplegar=Excel
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

[Acciones.Recibo]
Nombre=Recibo
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar Recibo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
Expresion=Si(RegistrarLista(LeerLista(<T><T>, <T>T*<T>, <T>TXT<T>, <T>Datos<T>, <T>Datos<T>), Verdadero), ProcesarSQL(<T>xpInvReciboTraspaso :tEmp, :tUsr, :nSuc, :nEstacion, :fFecha, :nID<T>,  Empresa, Usuario, Sucursal, EstacionTrabajo, FechaTrabajo, InvA:Inv.ID))
EjecucionCondicion=ConDatos(InvA:Inv.ID)

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

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Recibo
Recibo=Propiedades
Propiedades=Examinar
Examinar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=Actualizar Vista
Actualizar Vista=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Inv.FechaEmision
Inv.FechaEmision=Inv.Referencia
Inv.Referencia=Inv.Concepto
Inv.Concepto=Inv.Almacen
Inv.Almacen=Inv.AlmacenDestino
Inv.AlmacenDestino=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalPropiedades
LocalPropiedades=LocalExaminar
LocalExaminar=(Fin)
