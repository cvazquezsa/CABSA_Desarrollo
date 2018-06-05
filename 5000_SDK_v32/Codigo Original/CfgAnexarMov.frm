[Forma]
Clave=CfgAnexarMov
Nombre=Anexar Movimientos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=353
PosicionInicialArriba=189
PosicionInicialAlturaCliente=356
PosicionInicialAncho=318
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Descripcion

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgAnexarMov
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
OtroOrden=S
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=CfgAnexarMov.Modulo=<T>{Info.Modulo}<T>

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
Mov=124
MovDestino=124
Orden=39

[Lista.CfgAnexarMov.Mov]
Carpeta=Lista
Clave=CfgAnexarMov.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CfgAnexarMov.MovDestino]
Carpeta=Lista
Clave=CfgAnexarMov.MovDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CfgAnexarMov.Orden]
Carpeta=Lista
Clave=CfgAnexarMov.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=CfgAnexarMov.Mov
CfgAnexarMov.Mov=CfgAnexarMov.MovDestino
CfgAnexarMov.MovDestino=CfgAnexarMov.Orden
CfgAnexarMov.Orden=(Fin)

[Lista.ListaOrden]
(Inicio)=CfgAnexarMov.Mov<TAB>(Acendente)
CfgAnexarMov.Mov<TAB>(Acendente)=CfgAnexarMov.Orden<TAB>(Acendente)
CfgAnexarMov.Orden<TAB>(Acendente)=(Fin)
