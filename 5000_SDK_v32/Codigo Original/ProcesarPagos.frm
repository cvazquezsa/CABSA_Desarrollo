[Forma]
Clave=ProcesarPagos
Nombre=Pagos Automáticos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=154
PosicionInicialArriba=149
PosicionInicialAltura=470
PosicionInicialAncho=715
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Prov
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Prov.Nombre
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ProvCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ProvFam
FiltroAplicaEn1=Prov.Categoria
FiltroAplicaEn2=Prov.Familia
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroAncho=20
FiltroListas=S
FiltroListasRama=CXP
FiltroListasAplicaEn=Prov.Proveedor
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroArbol=Proveedores
FiltroArbolAplica=Prov.Rama
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
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Proveedores
IconosSubTitulo=<T>Proveedor<T>
IconosSeleccionMultiple=S
MenuLocal=S
PermiteLocalizar=S
IconosNombre=Prov:Prov.Proveedor
ListaAcciones=(Lista)

[Lista.Prov.Nombre]
Carpeta=Lista
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=114
1=347

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

[Acciones.GenerarPagos]
Nombre=GenerarPagos
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar Pagos
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Si<BR>  Forma(<T>EspecificarVencimiento<T>)<BR>Entonces<BR>  RegistrarSeleccion(<T>Lista<T>)<BR>  ProcesarSQL(<T>spGenerarPagos :nEstacion, :tEmp, :nSuc, :tUsu, :tMov, :fVence<T>, EstacionTrabajo , Empresa, Sucursal, Usuario, ConfigMov.CxpPago, Info.Fecha)<BR>Fin

[Acciones.LocalSeleccionarTodo]
Nombre=LocalSeleccionarTodo
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.LocalQuitarSeleccion]
Nombre=LocalQuitarSeleccion
Boton=0
NombreDesplegar=Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=GenerarPagos
GenerarPagos=Personalizar
Personalizar=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalSeleccionarTodo
LocalSeleccionarTodo=LocalQuitarSeleccion
LocalQuitarSeleccion=(Fin)
