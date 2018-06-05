
[Forma]
Clave=IntelisisSLLista
Icono=22
Modulos=(Todos)
Nombre=Licencias

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=217
PosicionInicialArriba=114
PosicionInicialAlturaCliente=504
PosicionInicialAncho=932
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=IntelisisSL
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Licencia<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNombre=&Vencimiento
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroFechas=S
FiltroFechasCampo=IntelisisSL.Vencimiento
FiltroFechasVencimiento=S
PestanaOtroNombre=S
PestanaNombre=Licencias
FiltroFechasDefault=(Todo)
MenuLocal=S
IconosNombre=IntelisisSL:IntelisisSL.Licencia
ListaAcciones=(Lista)
[Lista.IntelisisSL.Nombre]
Carpeta=Lista
Clave=IntelisisSL.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.IntelisisSL.Cliente]
Carpeta=Lista
Clave=IntelisisSL.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.IntelisisSL.Vencimiento]
Carpeta=Lista
Clave=IntelisisSL.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.IntelisisSL.Mantenimiento]
Carpeta=Lista
Clave=IntelisisSL.Mantenimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.IntelisisSL.Tipo]
Carpeta=Lista
Clave=IntelisisSL.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.IntelisisSL.Observaciones]
Carpeta=Lista
Clave=IntelisisSL.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco




[Lista.Columnas]
0=82
1=139
2=71
3=155
4=89
5=-2
6=47
7=140


[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
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

[Lista.ListaEnCaptura]
(Inicio)=IntelisisSL.Nombre
IntelisisSL.Nombre=IntelisisSL.Cliente
IntelisisSL.Cliente=Cte.Nombre
Cte.Nombre=IntelisisSL.Vencimiento
IntelisisSL.Vencimiento=IntelisisSL.Mantenimiento
IntelisisSL.Mantenimiento=IntelisisSL.Tipo
IntelisisSL.Tipo=IntelisisSL.Observaciones
IntelisisSL.Observaciones=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)




[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S



[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cancelar
Cancelar=Personalizar
Personalizar=(Fin)
