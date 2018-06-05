



[Forma]
Clave=WMSMontacargaTarea
Icono=0
Modulos=(Todos)

ListaCarpetas=(Lista)
CarpetaPrincipal=Iconos
PosicionInicialAlturaCliente=598
PosicionInicialAncho=1204

VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=112
PosicionInicialArriba=66
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Nombre=Tareas Acomodador
EsMovimiento=S
TituloAuto=S
MovModulo=TMA
;MovimientosValidos=(Lista)
MovimientosValidos=(Lista)
;ListaAcciones=(Lista)
ListaAcciones=(Lista)


Menus=S
SinTransacciones=S
ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spWMSMontacargaTarea :nEstacionTrabajo, 0<T>, EstacionTrabajo)<BR>Asigna(Info.OrigenTipo, nulo)<BR>Asigna(Info.Origen, nulo)<BR>Asigna(Info.OrigenID, nulo)<BR>Asigna(Info.Cliente, nulo)    <BR>Asigna(Temp.Logico, Verdadero)<BR>ActualizarForma
MenuPrincipal=&Archivo
[Iconos]
Estilo=Iconos
Clave=Iconos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WMSMontacargaTarea
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
;ListaEnCaptura=(Lista)
ListaEnCaptura=(Lista)
CarpetaVisible=S

FiltroPredefinido2=
FiltroPredefinido1=
IconosSeleccionMultiple=S
Filtros=S
BusquedaRapidaControles=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroFechas=S
FiltroFechasCampo=WMSMontacargaTarea.FechaEmision
FiltroGrupo1=WMSMontacargaTarea.Almacen
FiltroGrupo2=WMSMontacargaTarea.Prioridad
PestanaOtroNombre=S
FiltroTodo=S
FiltroGrupo3=WMSMontacargaTarea.Montacarga
FiltroMovs=S
IconosNombreNumerico=S
FiltroValida1=WMSMontacargaTarea.Almacen
FiltroValida2=WMSMontacargaTarea.Prioridad
FiltroValida3=WMSMontacargaTarea.Montacarga
MenuLocal=S
;ListaAcciones=(Lista)
ListaAcciones=(Lista)
BusquedaRapida=S
BusquedaEnLinea=S
FiltroEmpresas=S
FiltroSucursales=S
FiltroSucursalesTodasPorOmision=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaRespetarControles=S
IconosSubTitulo=<T>Movimiento<T>
;FiltroMovsTodos=S
FiltroFechasDefault=Hoy
OtroOrden=S
ListaOrden=WMSMontacargaTarea.Pasillo<TAB>(Acendente)

FiltroMovDefault=(Todos)
FiltroMovsTodos=S
Pestana=S
PestanaNombre=Detalle
RefrescarAlEntrar=S
ExpAlRefrescar=Asigna(Temp.Logico, Verdadero)
IconosNombre=WMSMontacargaTarea:WMSMontacargaTarea.Movimiento
FiltroGeneral=WMSMontacargaTarea.Estacion = {EstacionTrabajo}<BR>{Si(ConDatos(Info.OrigenTipo), <T> AND TMA.OrigenTipo = <T>+Comillas(Info.OrigenTipo), <T><T>)}<BR>{Si(ConDatos(Info.Origen), <T> AND TMA.Origen = <T>+Comillas(Info.Origen), <T><T>)}<BR>{Si(ConDatos(Info.OrigenID), <T> AND TMA.OrigenID = <T>+Comillas(Info.OrigenID), <T><T>)}
[Iconos.WMSMontacargaTarea.FechaEmision]
Carpeta=Iconos
Clave=WMSMontacargaTarea.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=50
[Iconos.WMSMontacargaTarea.Tarima]
Carpeta=Iconos
Clave=WMSMontacargaTarea.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Iconos.WMSMontacargaTarea.Sucursal]
Carpeta=Iconos
Clave=WMSMontacargaTarea.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Iconos.WMSMontacargaTarea.NomSucursal]
Carpeta=Iconos
Clave=WMSMontacargaTarea.NomSucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Iconos.WMSMontacargaTarea.Pasillo]
Carpeta=Iconos
Clave=WMSMontacargaTarea.Pasillo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Iconos.WMSMontacargaTarea.PosicionOrigen]
Carpeta=Iconos
Clave=WMSMontacargaTarea.PosicionOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Iconos.WMSMontacargaTarea.PosicionDestino]
Carpeta=Iconos
Clave=WMSMontacargaTarea.PosicionDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Iconos.WMSMontacargaTarea.Articulo]
Carpeta=Iconos
Clave=WMSMontacargaTarea.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Iconos.WMSMontacargaTarea.Montacarga]
Carpeta=Iconos
Clave=WMSMontacargaTarea.Montacarga
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Iconos.WMSMontacargaTarea.Prioridad]
Carpeta=Iconos
Clave=WMSMontacargaTarea.Prioridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Iconos.WMSMontacargaTarea.Almacen]
Carpeta=Iconos
Clave=WMSMontacargaTarea.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Iconos.Columnas]
0=158
1=156
2=-2
3=-2
4=52
5=77
6=130
7=80
8=64
9=100
10=107
11=95
12=-2
13=103











14=-2





































































15=-2
16=-2
[Acciones.Sugerir]
Nombre=Sugerir
Boton=92
EnBarraHerramientas=S
TipoAccion=Formas



NombreEnBoton=S
NombreDesplegar=&Sugerir

Visible=S
EspacioPrevio=S
ClaveAccion=EspecificarSugerirWMS
Multiple=S
ListaAccionesMultiples=(Lista)
ConCondicion=S
EjecucionConError=S
ActivoCondicion=Temp.Logico=Verdadero
EjecucionCondicion=Temp.Logico=Verdadero
EjecucionMensaje=<T>Esta acción debe darse a nivel Detalle<T>
[Acciones.Montacarguista]
Nombre=Montacarguista
Boton=7
NombreDesplegar=&Asignar Acomodador
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EspecificarMontacargista
Multiple=S
;ListaAccionesMultiples=(Lista)
ListaAccionesMultiples=Expresion


Activo=S
Visible=S
[Acciones.DetallePCK.Detalle]
Nombre=Detalle
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=RegistrarSeleccionID<BR>Forma(<T>EspSSFAWMSDetallePicking<T>)
[Acciones.Seleccion]
Nombre=Seleccion
Boton=0
NombreEnBoton=S
NombreDesplegar=&Seleccionar Todo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S


EspacioPrevio=S
[Acciones.Quitar]
Nombre=Quitar
Boton=0
NombreEnBoton=S
NombreDesplegar=&Quitar Seleccion
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S


EspacioPrevio=S
[Acciones.Prioridad]
Nombre=Prioridad
Boton=58
NombreEnBoton=S
NombreDesplegar=&Prioridad
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EspecificarPrioridad
Visible=S

Multiple=S
;ListaAccionesMultiples=(Lista)
ListaAccionesMultiples=(Lista)

EspacioPrevio=S

ActivoCondicion=Temp.Logico=Verdadero
[Acciones.Montacarguista.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Si Temp.Logico=Verdadero<BR>Entonces<BR>    RegistrarSeleccionID<BR>    Si<BR>      SQL(<T>SELECT COUNT(*) FROM ListaID WHERE Estacion=:nEstacion<T>, EstacionTrabajo)>0<BR>    Entonces<BR>      Forma(<T>EspecificarMontacargista<T>)<BR>      Asigna(Info.Descripcion, SQL(<T>EXEC spWMSActualizarMontacargista :nEstacion, :tMontacargista, :tEmpresa<T>, EstacionTrabajo, info.Montacarga, Empresa))<BR><BR>      Caso Info.Descripcion<BR>        Es <T><T> Entonces ActualizarForma<BR>      Sino<BR>        Si Info.Montacarga<><T><T><BR>        Entonces<BR>          Informacion(Info.Descripcion)<BR>          Forma(<T>EspecificarMontacargista<T>)<BR>       Fin<BR>      Fin<BR>    Sino<BR>      Informacion(<T>Favor de Seleccionar un Movimiento<T>)<BR>    Fin<BR>    Asigna(Temp.Logico, Verdadero)<BR>Sino<BR>   //RegistrarSeleccionID<BR>    RegistrarListaSt(<T>Agrupado<T>, <T>Guia<T>, RegistrarSeleccion(<T>WMSMontacargaTareaAgrupado<T>))<BR>    EjecutarSQL(<T>EXEC spMontacargaListST :nEstacion<T>,  EstacionTrabajo)<BR><BR>     Si<BR>      SQL(<T>SELECT COUNT(*) FROM ListaID WHERE Estacion=:nEstacion<T>, EstacionTrabajo)>0<BR>    Entonces<BR>      Forma(<T>EspecificarMontacargista<T>)<BR>      Asigna(Info.Descripcion, SQL(<T>EXEC spWMSActualizarMontacargista :nEstacion, :tMontacargista, :tEmpresa<T>, EstacionTrabajo, info.Montacarga, Empresa))<BR><BR>      Caso Info.Descripcion<BR>        Es <T><T> Entonces ActualizarForma<BR>      Sino<BR>        Si Info.Montacarga<><T><T><BR>        Entonces<BR>          Informacion(Info.Descripcion)<BR>          Forma(<T>EspecificarMontacargista<T>)<BR>       Fin<BR>      Fin<BR>    Sino<BR>      Informacion(<T>Favor de Seleccionar un Movimiento<T>)<BR>    Fin<BR>Fin
[Acciones.Prioridad.Prioridad]
Nombre=Prioridad
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=RegistrarSeleccionID<BR>Si<BR>  SQL(<T>SELECT COUNT(*) FROM ListaID WHERE Estacion=:nEstacion<T>, EstacionTrabajo)=0<BR>Entonces<BR>  Informacion(<T>Favor de Seleccionar un Movimiento<T>)<BR>Sino<BR>  Forma(<T>EspecificarPrioridad<T>)<BR>Fin
[Acciones.Prioridad.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S






Expresion=EjecutarSQL(<T>EXEC spWMSActualizarPrioridad :nEstacion, :tMontacargista<T>, EstacionTrabajo,   info.PrioridadWMS)<BR>ActualizarForma
[Iconos.Art.Descripcion1]
Carpeta=Iconos
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Iconos.Agente.Nombre]
Carpeta=Iconos
Clave=Agente.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco












[Acciones.Todos1]
Nombre=Todos1
Boton=0
NombreDesplegar=Filtrar Todo
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=EjecutarSQL(<T>EXEC spWMSMontacargaTarea :nEstacionTrabajo, 1<T>, EstacionTrabajo)<BR>ActualizarForma
[Acciones.Sugerir1]
Nombre=Sugerir1
Boton=0
NombreDesplegar=&Sugerir
EnMenu=S
TipoAccion=Expresion
Activo=S









Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=0
NombreDesplegar=Seleccionar Todos
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S




[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S






















[Acciones.Todos2]
Nombre=Todos2
Boton=0
NombreDesplegar=&Todos
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S



NombreEnBoton=S
Expresion=EjecutarSQL(<T>EXEC spWMSMontacargaTarea :nEstacionTrabajo, 1<T>, EstacionTrabajo)<BR>ActualizarForma
VisibleCondicion=1=2
[Acciones.Todos]
Nombre=Todos
Boton=107
NombreEnBoton=S
NombreDesplegar=Filtrar Todos
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S






EspacioPrevio=S
Expresion=EjecutarSQL(<T>EXEC spWMSMontacargaTarea :nEstacionTrabajo, 1<T>, EstacionTrabajo)<BR>ActualizarForma
[Acciones.Posicion.EspecificarAlmacen]
Nombre=EspecificarAlmacen
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Almacen, WMSMontacargaTarea:WMSMontacargaTarea.Almacen)<BR>Asigna(Info.Tipo, <T>Surtido<T>)<BR>//Informacion(Info.Almacen)
[Acciones.Posicion.spWMSActualizarPosicionSurtido]
Nombre=spWMSActualizarPosicionSurtido
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si Forma(<T>EspecificarPosicion<T>)<BR>Entonces<BR>  RegistrarSeleccionID<BR>  EjecutarSQL(<T>spWMSActualizarPosicionSurtido :tPosicion, :nEstacion<T>,Info.Posicion, EstacionTrabajo)<BR>Fin<BR>ActualizarForma
[Acciones.Posicion]
Nombre=Posicion
Boton=100
NombreEnBoton=S
NombreDesplegar=Posición Surtido
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)






EspacioPrevio=S
[Acciones.Asignar]
Nombre=Asignar
Boton=7
NombreEnBoton=S
NombreDesplegar=Asignar Acomodador y Posición
EnBarraHerramientas=S
TipoAccion=Expresion



Expresion=RegistrarSeleccionID<BR>Asigna(Info.Almacen, WMSMontacargaTarea:WMSMontacargaTarea.Almacen)<BR>Asigna(Info.Tipo, <T>Surtido<T>)<BR><BR>Si Forma(<T>EspecificarMontacargistaPosicion<T>)<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spWMSActualizarMontacargista :nEstacion, :tMontacargista, :tEmpresa<T>, EstacionTrabajo, info.Montacarga, Empresa)<BR>  EjecutarSQL(<T>spWMSActualizarPosicionSurtido :tPosicion, :nEstacion<T>,Info.Posicion, EstacionTrabajo)<BR><BR>  EjecutarSQL(<T>EXEC spWMSActualizarMontacargaTarea :nEstacionTrabajo<T>, EstacionTrabajo)<BR>  EjecutarSQL(<T>EXEC spWMSMontacargaTarea :nEstacionTrabajo, 0<T>, EstacionTrabajo)<BR>Fin<BR><BR>ActualizarForma
[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreEnBoton=S
NombreDesplegar=&Actualizar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S



Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F5
EnMenu=S
EspacioPrevio=S














Expresion=EjecutarSQL(<T>EXEC spWMSMontacargaTarea :nEstacionTrabajo, 0<T>, EstacionTrabajo)<BR>ActualizarVista<BR>ActualizarForma
[Acciones.PersonalizarVista]
Nombre=PersonalizarVista
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

EspacioPrevio=S








[Lista.Columnas]
0=105
1=247







































Posicion=89
Tipo=106
ArticuloEsp=73
Pasillo=45
Nivel=37
Zona=64
Descripcion=159
Estatus=54
Descrpcion=181
PosicionDestino=81
Movimiento=126
Origenc=137
Tarima=124
[Iconos.WMSMontacargaTarea.NoCajas]
Carpeta=Iconos
Clave=WMSMontacargaTarea.NoCajas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1





[Acciones.Sugerir.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S




[Acciones.Sugerir1.Sugerir2]
Nombre=Sugerir2
Boton=0
TipoAccion=Formas
ClaveAccion=EspecificarSugerirWMS
Activo=S
Visible=S







[Acciones.Sugerir1.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Controles Captura
Activo=S
Visible=S




[Acciones.Sugerir.Registrar]
Nombre=Registrar
Boton=0
TipoAccion=expresion
Activo=S
Visible=S






Expresion=RegistrarSeleccionID<BR>Si<BR>  SQL(<T>SELECT COUNT(*) FROM ListaID WHERE Estacion=:nEstacion<T>, EstacionTrabajo)=0<BR>Entonces<BR>  Informacion(<T>Favor de Seleccionar un Movimiento<T>)<BR>Sino<BR>  Forma(<T>EspecificarSugerirWMS<T>)<BR>Fin
[Acciones.Sugerir1.Registrar]
Nombre=Registrar
Boton=0
TipoAccion=Expresion
Expresion=RegistrarSeleccionID
Activo=S
Visible=S






[Acciones.Sugerir1.ListaAccionesMultiples]
(Inicio)=Registrar
Registrar=Sugerir2
Sugerir2=Actualizar
Actualizar=(Fin)








[Acciones.Montacarguista.ListaAccionesMultiples]
(Inicio)=Registrar
Registrar=Expresion
Expresion=(Fin)






























































































































[Iconos.WMSMontacargaTarea.Zona]
Carpeta=Iconos
Clave=WMSMontacargaTarea.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

























































[Iconos.Origenc]
Carpeta=Iconos
Clave=Origenc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco























[Acciones.OrdenesPendientes.Forma]
Nombre=Forma
Boton=0
TipoAccion=Formas
ClaveAccion=WMSValidaPCKLista
Activo=S
Visible=S

[Acciones.OrdenesPendientes]
Nombre=OrdenesPendientes
Boton=65
NombreEnBoton=S
NombreDesplegar=&Ordenes PCK Pendientes
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)









ActivoCondicion=Temp.Logico=Verdadero
VisibleCondicion=(MovTipoEn(<T>TMA<T>,WMSMontacargaTarea:WMSMontacargaTarea.Mov, (TMA.OSUR)) y (Temp.Logico=Verdadero))
[Acciones.OrdenesPendientes.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.Tarima, WMSMontacargaTarea:WMSMontacargaTarea.Tarima)
Activo=S
Visible=S

[Acciones.OrdenesPendientes.Variables]
Nombre=Variables
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S














[Agrupado]
Estilo=Iconos
Pestana=S
Clave=Agrupado
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WMSMontacargaTareaAgrupado
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

IconosSubTitulo=<T>Movimiento<T>


ListaEnCaptura=(Lista)


Filtros=S
BusquedaRapidaControles=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
PestanaOtroNombre=S
PestanaNombre=Consolidado
FiltroGrupo1=Almacen
FiltroValida1=Almacen
FiltroTodo=S
BusquedaRapida=S
BusquedaEnLinea=S
FiltroEmpresas=S
FiltroSucursales=S
FiltroSucursalesTodasPorOmision=S
BusquedaInicializar=S
BusquedaRespetarControles=S






IconosSeleccionMultiple=S
RefrescarAlEntrar=S
ExpAlRefrescar=Asigna(Temp.Logico, Falso)
MenuLocal=S
IconosNombre=WMSMontacargaTareaAgrupado:Mov
FiltroGeneral=1=1<BR>{Si(ConDatos(Info.Cliente), <T> AND Cuenta = <T>+Comillas(Info.Cliente), <T><T>)}
ListaAcciones=EnviarExcelAgrupado
[Agrupado.Columnas]
0=136
1=62
2=-2
3=-2
4=-2
5=-2
6=-2




7=-2
8=-2
9=-2
10=-2
11=123
12=105


13=-2

[Agrupado.Almacen]
Carpeta=Agrupado
Clave=Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Agrupado.Tarima]
Carpeta=Agrupado
Clave=Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Agrupado.NoCajas]
Carpeta=Agrupado
Clave=NoCajas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Agrupado.Sucursal]
Carpeta=Agrupado
Clave=Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Agrupado.NomSucursal]
Carpeta=Agrupado
Clave=NomSucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Agrupado.Pasillo]
Carpeta=Agrupado
Clave=Pasillo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Agrupado.PosicionOrigen]
Carpeta=Agrupado
Clave=PosicionOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Agrupado.PosicionDestino]
Carpeta=Agrupado
Clave=PosicionDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Agrupado.Articulo]
Carpeta=Agrupado
Clave=Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Agrupado.Descripcion1]
Carpeta=Agrupado
Clave=Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Agrupado.Montacarga]
Carpeta=Agrupado
Clave=Montacarga
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




















[Acciones.Prioridad.ListaAccionesMultiples]
(Inicio)=Prioridad
Prioridad=Expresion
Expresion=(Fin)








[Acciones.Posicion.ListaAccionesMultiples]
(Inicio)=EspecificarAlmacen
EspecificarAlmacen=spWMSActualizarPosicionSurtido
spWMSActualizarPosicionSurtido=(Fin)



























[Acciones.PosicionDestino]
Nombre=PosicionDestino
Boton=0
NombreDesplegar=Asignar Posición Destino
Multiple=S
EnMenu=S






Visible=S





ListaAccionesMultiples=(Lista)





ActivoCondicion=No ConDatos(WMSMontacargaTarea.PosicionDestino)
[Acciones.PosicionDestino.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
































Expresion=Asigna(Info.Almacen, WMSMontacargaTarea:WMSMontacargaTarea.Almacen)<BR>Asigna(Info.Articulo, WMSMontacargaTarea:WMSMontacargaTarea.Articulo)<BR>Asigna(Info.Numero, WMSMontacargaTarea:WMSMontacargaTarea.IDLista)                                               <BR>FormaModal(<T>WMSPosicionDestino<T>)<BR>Asigna(Temp.Logico,Verdadero)


[Acciones.PosicionDestino.ActualizarVista]
Nombre=ActualizarVista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.PosicionDestino.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=ActualizarVista
ActualizarVista=(Fin)



































































































































[Acciones.FiltroOrigen]
Nombre=FiltroOrigen
Boton=20
NombreEnBoton=S
NombreDesplegar=&Filtro Origen
EnBarraHerramientas=S
EnMenu=S
Activo=S
Visible=S







TipoAccion=Formas
ClaveAccion=EspecificarOrigen































ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Temp.Logico=Verdadero
EjecucionMensaje=<T>Imposible Filtar Origen a Nivel Consolidado<T>
[Agrupado.Cuenta]
Carpeta=Agrupado
Clave=Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[Acciones.Sugerir.ListaAccionesMultiples]
(Inicio)=Registrar
Registrar=Actualizar
Actualizar=(Fin)



















[Acciones.FiltrarCliente]
Nombre=FiltrarCliente
Boton=81
NombreEnBoton=S
NombreDesplegar=&Filtrar Cliente
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EspecificarCliente
Activo=S
Visible=S







ConCondicion=S
EjecucionConError=S






RefrescarDespues=S
EjecucionCondicion=Temp.Logico=Falso
EjecucionMensaje=<T>Imposible Filtrar Cliente a Nivel Detalle<T>
[Acciones.OrdenesPendientes.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Variables
Variables=Forma
Forma=(Fin)
















[Acciones.EnviarExcelIconos]
Nombre=EnviarExcelIconos
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=Iconos
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Visible=S



GuardarAntes=S



ActivoCondicion=ConDatos(WMSMontacargaTarea.ID)
[Acciones.EnviarExcelAgrupado]
Nombre=EnviarExcelAgrupado
Boton=0
NombreDesplegar=Enviar a Excel
GuardarAntes=S
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Visible=S
ActivoCondicion=ConDatos(WMSMontacargaTarea.ID)

[Agrupado.ListaEnCaptura]
(Inicio)=Almacen
Almacen=Tarima
Tarima=NoCajas
NoCajas=Sucursal
Sucursal=NomSucursal
NomSucursal=Pasillo
Pasillo=PosicionOrigen
PosicionOrigen=PosicionDestino
PosicionDestino=Articulo
Articulo=Descripcion1
Descripcion1=Montacarga
Montacarga=Cuenta
Cuenta=(Fin)











[Iconos.ListaEnCaptura]
(Inicio)=Origenc
Origenc=WMSMontacargaTarea.FechaEmision
WMSMontacargaTarea.FechaEmision=WMSMontacargaTarea.Almacen
WMSMontacargaTarea.Almacen=WMSMontacargaTarea.Tarima
WMSMontacargaTarea.Tarima=WMSMontacargaTarea.NoCajas
WMSMontacargaTarea.NoCajas=WMSMontacargaTarea.Sucursal
WMSMontacargaTarea.Sucursal=WMSMontacargaTarea.NomSucursal
WMSMontacargaTarea.NomSucursal=WMSMontacargaTarea.Pasillo
WMSMontacargaTarea.Pasillo=WMSMontacargaTarea.PosicionOrigen
WMSMontacargaTarea.PosicionOrigen=WMSMontacargaTarea.PosicionDestino
WMSMontacargaTarea.PosicionDestino=WMSMontacargaTarea.Zona
WMSMontacargaTarea.Zona=WMSMontacargaTarea.Articulo
WMSMontacargaTarea.Articulo=Art.Descripcion1
Art.Descripcion1=WMSMontacargaTarea.Montacarga
WMSMontacargaTarea.Montacarga=Agente.Nombre
Agente.Nombre=WMSMontacargaTarea.Prioridad
WMSMontacargaTarea.Prioridad=(Fin)

[Iconos.ListaAcciones]
(Inicio)=Sugerir1
Sugerir1=PosicionDestino
PosicionDestino=Seleccionar
Seleccionar=Todos1
Todos1=PersonalizarVista
PersonalizarVista=EnviarExcelIconos
EnviarExcelIconos=(Fin)


















































































[Forma.ListaCarpetas]
(Inicio)=Iconos
Iconos=Agrupado
Agrupado=(Fin)

[Forma.MovimientosValidos]
(Inicio)=Solicitud Reacomodo
Solicitud Reacomodo=Solicitud Acomodo
Solicitud Acomodo=Orden Surtido
Orden Surtido=Orden Surtido PCK
Orden Surtido PCK=Orden PCK Tarima
Orden PCK Tarima=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Sugerir
Sugerir=Montacarguista
Montacarguista=Todos
Todos=Prioridad
Prioridad=Actualizar
Actualizar=Seleccion
Seleccion=Quitar
Quitar=FiltroOrigen
FiltroOrigen=FiltrarCliente
FiltrarCliente=OrdenesPendientes
OrdenesPendientes=Posicion
Posicion=Todos2
Todos2=Asignar
Asignar=(Fin)
