[Forma]
Clave=EmpresaCostoPiso
Nombre=Tasas - Costo Piso
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=85
PosicionInicialArriba=123
PosicionInicialAlturaCliente=487
PosicionInicialAncho=854
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCostoPiso
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
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
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=EmpresaCostoPiso.Fecha
FiltroFechasDefault=Mes Móvil
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroGeneral=EmpresaCostoPiso.Empresa=<T>{Empresa}<T>

[Lista.EmpresaCostoPiso.Fecha]
Carpeta=Lista
Clave=EmpresaCostoPiso.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCostoPiso.Plazo1Tasa]
Carpeta=Lista
Clave=EmpresaCostoPiso.Plazo1Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCostoPiso.Plazo2Tasa]
Carpeta=Lista
Clave=EmpresaCostoPiso.Plazo2Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCostoPiso.Plazo3Tasa]
Carpeta=Lista
Clave=EmpresaCostoPiso.Plazo3Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Fecha=105
Plazo1Tasa=77
Plazo2Tasa=78
Plazo3Tasa=75
Plazo1TasaDolar=84
Plazo2TasaDolar=84
Plazo3TasaDolar=85
Plazo1TasaEuro=76
Plazo2TasaEuro=74
Plazo3TasaEuro=77

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Lista.EmpresaCostoPiso.Plazo1TasaDolar]
Carpeta=Lista
Clave=EmpresaCostoPiso.Plazo1TasaDolar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCostoPiso.Plazo2TasaDolar]
Carpeta=Lista
Clave=EmpresaCostoPiso.Plazo2TasaDolar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCostoPiso.Plazo3TasaDolar]
Carpeta=Lista
Clave=EmpresaCostoPiso.Plazo3TasaDolar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCostoPiso.Plazo1TasaEuro]
Carpeta=Lista
Clave=EmpresaCostoPiso.Plazo1TasaEuro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCostoPiso.Plazo2TasaEuro]
Carpeta=Lista
Clave=EmpresaCostoPiso.Plazo2TasaEuro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCostoPiso.Plazo3TasaEuro]
Carpeta=Lista
Clave=EmpresaCostoPiso.Plazo3TasaEuro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=EmpresaCostoPiso.Fecha
EmpresaCostoPiso.Fecha=EmpresaCostoPiso.Plazo1Tasa
EmpresaCostoPiso.Plazo1Tasa=EmpresaCostoPiso.Plazo2Tasa
EmpresaCostoPiso.Plazo2Tasa=EmpresaCostoPiso.Plazo3Tasa
EmpresaCostoPiso.Plazo3Tasa=EmpresaCostoPiso.Plazo1TasaDolar
EmpresaCostoPiso.Plazo1TasaDolar=EmpresaCostoPiso.Plazo2TasaDolar
EmpresaCostoPiso.Plazo2TasaDolar=EmpresaCostoPiso.Plazo3TasaDolar
EmpresaCostoPiso.Plazo3TasaDolar=EmpresaCostoPiso.Plazo1TasaEuro
EmpresaCostoPiso.Plazo1TasaEuro=EmpresaCostoPiso.Plazo2TasaEuro
EmpresaCostoPiso.Plazo2TasaEuro=EmpresaCostoPiso.Plazo3TasaEuro
EmpresaCostoPiso.Plazo3TasaEuro=(Fin)
