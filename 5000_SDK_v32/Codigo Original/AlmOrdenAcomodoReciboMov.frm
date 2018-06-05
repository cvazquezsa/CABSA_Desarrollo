[Forma]
Clave=AlmOrdenAcomodoReciboMov
Nombre=Auto Generar Solicitud/Orden Acomodo (Recibo) en...
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=744
PosicionInicialArriba=446
PosicionInicialAlturaCliente=273
PosicionInicialAncho=431
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
Vista=AlmOrdenAcomodoReciboMov
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
FiltroGeneral=AlmOrdenAcomodoReciboMov.Almacen=<T>{Info.Almacen}<T>

[Lista.AlmOrdenAcomodoReciboMov.Modulo]
Carpeta=Lista
Clave=AlmOrdenAcomodoReciboMov.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AlmOrdenAcomodoReciboMov.Mov]
Carpeta=Lista
Clave=AlmOrdenAcomodoReciboMov.Mov
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
(Inicio)=AlmOrdenAcomodoReciboMov.Modulo
AlmOrdenAcomodoReciboMov.Modulo=AlmOrdenAcomodoReciboMov.Mov
AlmOrdenAcomodoReciboMov.Mov=(Fin)
