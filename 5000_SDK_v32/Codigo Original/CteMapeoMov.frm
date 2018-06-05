[Forma]
Clave=CteMapeoMov
Nombre=Mapeo Movimientos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Cliente
PosicionInicialIzquierda=467
PosicionInicialArriba=285
PosicionInicialAlturaCliente=427
PosicionInicialAncho=345
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
Vista=CteMapeoMov
Fuente={Tahoma, 8, Negro, []}
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
HojaTitulos=S
HojaMostrarColumnas=S
FiltroGeneral=CteMapeoMov.Cliente=<T>{Info.Cliente}<T>

[Lista.CteMapeoMov.MovOrigen]
Carpeta=Lista
Clave=CteMapeoMov.MovOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteMapeoMov.MovDestino]
Carpeta=Lista
Clave=CteMapeoMov.MovDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
MovOrigen=178
MovDestino=138

[Lista.ListaEnCaptura]
(Inicio)=CteMapeoMov.MovOrigen
CteMapeoMov.MovOrigen=CteMapeoMov.MovDestino
CteMapeoMov.MovDestino=(Fin)
