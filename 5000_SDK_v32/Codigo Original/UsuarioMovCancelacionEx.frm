[Forma]
Clave=UsuarioMovCancelacionEx
Nombre=Excepciones Movimientos a Cancelar
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=346
PosicionInicialArriba=217
PosicionInicialAlturaCliente=299
PosicionInicialAncho=332
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Usuario

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=UsuarioMovCancelacionEx
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
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=UsuarioMovCancelacionEx.Usuario=<T>{Info.Usuario}<T>

[Lista.UsuarioMovCancelacionEx.Modulo]
Carpeta=Lista
Clave=UsuarioMovCancelacionEx.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.UsuarioMovCancelacionEx.Mov]
Carpeta=Lista
Clave=UsuarioMovCancelacionEx.Mov
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
Modulo=70
Mov=232

[Lista.ListaEnCaptura]
(Inicio)=UsuarioMovCancelacionEx.Modulo
UsuarioMovCancelacionEx.Modulo=UsuarioMovCancelacionEx.Mov
UsuarioMovCancelacionEx.Mov=(Fin)
