
[Forma]
Clave=POSHerrCancelacionVale
Icono=0
CarpetaPrincipal=POSHerrCancelacionVale
Modulos=(Todos)
Nombre=Herramienta Cancelación Monedero
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=POSHerrCancelacionVale
PosicionInicialIzquierda=276
PosicionInicialArriba=102
PosicionInicialAlturaCliente=484
PosicionInicialAncho=814
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[POSHerrCancelacionVale]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Monederos
Clave=POSHerrCancelacionVale
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSHerrCancelacionVale
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Cliente<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
IconosSeleccionMultiple=S

MenuLocal=S
ListaAcciones=(Lista)
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
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CteCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CteFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CteGrupo
FiltroAplicaEn1=Cte.Categoria
FiltroAplicaEn2=Cte.Familia
FiltroAplicaEn3=Cte.Grupo
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroArbol=Clientes
FiltroArbolAplica=Cte.Rama
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=Agente
FiltroAplicaEn4=Cte.Agente
IconosNombre=POSHerrCancelacionVale:POSHerrCancelacionVale.Cliente
FiltroGeneral=POSHerrCancelacionVale.Estacion = {EstacionTrabajo}
[POSHerrCancelacionVale.Cte.Nombre]
Carpeta=POSHerrCancelacionVale
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[POSHerrCancelacionVale.POSHerrCancelacionVale.Monedero]
Carpeta=POSHerrCancelacionVale
Clave=POSHerrCancelacionVale.Monedero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSHerrCancelacionVale.POSHerrCancelacionVale.FechaVigencia]
Carpeta=POSHerrCancelacionVale
Clave=POSHerrCancelacionVale.FechaVigencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSHerrCancelacionVale.Saldo]
Carpeta=POSHerrCancelacionVale
Clave=Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSHerrCancelacionVale.Columnas]
0=-2
1=213
2=169
3=181
4=-2


[Acciones.Expresion]
Nombre=Expresion
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S




















EspacioPrevio=S
Expresion=Si<BR>  CuantosSeleccionID(<T>POSHerrCancelacionVale<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>POSHerrCancelacionVale<T>)<BR>  ProcesarSQL(<T>spPOSHerrCancelarVale  :nEstacion,:tEmpresa,:tUsuario,:nSucursa<T>, EstacionTrabajo,Empresa,Usuario,Sucursal)<BR>  ActualizarForma<BR>Fin
[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S






















[POSHerrCancelacionVale.ListaEnCaptura]
(Inicio)=Cte.Nombre
Cte.Nombre=POSHerrCancelacionVale.Monedero
POSHerrCancelacionVale.Monedero=POSHerrCancelacionVale.FechaVigencia
POSHerrCancelacionVale.FechaVigencia=Saldo
Saldo=(Fin)

[POSHerrCancelacionVale.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=(Fin)

















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Expresion
Expresion=(Fin)
