[Forma]
Clave=POSCteLista
Nombre=Clientes
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=251
PosicionInicialArriba=41
PosicionInicialAltura=477
PosicionInicialAncho=863
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
MovModulo=CXC
PosicionInicialAlturaCliente=606
Comentarios=Si(no Usuario.ConsultarClientesOtrosAgentes, e(<T>Agente<T>)+<T>: <T>+Usuario.DefAgente)
PosicionSec1=300
PosicionCol1=430
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
[Lista]
Estilo=Hoja
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteA
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
Filtros=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CteCat
FiltroPredefinido=S
FiltroAplicaEn=Cte.Categoria
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroNullNombre=(sin categoría)
FiltroRespetar=S
FiltroAncho=20
FiltroFechasNormal=S
FiltroListas=S
FiltroListasRama=CXC
FiltroListasAplicaEn=Cte.Cliente
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CteFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CteGrupo
FiltroAplicaEn1=Cte.Categoria
FiltroAplicaEn2=Cte.Familia
FiltroAplicaEn3=Cte.Grupo
PermiteLocalizar=S
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroArbol=Clientes
FiltroArbolAplica=Cte.Rama
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=Agente
FiltroAplicaEn4=Cte.Agente
FiltroSituacion=S
FiltroSituacionTodo=S
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=CteTipo
FiltroAplicaEn5=Cte.Tipo
FiltroGrupo6=(Validaciones Memoria)
FiltroValida6=Espacio
FiltroAplicaEn6=Cte.Espacio
OtroOrden=S
ListaOrden=Cte.Cliente<TAB>(Acendente)

MenuLocal=S
ListaAcciones=Expresion
FiltroGeneral=Cte.Tipo<><T>Estructura<T><BR>{Si(no Usuario.ConsultarClientesOtrosAgentes, <T> AND Cte.Agente=<T>+Comillas(Usuario.DefAgente), <T><T>)}
[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[Lista.Columnas]
Cliente=117
Nombre=293
0=121
1=280
RFC=107

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreDesplegar=&Seleccionar
TipoAccion=Controles Captura
Visible=S
Activo=S
NombreEnBoton=S
EnBarraHerramientas=S
ClaveAccion=Variables Asignar / Ventana Aceptar
Antes=S
AntesExpresiones=EjecutarSQL(<T>spPOSAccionReferenciaPedido :tEmpresa, :nSucursal, :tUsuario, :nEstacion,  :tIDPOS<T>,Empresa, Sucursal, Usuario, EstacionTrabajo,  Info.IDTexto)<BR>Asigna(Info.Cliente,CteA:Cte.Cliente)
[Lista.Cte.Cliente]
Carpeta=Lista
Clave=Cte.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Cte.RFC]
Carpeta=Lista
Clave=Cte.RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Art.Art.Articulo]
Carpeta=Art
Clave=Art.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Art.Art.Descripcion1]
Carpeta=Art
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Art.Columnas]
Articulo=124
Descripcion1=184




[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=POSCxcPendiente
POSCxcPendiente=(Fin)


[Acciones.Seleccionar.POSCxcPendiente]
Nombre=POSCxcPendiente
Boton=0
TipoAccion=Formas
ClaveAccion=POSCxcPendiente
Activo=S
Visible=S


[Acciones.Seleccionar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Acciones.Seleccionar.ListaAccionesMultiples]
(Inicio)=POSCxcPendiente
POSCxcPendiente=Aceptar
Aceptar=(Fin)


[Acciones.Expresion]
Nombre=Expresion
Boton=0
NombreDesplegar=Seleccionar
EnMenu=S
TipoAccion=Ventana
Activo=S
Visible=S







ClaveAccion=Seleccionar/Aceptar
Antes=S
AntesExpresiones=EjecutarSQL(<T>spPOSAccionReferenciaPedido :tEmpresa, :nSucursal, :tUsuario, :nEstacion,  :tIDPOS<T>,Empresa, Sucursal, Usuario, EstacionTrabajo,  Info.IDTexto)<BR>Asigna(Info.Cliente,CteA:Cte.Cliente)
[Acciones.Expresion.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spPOSAccionReferenciaPedido :tEmpresa, :nSucursal, :tUsuario, :nEstacion,  :tIDPOS<T>,Empresa, Sucursal, Usuario, EstacionTrabajo,  Info.IDTexto)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, NULO, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, CteA:Cte.Cliente))<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR><BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])
[Acciones.Expresion.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Seleccionar/Aceptar
Activo=S
Visible=S









[Acciones.Expresion.ListaAccionesMultiples]
(Inicio)=Aceptar
Aceptar=Expresion
Expresion=(Fin)



[Acciones.Seleccionar.ListaAccionesMultiples]
(Inicio)=Aceptar
Aceptar=Expresion
Expresion=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Cte.Cliente
Cte.Cliente=Cte.Nombre
Cte.Nombre=Cte.RFC
Cte.RFC=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQ_AVISO
BLOQ_AVISO=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)
