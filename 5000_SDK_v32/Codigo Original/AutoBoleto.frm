[Forma]
Clave=AutoBoleto
Nombre=Boletos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=85
PosicionInicialArriba=141
PosicionInicialAlturaCliente=451
PosicionInicialAncho=894
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AutoBoleto
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
BusquedaRapidaControles=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=AutoBoleto.FechaVenta
FiltroFechasDefault=Hoy
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
PestanaOtroNombre=S
PestanaNombre=Boletos
FiltroGrupo1=AutoBoleto.TipoServicio
FiltroValida1=AutoServicio.Servicio
FiltroTodo=S
FiltroTodoFinal=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática

[Lista.AutoBoleto.Origen]
Carpeta=Lista
Clave=AutoBoleto.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoBoleto.Destino]
Carpeta=Lista
Clave=AutoBoleto.Destino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoBoleto.Precio]
Carpeta=Lista
Clave=AutoBoleto.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.Columnas]
Boleto=93
Origen=58
Destino=75
FechaViaje=64
HoraSalida=61
TipoPasajero=74
Corrida=48
Usuario=66
TipoServicio=70
FechaVenta=94
HoraVenta=63
Sesion=43
Precio=64
Servicio=88
0=98
1=77
Taquilla=40
Folio=52
OficinaVenta=70
Estatus=41
Recaudado=58
Serie=76

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

[Lista.AutoBoleto.Taquilla]
Carpeta=Lista
Clave=AutoBoleto.Taquilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoBoleto.Folio]
Carpeta=Lista
Clave=AutoBoleto.Folio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoBoleto.OficinaVenta]
Carpeta=Lista
Clave=AutoBoleto.OficinaVenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoBoleto.Estatus]
Carpeta=Lista
Clave=AutoBoleto.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=1
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoBoleto.FechaViaje]
Carpeta=Lista
Clave=AutoBoleto.FechaViaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoBoleto.HoraSalida]
Carpeta=Lista
Clave=AutoBoleto.HoraSalida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoBoleto.Corrida]
Carpeta=Lista
Clave=AutoBoleto.Corrida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoBoleto.Recaudado]
Carpeta=Lista
Clave=AutoBoleto.Recaudado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoBoleto.Serie]
Carpeta=Lista
Clave=AutoBoleto.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=AutoBoleto.Estatus
AutoBoleto.Estatus=AutoBoleto.Taquilla
AutoBoleto.Taquilla=AutoBoleto.Folio
AutoBoleto.Folio=AutoBoleto.OficinaVenta
AutoBoleto.OficinaVenta=AutoBoleto.Serie
AutoBoleto.Serie=AutoBoleto.FechaViaje
AutoBoleto.FechaViaje=AutoBoleto.HoraSalida
AutoBoleto.HoraSalida=AutoBoleto.Origen
AutoBoleto.Origen=AutoBoleto.Destino
AutoBoleto.Destino=AutoBoleto.Precio
AutoBoleto.Precio=AutoBoleto.Corrida
AutoBoleto.Corrida=AutoBoleto.Recaudado
AutoBoleto.Recaudado=(Fin)
