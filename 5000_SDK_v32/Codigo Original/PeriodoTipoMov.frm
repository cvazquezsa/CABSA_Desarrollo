[Forma]
Clave=PeriodoTipoMov
Nombre=por Movimiento
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=352
PosicionInicialArriba=230
PosicionInicialAlturaCliente=273
PosicionInicialAncho=320
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.PeriodoTipo

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PeriodoTipoMov
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=PeriodoTipoMov.PeriodoTipo=<T>{Info.PeriodoTipo}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.PeriodoTipoMov.Mov]
Carpeta=Lista
Clave=PeriodoTipoMov.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PeriodoTipoMov.UltimoDiaPagado]
Carpeta=Lista
Clave=PeriodoTipoMov.UltimoDiaPagado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Mov=186
UltimoDiaPagado=104

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
(Inicio)=PeriodoTipoMov.Mov
PeriodoTipoMov.Mov=PeriodoTipoMov.UltimoDiaPagado
PeriodoTipoMov.UltimoDiaPagado=(Fin)
