
[Forma]
Clave=VentaMES
Icono=0
Modulos=(Todos)
Nombre=Aprobar ventas

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialAlturaCliente=453
PosicionInicialAncho=708
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=286
PosicionInicialArriba=251
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaMES
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

CarpetaVisible=S
BusquedaRapidaControles=S

FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=VentaMES.FechaPedido
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroFechasDefault=Esta Semana
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=VentaMES.Cancelado = 0 AND VentaMES.Aprobado = 0
FiltroRespetar=S
FiltroTipo=General
[Lista.VentaMES.ID]
Carpeta=Lista
Clave=VentaMES.ID
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VentaMES.Serie]
Carpeta=Lista
Clave=VentaMES.Serie
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.VentaMES.NumerodePedido]
Carpeta=Lista
Clave=VentaMES.NumerodePedido
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.VentaMES.Cliente]
Carpeta=Lista
Clave=VentaMES.Cliente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.VentaMES.FechaPedido]
Carpeta=Lista
Clave=VentaMES.FechaPedido
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VentaMES.FechaEntrega]
Carpeta=Lista
Clave=VentaMES.FechaEntrega
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VentaMES.Cancelado]
Carpeta=Lista
Clave=VentaMES.Cancelado
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.Columnas]
ID=64
Serie=124
NumerodePedido=124
Cliente=64
FechaPedido=122
FechaEntrega=94
Cancelado=64
Aprobado=54

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











[Lista.ListaEnCaptura]
(Inicio)=VentaMES.ID
VentaMES.ID=VentaMES.Serie
VentaMES.Serie=VentaMES.NumerodePedido
VentaMES.NumerodePedido=VentaMES.Cliente
VentaMES.Cliente=VentaMES.FechaPedido
VentaMES.FechaPedido=VentaMES.FechaEntrega
VentaMES.FechaEntrega=VentaMES.Cancelado
VentaMES.Cancelado=(Fin)

[Acciones.Aprobar]
Nombre=Aprobar
Boton=23
NombreEnBoton=S
NombreDesplegar=Aprobar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=Asigna(VentaMES:VentaMES.Aprobado, Verdadero)<BR>GuardarCambios<BR>ActualizarVista
Activo=S
Visible=S





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Aprobar
Aprobar=(Fin)
