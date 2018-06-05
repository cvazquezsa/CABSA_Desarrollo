[Forma]
Clave=AlmSugerirSurtidoTarima
Nombre=Configurar Movimientos (Entarimado, Acomodo)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=171
PosicionInicialArriba=279
PosicionInicialAlturaCliente=273
PosicionInicialAncho=613
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Almacen
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AlmSugerirSurtidoTarima
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

FiltroGeneral=AlmSugerirSurtidoTarima.Almacen=<T>{Info.Almacen}<T>
[Lista.AlmSugerirSurtidoTarima.Modulo]
Carpeta=Lista
Clave=AlmSugerirSurtidoTarima.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.AlmSugerirSurtidoTarima.Mov]
Carpeta=Lista
Clave=AlmSugerirSurtidoTarima.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
Modulo=74
Mov=200

Estatus=94
ModuloDestino=77
MovDestino=124
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
(Inicio)=AlmSugerirSurtidoTarima.Modulo
AlmSugerirSurtidoTarima.Modulo=AlmSugerirSurtidoTarima.Mov
AlmSugerirSurtidoTarima.Mov=AlmSugerirSurtidoTarima.Estatus
AlmSugerirSurtidoTarima.Estatus=AlmSugerirSurtidoTarima.ModuloDestino
AlmSugerirSurtidoTarima.ModuloDestino=AlmSugerirSurtidoTarima.MovDestino
AlmSugerirSurtidoTarima.MovDestino=(Fin)

[Lista.AlmSugerirSurtidoTarima.Estatus]
Carpeta=Lista
Clave=AlmSugerirSurtidoTarima.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.AlmSugerirSurtidoTarima.ModuloDestino]
Carpeta=Lista
Clave=AlmSugerirSurtidoTarima.ModuloDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.AlmSugerirSurtidoTarima.MovDestino]
Carpeta=Lista
Clave=AlmSugerirSurtidoTarima.MovDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
