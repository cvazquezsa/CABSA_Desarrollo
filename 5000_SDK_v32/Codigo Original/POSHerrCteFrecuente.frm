
[Forma]
Clave=POSHerrCteFrecuente
Icono=0
CarpetaPrincipal=POSHerrCteFrecuente
Modulos=(Todos)
Nombre=Cliente Frecuente
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
PosicionInicialIzquierda=278
PosicionInicialArriba=89
PosicionInicialAlturaCliente=644
PosicionInicialAncho=1043
ListaAcciones=(Lista)



PosicionSec1=332
ExpresionesAlMostrar=EjecutarSQL(<T>spPOSBorrarCteFrecuente :nEstacion<T>,EstacionTrabajo)
[POSHerrCteFrecuente.Columnas]
0=111
1=313
2=210






3=355
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

[Acciones.Monedero.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>  CuantosSeleccionID(<T>POSHerrCteFrecuente<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>POSHerrCteFrecuente<T>)<BR>  EjecutarSQL(<T>spPOSPOSHerrCteGenerarMonedero  :nEstacion<T>, EstacionTrabajo)<BR>  ActualizarForma<BR>Fin
[Acciones.Monedero]
Nombre=Monedero
Boton=12
NombreEnBoton=S
NombreDesplegar=Sugerir Monedero
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S





EspacioPrevio=S































ConCondicion=S
Expresion=Si<BR>  CuantosSeleccionID(<T>POSHerrCteFrecuente<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>POSHerrCteFrecuente<T>)<BR>  EjecutarSQL(<T>spPOSPOSHerrCteGenerarMonedero  :nEstacion<T>, EstacionTrabajo)<BR>  ActualizarForma<BR>SeleccionarTodo(<T>POSHerrCteFrecuente<T>)<BR>Fin
EjecucionCondicion=CuantosSeleccionID(<T>POSHerrCteFrecuente<T>)>0
[Acciones.seleccionar Todo]
Nombre=seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S


[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S



















Expresion=Si<BR>  CuantosSeleccionID(<T>POSHerrCteFrecuente<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>POSHerrCteFrecuente<T>)<BR>  FormaModal(<T>POSHerrCteFrecuenteG<T>) <BR>  ActualizarForma<BR>Fin
[Acciones.POSHerrCteFrecuenteD]
Nombre=POSHerrCteFrecuenteD
Boton=54
NombreEnBoton=S
NombreDesplegar=Editar Detalle
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S





EspacioPrevio=S













































Activo=S
ConCondicion=S
Expresion=FormaModal(<T>POSHerrCteFrecuenteD<T>)<BR>ActualizarForma
EjecucionCondicion=ConDatos(POSHerrCteFrecuente:POSHerrCteFrecuente.ID)
[Cliente]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Clientes
Clave=Cliente
Filtros=S
BusquedaRapidaControles=S
MenuLocal=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=CtaSituacion.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
IconosSeleccionMultiple=S
ElementosPorPaginaEsp=50
CampoColorLetras=Negro
CampoColorFondo=Blanco

FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CteCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CteFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CteTipo
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=CteGrupo
FiltroAplicaEn1=Cte.Categoria
FiltroAplicaEn2=Cte.Familia
FiltroAplicaEn3=Cte.Tipo
FiltroAplicaEn4=Cte.Grupo
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
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
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
ListaAcciones=(Lista)
CarpetaVisible=S
IconosConPaginas=S
FiltroEstatus=S
FiltroListaEstatus=(Lista)
ListaEnCaptura=Cte.Nombre
ExpAlRefrescar=SeleccionarTodo(<T>POSHerrCteFrecuente<T>)
IconosNombre=CteA:Cte.Cliente
FiltroGeneral=Cte.Cliente NOT IN (SELECT Clave FROM ListaST WHERE Estacion = {EstacionTrabajo})
[Cliente.ListaEnCaptura]
(Inicio)=Cte.Nombre
Cte.Nombre=POSHerrCteFrecuente.Monedero
POSHerrCteFrecuente.Monedero=POSHerrCteFrecuente.Error
POSHerrCteFrecuente.Error=(Fin)


[POSHerrCteFrecuente]
Estilo=Iconos
Clave=POSHerrCteFrecuente
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=POSHerrCteFrecuente
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Clave<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
IconosSeleccionMultiple=S

PestanaOtroNombre=S
PestanaNombre=Cliente Frecuente
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=POSHerrCteFrecuente:POSHerrCteFrecuente.Cliente
FiltroGeneral=POSHerrCteFrecuente.Estacion = {EstacionTrabajo}
[POSHerrCteFrecuente.POSHerrCteFrecuente.Monedero]
Carpeta=POSHerrCteFrecuente
Clave=POSHerrCteFrecuente.Monedero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSHerrCteFrecuente.POSHerrCteFrecuente.Error]
Carpeta=POSHerrCteFrecuente
Clave=POSHerrCteFrecuente.Error
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco





[Cliente.Columnas]
0=167
1=682


[Cliente.Cte.Nombre]
Carpeta=Cliente
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco







[Acciones.Asignar]
Nombre=Asignar
Boton=54
NombreEnBoton=S
NombreDesplegar=Asignar Selección
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S



GuardarAntes=S













EspacioPrevio=S




Expresion=RegistrarSeleccion(<T>Cliente<T>)<BR>EjecutarSQL(<T>spPOSHerrCteFrecuente  :nEstacion<T>, EstacionTrabajo)<BR>ActualizarForma<BR>SeleccionarTodo(<T>POSHerrCteFrecuente<T>)
[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S



[Acciones.SeleccionarTodo2]
Nombre=SeleccionarTodo2
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.QuitarSeleccion2]
Nombre=QuitarSeleccion2
Boton=0
NombreDesplegar=Desseleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S







[POSHerrCteFrecuente.Cte.Nombre]
Carpeta=POSHerrCteFrecuente
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco















[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Monederos Generados
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
Activo=S
Visible=S



ClaveAccion=POSHerrCteFrecuenteD2
































[Acciones.Expresion]
Nombre=Expresion
Boton=0
NombreDesplegar=Quitar Selección
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S





Expresion=Si<BR>  CuantosSeleccionID(<T>POSHerrCteFrecuente<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>POSHerrCteFrecuente<T>)<BR>  EjecutarSQL(<T>spPOSHerrCteFrecuenteQuitar :nEstacion<T>,EstacionTrabajo)<BR>  ActualizarForma<BR>Fin




[POSHerrCteFrecuente.ListaEnCaptura]
(Inicio)=Cte.Nombre
Cte.Nombre=POSHerrCteFrecuente.Monedero
POSHerrCteFrecuente.Monedero=POSHerrCteFrecuente.Error
POSHerrCteFrecuente.Error=(Fin)

[POSHerrCteFrecuente.ListaAcciones]
(Inicio)=SeleccionarTodo2
SeleccionarTodo2=QuitarSeleccion2
QuitarSeleccion2=Expresion
Expresion=(Fin)





[Cliente.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BAJA
BAJA=BLOQUEADO
BLOQUEADO=BLOQ_AVISO
BLOQ_AVISO=(Fin)

[Cliente.ListaAcciones]
(Inicio)=seleccionar Todo
seleccionar Todo=Quitar Seleccion
Quitar Seleccion=(Fin)















[POSHerrCteFrecuenteD.Columnas]
Cliente=83
Nombre=242
Monedero=173













[Forma.ListaCarpetas]
(Inicio)=Cliente
Cliente=POSHerrCteFrecuente
POSHerrCteFrecuente=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Asignar
Asignar=Monedero
Monedero=Generar
Generar=POSHerrCteFrecuenteD
POSHerrCteFrecuenteD=Detalle
Detalle=(Fin)
