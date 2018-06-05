[Forma]
Clave=MovMover
Nombre=Mover Movimientos (Operación / Histórico)
Icono=24
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=In
PosicionInicialIzquierda=269
PosicionInicialArriba=177
PosicionInicialAlturaCliente=633
PosicionInicialAncho=769
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=50
PosicionSeccion1=50
Comentarios=Lista(BaseDatos, BaseDatos(<T>Historico<T>))
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
ExpresionesAlMostrar=Si<BR>  BaseDatos(<T>Historico<T>)<><T><T><BR>Entonces<BR>  Si<BR>    SQL(<T>SELECT Version FROM Version<T>)<>SQL(<T>SELECT Version FROM <T>+BaseDatos(<T>Historico<T>)+<T>.dbo.Version<T>)<BR>  Entonces<BR>    Error(<T>Para Poder Usar Esta Herramienta Las Bases de Datos Deben Estar en la Misma Versión y Compilación<T>)<BR>    AbortarOperacion<BR>  Fin<BR>Sino<BR>  Precaucion(<T>Falta Configurar la BaseDatosHistorico en Intelisis.ini<T>) <BR>  AbortarOperacion<BR>Fin

[Lista.Columnas]
0=94
1=63

[In]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Base Datos - Operación
Clave=In
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovIn
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
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=Modulo
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=13
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroPeriodos=S
FiltroEjercicios=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroEmpresas=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
MenuLocal=S
ListaAcciones=(Lista)
IconosSeleccionMultiple=S
FiltroAplicaEn1=Modulo.Modulo
FiltroSucursales=S
IconosNombre=MovIn:MovIn.Mov

[In.MovIn.Conteo]
Carpeta=In
Clave=MovIn.Conteo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[In.Mes]
Carpeta=In
Clave=Mes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[In.Ano]
Carpeta=In
Clave=Ano
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[In.Columnas]
0=158
1=52

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

[Out]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Base Datos - Histórico
Clave=Out
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=MovOut
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
IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
OtroOrden=S
ListaOrden=(Lista)
IconosNombre=MovOut:MovOut.Mov

[Out.Mes]
Carpeta=Out
Clave=Mes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Out.Ano]
Carpeta=Out
Clave=Ano
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Out.Columnas]
0=202
1=55

[Out.MovOut.Conteo]
Carpeta=Out
Clave=MovOut.Conteo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.InMover]
Nombre=InMover
Boton=0
NombreDesplegar=&Mover Selección
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
RefrescarIconos=S
EnLote=S
EspacioPrevio=S
ConCondicion=S
Expresion=EjecutarSQLAnimado(<T>spMovMoverLote :nEstacion, :tEmpresa, :nSuc, :tModulo, :tMov, :nEjercicio, :nPeriodo, 1, :tBase, :tBaseHist<T>,  EstacionTrabajo, Empresa, MovIn:MovIn.Sucursal, MovIn:MovIn.Modulo, MovIn:MovIn.Mov, MovIn:MovIn.Ejercicio, MovIn:MovIn.Periodo, BaseDatos, BaseDatos(<T>Historico<T>))<BR>Forma.ActualizarVista(<T>Out<T>)
EjecucionCondicion=(MovIn:MovIn.Conteo>0) y (BaseDatos(<T>Historico<T>)<><T><T>)

[Acciones.InTodo]
Nombre=InTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.InQuitar]
Nombre=InQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[In.Modulo.Nombre]
Carpeta=In
Clave=Modulo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Out.Modulo.Nombre]
Carpeta=Out
Clave=Modulo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.OutTodo]
Nombre=OutTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.OutQuitar]
Nombre=OutQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.OutMover]
Nombre=OutMover
Boton=0
NombreDesplegar=&Mover Selección
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
EspacioPrevio=S
RefrescarIconos=S
EnLote=S
Expresion=EjecutarSQLAnimado(<T>spMovMoverLote :nEstacion, :tEmpresa, :nSuc, :tModulo, :tMov, :nEjercicio, :nPeriodo, 0, :tBase, :tBaseHist<T>, EstacionTrabajo, Empresa, MovOut:MovOut.Sucursal, MovOut:MovOut.Modulo, MovOut:MovOut.Mov, MovOut:MovOut.Ejercicio, MovOut:MovOut.Periodo, BaseDatos, BaseDatos(<T>Historico<T>))<BR>Forma.ActualizarVista(<T>In<T>)
EjecucionCondicion=MovOut:MovOut.Conteo>0

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=&Actualizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[In.MovIn.Sucursal]
Carpeta=In
Clave=MovIn.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Out.MovOut.Sucursal]
Carpeta=Out
Clave=MovOut.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=In
In=Out
Out=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Actualizar
Actualizar=(Fin)

[In.ListaEnCaptura]
(Inicio)=MovIn.Sucursal
MovIn.Sucursal=Modulo.Nombre
Modulo.Nombre=MovIn.Conteo
MovIn.Conteo=Mes
Mes=Ano
Ano=(Fin)

[In.ListaAcciones]
(Inicio)=InTodo
InTodo=InQuitar
InQuitar=InMover
InMover=(Fin)

[Out.ListaEnCaptura]
(Inicio)=MovOut.Sucursal
MovOut.Sucursal=Modulo.Nombre
Modulo.Nombre=MovOut.Conteo
MovOut.Conteo=Mes
Mes=Ano
Ano=(Fin)

[Out.ListaAcciones]
(Inicio)=OutTodo
OutTodo=OutQuitar
OutQuitar=OutMover
OutMover=(Fin)

[Out.ListaOrden]
(Inicio)=MovOut.Ejercicio<TAB>(Acendente)
MovOut.Ejercicio<TAB>(Acendente)=MovOut.Periodo<TAB>(Acendente)
MovOut.Periodo<TAB>(Acendente)=(Fin)
