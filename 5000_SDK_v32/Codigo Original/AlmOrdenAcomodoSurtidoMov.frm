[Forma]
Clave=AlmOrdenAcomodoSurtidoMov
Nombre=Auto Generar Solicitud/Orden Acomodo (Reabastecimiento) en...
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=745
PosicionInicialArriba=446
PosicionInicialAlturaCliente=273
PosicionInicialAncho=458
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
Vista=AlmOrdenAcomodoSurtidoMov
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
FiltroGeneral=AlmOrdenAcomodoSurtidoMov.Almacen=<T>{Info.Almacen}<T>

[Lista.AlmOrdenAcomodoSurtidoMov.Modulo]
Carpeta=Lista
Clave=AlmOrdenAcomodoSurtidoMov.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AlmOrdenAcomodoSurtidoMov.Mov]
Carpeta=Lista
Clave=AlmOrdenAcomodoSurtidoMov.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Modulo=74
Mov=200

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
(Inicio)=AlmOrdenAcomodoSurtidoMov.Modulo
AlmOrdenAcomodoSurtidoMov.Modulo=AlmOrdenAcomodoSurtidoMov.Mov
AlmOrdenAcomodoSurtidoMov.Mov=(Fin)
