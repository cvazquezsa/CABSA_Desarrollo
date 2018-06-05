[Forma]
Clave=MovRecurrente
Nombre=Movimientos Recurrentes
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=249
PosicionInicialArriba=246
PosicionInicialAlturaCliente=504
PosicionInicialAncho=782
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovRecurrente
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
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Movimientos
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin vencimiento)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSituacionTodo=S
FiltroProyectos=S
FiltroUENs=S
FiltroUENsCampo=MovRecurrente.UEN
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=MovRecurrente.Vencimiento
FiltroFechasDefault=Este Mes
FiltroFechasNombre=&Vencimiento
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
IconosSeleccionMultiple=S
FiltroGrupo1=MovRecurrente.Mov
FiltroTodo=S
FiltroFechasVencimiento=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=MovRecurrente:MovRecurrente.Mov+<T> <T>+MovRecurrente:MovRecurrente.MovID
FiltroGeneral=MovRecurrente.Empresa=<T>{Empresa}<T> AND MovRecurrente.Vencimiento IS NOT NULL

[Lista.MovRecurrente.Contacto]
Carpeta=Lista
Clave=MovRecurrente.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovRecurrente.Nombre]
Carpeta=Lista
Clave=MovRecurrente.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovRecurrente.Importe]
Carpeta=Lista
Clave=MovRecurrente.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=0

[Lista.Columnas]
0=152
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

[Lista.MovRecurrente.Moneda]
Carpeta=Lista
Clave=MovRecurrente.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Todo]
Nombre=Todo
Boton=55
NombreEnBoton=S
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S
EspacioPrevio=S

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

[Acciones.LocalTodo]
Nombre=LocalTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.LocalQuitar]
Nombre=LocalQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar Movimientos
EnBarraHerramientas=S
TipoAccion=Controles Captura
Activo=S
Visible=S
Antes=S
ClaveAccion=Refrescar Controles
Carpeta=(Carpeta principal)
Multiple=S
ListaAccionesMultiples=Actualizar Arbol<BR>Actualizar Vista
AntesExpresiones=RegistrarSeleccionModuloID(<T>Lista<T>, <T>MovRecurrente.Modulo<T>, <T>MovRecurrente.ID<T>)<BR>ProcesarSQL(<T>spMovRecurrenteGenerar :tEmp, :nSuc, :tUsr, :nEstacion, :fFecha<T>, Empresa, Sucursal, Usuario, EstacionTrabajo, FechaTrabajo)

[Lista.MovRecurrente.Vencimiento]
Carpeta=Lista
Clave=MovRecurrente.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Generar.Actualizar Arbol]
Nombre=Actualizar Arbol
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S

[Acciones.Generar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Todo
Todo=Generar
Generar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=MovRecurrente.Vencimiento
MovRecurrente.Vencimiento=MovRecurrente.Contacto
MovRecurrente.Contacto=MovRecurrente.Nombre
MovRecurrente.Nombre=MovRecurrente.Importe
MovRecurrente.Importe=MovRecurrente.Moneda
MovRecurrente.Moneda=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)
