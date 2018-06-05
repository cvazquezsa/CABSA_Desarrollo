[Forma]
Clave=PersonalPendientes
Nombre=Movimientos Pendientes de la Persona
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=153
PosicionInicialArriba=177
PosicionInicialAlturaCliente=379
PosicionInicialAncho=718
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Info.Personal

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaInfo
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Pendientes
MenuLocal=S
ListaAcciones=(Lista)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
Filtros=S
IconosNombre=NominaInfo:NominaInfo.Mov+<T> <T>+NominaInfo:NominaInfo.MovID
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=NominaInfo.Personal=<T>{Info.Personal}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.NominaInfo.FechaEmision]
Carpeta=Lista
Clave=NominaInfo.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=50

[Lista.NominaInfo.Condicion]
Carpeta=Lista
Clave=NominaInfo.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NominaInfo.CantidadPendiente]
Carpeta=Lista
Clave=NominaInfo.CantidadPendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NominaInfo.Importe]
Carpeta=Lista
Clave=NominaInfo.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.NominaInfo.Saldo]
Carpeta=Lista
Clave=NominaInfo.Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.Columnas]
0=165
1=102

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

[Lista.NominaInfo.Concepto]
Carpeta=Lista
Clave=NominaInfo.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
UsaTeclaRapida=S
TeclaRapida=F11
NombreDesplegar=Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>NOM<T>)<BR>Asigna(Info.ID, NominaInfo:NominaInfo.ID)
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Editar]
Nombre=Editar
Boton=61
NombreEnBoton=S
NombreDesplegar=&Editar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Multiple=S
ListaAccionesMultiples=Expresion<BR>Actualizar Forma
EjecucionCondicion=Si<BR>  (NominaInfo:NominaInfo.Estatus=EstatusProcesar) y<BR>  (Si(ConDatos(NominaInfo:NominaInfo.Importe), NominaInfo:NominaInfo.Importe=NominaInfo:NominaInfo.Saldo, NominaInfo:NominaInfo.Cantidad=NominaInfo:NominaInfo.CantidadPendiente))<BR>Entonces<BR>  Verdadero<BR>Sino<BR>  Informacion(<T>El movimiento indicado no se puede editar<T>)<BR>Fin

[Acciones.Editar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Si<BR>  ConDatos(NominaInfo:NominaInfo.Importe)<BR>Entonces<BR>  Asigna(Info.Importe, NominaInfo:NominaInfo.Importe)<BR>  Si(Forma(<T>EspecificarImporte<T>), EjecutarSQL(<T>spNominaEditarPorProcesar :nID, :nRenglon, NULL, :nImporte<T>, NominaInfo:NominaInfo.ID, NominaInfo:NominaInfo.Renglon, Info.Importe))<BR>Sino<BR>  Asigna(Info.Cantidad, NominaInfo:NominaInfo.Cantidad)<BR>  Si(Forma(<T>EspecificarCantidad<T>), EjecutarSQL(<T>spNominaEditarPorProcesar :nID, :nRenglon, :nCantidad, NULL<T>, NominaInfo:NominaInfo.ID, NominaInfo:NominaInfo.Renglon, Info.Cantidad))<BR>Fin
Activo=S
Visible=S

[Acciones.Editar.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


[Lista.ListaEnCaptura]
(Inicio)=NominaInfo.Concepto
NominaInfo.Concepto=NominaInfo.FechaEmision
NominaInfo.FechaEmision=NominaInfo.Condicion
NominaInfo.Condicion=NominaInfo.Importe
NominaInfo.Importe=NominaInfo.CantidadPendiente
NominaInfo.CantidadPendiente=NominaInfo.Saldo
NominaInfo.Saldo=(Fin)

[Lista.ListaAcciones]
(Inicio)=Propiedades
Propiedades=Personalizar
Personalizar=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PROCESAR
PROCESAR=VIGENTE
VIGENTE=(Fin)













[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Editar
Editar=(Fin)
