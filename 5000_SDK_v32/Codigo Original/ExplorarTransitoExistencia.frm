
[Forma]
Clave=ExplorarTransitoExistencia
Icono=4
Modulos=(Todos)
Nombre=Explorar - Existencias Tránsito

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=451
PosicionInicialAncho=895
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=192
PosicionInicialArriba=127
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
Vista=TransitoExistencia
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)


Filtros=S
FiltroPredefinido=S
FiltroGrupo1=TransitoExistencia.OrigenDestino
FiltroValida1=TransitoExistencia.OrigenDestino
FiltroGrupo2=TransitoExistencia.Articulo
FiltroValida2=TransitoExistencia.Articulo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroTodoFinal=S
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
OtroOrden=S
ListaOrden=(Lista)
FiltroGrupo3=TransitoExistencia.Opcion
FiltroValida3=TransitoExistencia.Opcion
PestanaOtroNombre=S
PestanaNombre=Registros
IconosNombre=TransitoExistencia:TransitoExistencia.Articulo
FiltroGeneral=TransitoExistencia.Empresa = {Comillas(Empresa)}
[Lista.TransitoExistencia.Opcion]
Carpeta=Lista
Clave=TransitoExistencia.Opcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

Totalizador=0
[Lista.TransitoExistencia.AlmacenOrigen]
Carpeta=Lista
Clave=TransitoExistencia.AlmacenOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.TransitoExistencia.AlmacenDestino]
Carpeta=Lista
Clave=TransitoExistencia.AlmacenDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.TransitoExistencia.Cantidad]
Carpeta=Lista
Clave=TransitoExistencia.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.TransitoExistencia.Unidad]
Carpeta=Lista
Clave=TransitoExistencia.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Lista.Columnas]
0=83
1=88
2=-2
3=-2
4=63
5=46


6=70
7=134
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S










[(Carpeta Totalizadores)]
Pestana=S
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=TotalCantidad
Totalizadores2=SUMA(TransitoExistencia:TransitoExistencia.Cantidad)
Totalizadores3=#.##
Totalizadores=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=TotalCantidad
CarpetaVisible=S

[(Carpeta Totalizadores).TotalCantidad]
Carpeta=(Carpeta Totalizadores)
Clave=TotalCantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata





[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S


[Acciones.VistaPrevia]
Nombre=VistaPrevia
Boton=6
NombreDesplegar=&Presentación Preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S


[Acciones.Excel]
Nombre=Excel
Boton=115
NombreDesplegar=&Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S


[Acciones.MostrarCampos]
Nombre=MostrarCampos
Boton=45
NombreDesplegar=&Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S






[Lista.TransitoExistencia.Costo]
Carpeta=Lista
Clave=TransitoExistencia.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.TransitoExistencia.CostoTotal]
Carpeta=Lista
Clave=TransitoExistencia.CostoTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1















[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ExplorarTransitoExistenciaD
Activo=S
Antes=S
Visible=S






AntesExpresiones=Asigna(Info.Articulo,TransitoExistencia:TransitoExistencia.Articulo)<BR>Asigna(Info.Opcion,TransitoExistencia:TransitoExistencia.Opcion)<BR>Asigna(Info.Almacen,TransitoExistencia:TransitoExistencia.AlmacenOrigen)<BR>Asigna(Info.AlmacenDestino,TransitoExistencia:TransitoExistencia.AlmacenDestino)<BR>Asigna(Info.Costo,TransitoExistencia:TransitoExistencia.Costo)






[Lista.ListaEnCaptura]
(Inicio)=TransitoExistencia.Opcion
TransitoExistencia.Opcion=TransitoExistencia.AlmacenOrigen
TransitoExistencia.AlmacenOrigen=TransitoExistencia.AlmacenDestino
TransitoExistencia.AlmacenDestino=TransitoExistencia.Cantidad
TransitoExistencia.Cantidad=TransitoExistencia.Unidad
TransitoExistencia.Unidad=TransitoExistencia.Costo
TransitoExistencia.Costo=TransitoExistencia.CostoTotal
TransitoExistencia.CostoTotal=(Fin)

[Lista.ListaOrden]
(Inicio)=TransitoExistencia.OrigenDestino	(Acendente)
TransitoExistencia.OrigenDestino	(Acendente)=TransitoExistencia.Articulo	(Acendente)
TransitoExistencia.Articulo	(Acendente)=TransitoExistencia.Opcion	(Acendente)
TransitoExistencia.Opcion	(Acendente)=(Fin)





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Imprimir
Imprimir=VistaPrevia
VistaPrevia=Excel
Excel=Detalle
Detalle=MostrarCampos
MostrarCampos=(Fin)
