[Forma]
Clave=UsuarioModuloEx
Nombre=Excepciones por Módulo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=494
PosicionInicialArriba=314
PosicionInicialAlturaCliente=368
PosicionInicialAncho=292
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
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=UsuarioModuloEx
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
FiltroGeneral=UsuarioModuloEx.Usuario=<T>{Info.Usuario}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.UsuarioModuloEx.Modulo]
Carpeta=Lista
Clave=UsuarioModuloEx.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.UsuarioModuloEx.BloquearFiltroSucursal]
Carpeta=Lista
Clave=UsuarioModuloEx.BloquearFiltroSucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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
Modulo=60
BloquearFiltroSucursal=123

[Lista.ListaEnCaptura]
(Inicio)=UsuarioModuloEx.Modulo
UsuarioModuloEx.Modulo=UsuarioModuloEx.BloquearFiltroSucursal
UsuarioModuloEx.BloquearFiltroSucursal=(Fin)
