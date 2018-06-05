
[Forma]
Clave=CorteMovTotalizador
Icono=0
Modulos=CORTE
MovModulo=CORTE
Nombre=Totalizadores

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=361
PosicionInicialAncho=376
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=495
PosicionInicialArriba=164
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Mov
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
BusquedaRapidaControles=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CorteMovTotalizador
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
ListaEnCaptura=CorteMovTotalizador.Totalizador

ListaOrden=(Lista)
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
CarpetaVisible=S



Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=CorteMovTotalizador.Mov = <T>{Info.Mov}<T>
[Lista.CorteMovTotalizador.Totalizador]
Carpeta=Lista
Clave=CorteMovTotalizador.Totalizador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.Columnas]
MovTipo=146
Totalizador=224

Mov=124
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S



[Acciones.Excel]
Nombre=Excel
Boton=115
NombreDesplegar=&Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S























[Lista.ListaEnCaptura]
(Inicio)=CorteMovTotalizador.Mov
CorteMovTotalizador.Mov=CorteMovTotalizador.Totalizador
CorteMovTotalizador.Totalizador=(Fin)



[Lista.ListaOrden]
(Inicio)=CorteMovTotalizador.Mov	(Acendente)
CorteMovTotalizador.Mov	(Acendente)=CorteMovTotalizador.Totalizador	(Acendente)
CorteMovTotalizador.Totalizador	(Acendente)=(Fin)










[Acciones.TipoCampo]
Nombre=TipoCampo
Boton=93
NombreEnBoton=S
NombreDesplegar=Tipos de Campo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CorteMovTotalizadorTipoCampo
Activo=S
Visible=S



[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Excel
Excel=TipoCampo
TipoCampo=(Fin)
