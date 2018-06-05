
[Forma]
Clave=WMSLoteMovimiento
Icono=0
Modulos=(Todos)
Nombre=Herramienta Procesar en Lote (a nivel detalle)

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=381
PosicionInicialAncho=1167
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=376
PosicionInicialArriba=310
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos
MovModulo=TMA
ListaAcciones=(Lista)








ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spBorrarWMSTablaHerramienta :nEstacion<T>, EstacionTrabajo)<BR>EjecutarSQL(<T>EXEC spWMSPreparaLoteMovimiento :nEstacion, :tEmpresa<T>, EstacionTrabajo, Empresa )
[Iconos.Columnas]
0=20
1=137
2=-2
3=-2
4=-2
5=-2
6=-2
7=74
8=-2
9=-2
10=-2
11=-2
12=-2
13=-2
14=-2
15=-2
16=-2
17=-2
18=-2

19=-2





























20=-2
21=-2
22=-2
23=-2
24=-2
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Afectar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S










[Acciones.Agente.EspecificarAgente]
Nombre=EspecificarAgente
Boton=0
TipoAccion=Formas
ClaveAccion=EspecificarAgenteWMS
Activo=S
Visible=S

[Acciones.Agente.expresion]
Nombre=expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=RegistrarSeleccion(<T>WMSLoteMovimiento<T>)<BR>EjecutarSQL(<T>spWMSAsignaAcomodador :tAgente, :nEstacion, :tTipo, :tMontacarga<T>,Info.Agente, EstacionTrabajo, <T>WMSLoteMovimiento<T>, info.Montacarga)<BR>ActualizarVista
[Acciones.Agente]
Nombre=Agente
Boton=74
NombreDesplegar=&Especificar Acomodador
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
NombreEnBoton=S









EspacioPrevio=S
[Acciones.Filtro.WMSFiltroLoteMovimiento]
Nombre=WMSFiltroLoteMovimiento
Boton=0
TipoAccion=Formas
ClaveAccion=WMSFiltroLoteMovimiento
Activo=S
Visible=S

[Acciones.Filtro.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





[Acciones.Filtro.expresion]
Nombre=expresion
Boton=0
TipoAccion=expresion
Activo=S
Visible=S









Expresion=EjecutarSQL(<T>EXEC spWMSPreparaLoteMovimiento :nEstacion, :tEmpresa<T>, EstacionTrabajo, Empresa )<BR>ActualizarVista
[Iconos.ListaEnCaptura]
(Inicio)=WMSLoteMovimiento.Movimiento
WMSLoteMovimiento.Movimiento=WMSLoteMovimiento.Tarima
WMSLoteMovimiento.Tarima=WMSLoteMovimiento.Cantidad
WMSLoteMovimiento.Cantidad=WMSLoteMovimiento.PosicionOrigen
WMSLoteMovimiento.PosicionOrigen=WMSLoteMovimiento.PosicionDestino
WMSLoteMovimiento.PosicionDestino=WMSLoteMovimiento.Articulo
WMSLoteMovimiento.Articulo=WMSLoteMovimiento.Descripcion
WMSLoteMovimiento.Descripcion=WMSLoteMovimiento.Acomodador
WMSLoteMovimiento.Acomodador=WMSLoteMovimiento.Montacarga
WMSLoteMovimiento.Montacarga=(Fin)








[Lista.Columnas]
Articulo=131
Descripcion1=244




0=18
1=125
2=-2
3=-2
4=-2
5=-2
6=-2
7=156
8=-2
9=147

10=-2
11=-2
12=-2
13=-2
14=-2
15=-2
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WMSLoteMovimiento
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosNombreNumerico=S
IconosSeleccionMultiple=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroEmpresas=S
FiltroSucursalesTodasPorOmision=S
FiltroFechasCampo=WMSLoteMovimiento.FechaEmision
FiltroFechasDefault=(Todo)
FiltroMovDefault=(Todos)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S

RefrescarAlEntrar=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo1=WMSLoteMovimiento.Almacen
FiltroTodo=S
FiltroValida1=WMSLoteMovimiento.Almacen
MenuLocal=S
ListaAcciones=(Lista)
FiltroGrupo2=WMSLoteMovimiento.Acomodador
FiltroValida2=WMSLoteMovimiento.Acomodador
IconosNombre=WMSLoteMovimiento:WMSLoteMovimiento.IDLista
FiltroGeneral=WMSLoteMovimiento.Estacion = {EstacionTrabajo}
[Lista.WMSLoteMovimiento.Movimiento]
Carpeta=Lista
Clave=WMSLoteMovimiento.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.WMSLoteMovimiento.Tarima]
Carpeta=Lista
Clave=WMSLoteMovimiento.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.WMSLoteMovimiento.Cantidad]
Carpeta=Lista
Clave=WMSLoteMovimiento.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.WMSLoteMovimiento.PosicionOrigen]
Carpeta=Lista
Clave=WMSLoteMovimiento.PosicionOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.WMSLoteMovimiento.PosicionDestino]
Carpeta=Lista
Clave=WMSLoteMovimiento.PosicionDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.WMSLoteMovimiento.Articulo]
Carpeta=Lista
Clave=WMSLoteMovimiento.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.WMSLoteMovimiento.Descripcion]
Carpeta=Lista
Clave=WMSLoteMovimiento.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.WMSLoteMovimiento.Acomodador]
Carpeta=Lista
Clave=WMSLoteMovimiento.Acomodador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.WMSLoteMovimiento.Montacarga]
Carpeta=Lista
Clave=WMSLoteMovimiento.Montacarga
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco







[Acciones.expresion.WMSFiltroLoteMovimiento]
Nombre=WMSFiltroLoteMovimiento
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>  Forma(<T>WMSFiltroLoteMovimiento<T>)<BR>Entonces<BR>   EjecutarSQL(<T>spWMSPreparaLoteMovimiento :nEstacion, :tEmpresa<T>, EstacionTrabajo, Empresa )<BR>   Forma.ActualizarVista(<T>Lista<T>)<BR>   ActualizarForma<BR>Fin
[Acciones.expresion.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S


















[Acciones.Filtro 2.ListaAccionesMultiples]
(Inicio)=WMSFiltroLoteMovimiento
WMSFiltroLoteMovimiento=Actualizar Vista
Actualizar Vista=(Fin)




[Acciones.Expresion]
Nombre=Expresion
Boton=107
NombreEnBoton=S
NombreDesplegar=&Filtro
Multiple=S
EnBarraHerramientas=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S



[Acciones.Filtro.ListaAccionesMultiples]
(Inicio)=Aceptar
Aceptar=WMSFiltroLoteMovimiento
WMSFiltroLoteMovimiento=expresion
expresion=(Fin)




















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



























[Lista.Agente.Nombre]
Carpeta=Lista
Clave=Agente.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco















[Acciones.Filtrojkkjñlklñ.ListaAccionesMultiples]
(Inicio)=Aceptar
Aceptar=WMSFiltroLoteMovimiento
WMSFiltroLoteMovimiento=expresion
expresion=(Fin)









[Acciones.Seleccionar Todo1]
Nombre=Seleccionar Todo1
Boton=0
NombreEnBoton=S
NombreDesplegar=&Seleccionar Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S


[Acciones.Quitar Seleccion1]
Nombre=Quitar Seleccion1
Boton=0
NombreEnBoton=S
NombreDesplegar=&Quitar Seleccion
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S












[Acciones.Expresion.ListaAccionesMultiples]
(Inicio)=WMSFiltroLoteMovimiento
WMSFiltroLoteMovimiento=Actualizar Vista
Actualizar Vista=(Fin)




[Acciones.Agente.ListaAccionesMultiples]
(Inicio)=EspecificarAgente
EspecificarAgente=expresion
expresion=(Fin)






[Acciones.RepWMSLoteMovimiento]
Nombre=RepWMSLoteMovimiento
Boton=68
NombreDesplegar=&Presentación Preliminar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Pantalla
ClaveAccion=RepWMSLoteMovimiento
Activo=S
Visible=S

























NombreEnBoton=S





















[Acciones.Afectar.Seleccionar]
Nombre=Seleccionar
Boton=0
TipoAccion=Expresion
Expresion=RegistrarSeleccion(<T>WMSLoteMovimiento<T>)
Activo=S
Visible=S

[Acciones.Afectar.Procesar]
Nombre=Procesar
Boton=0
TipoAccion=Expresion
Expresion=ProcesarSQL(<T>spWMSGeneraLoteMovimiento :nEstacion, :tEmpresa<T>,EstacionTrabajo, Empresa)
Activo=S
ConCondicion=S
EjecucionCondicion=Asigna(Info.Valor,SQL(<T>SELECT COUNT(Estacion) FROM ListaSt WHERE Estacion = :nEstacion<T>,EstacionTrabajo))<BR>Info.Valor > 0
EjecucionMensaje=<T>Es necesario seleccionar Movimientos<T>
EjecucionConError=S
Visible=S

[Acciones.Afectar.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Expresion
Expresion=ActualizarVista
Activo=S
Visible=S

[Acciones.Afectar.ListaAccionesMultiples]
(Inicio)=Seleccionar
Seleccionar=Procesar
Procesar=Actualizar
Actualizar=(Fin)










[Lista.WMSLoteMovimiento.SubCuenta]
Carpeta=Lista
Clave=WMSLoteMovimiento.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

















[Lista.WMSLoteMovimiento.Zona]
Carpeta=Lista
Clave=WMSLoteMovimiento.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.WMSLoteMovimiento.Pasillo]
Carpeta=Lista
Clave=WMSLoteMovimiento.Pasillo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.WMSLoteMovimiento.Fila]
Carpeta=Lista
Clave=WMSLoteMovimiento.Fila
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.WMSLoteMovimiento.Nivel]
Carpeta=Lista
Clave=WMSLoteMovimiento.Nivel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco








[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=&Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S


[Lista.ListaEnCaptura]
(Inicio)=WMSLoteMovimiento.Movimiento
WMSLoteMovimiento.Movimiento=WMSLoteMovimiento.Tarima
WMSLoteMovimiento.Tarima=WMSLoteMovimiento.Cantidad
WMSLoteMovimiento.Cantidad=WMSLoteMovimiento.PosicionOrigen
WMSLoteMovimiento.PosicionOrigen=WMSLoteMovimiento.PosicionDestino
WMSLoteMovimiento.PosicionDestino=WMSLoteMovimiento.Articulo
WMSLoteMovimiento.Articulo=WMSLoteMovimiento.SubCuenta
WMSLoteMovimiento.SubCuenta=WMSLoteMovimiento.Descripcion
WMSLoteMovimiento.Descripcion=WMSLoteMovimiento.Zona
WMSLoteMovimiento.Zona=WMSLoteMovimiento.Pasillo
WMSLoteMovimiento.Pasillo=WMSLoteMovimiento.Fila
WMSLoteMovimiento.Fila=WMSLoteMovimiento.Nivel
WMSLoteMovimiento.Nivel=WMSLoteMovimiento.Acomodador
WMSLoteMovimiento.Acomodador=Agente.Nombre
Agente.Nombre=WMSLoteMovimiento.Montacarga
WMSLoteMovimiento.Montacarga=(Fin)

[Lista.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Expresion
Expresion=Seleccionar Todo1
Seleccionar Todo1=Quitar Seleccion1
Quitar Seleccion1=Agente
Agente=Afectar
Afectar=RepWMSLoteMovimiento
RepWMSLoteMovimiento=Campos
Campos=(Fin)
