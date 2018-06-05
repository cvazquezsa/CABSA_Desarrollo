[Forma]
Clave=UsuarioMenuOpcion
Nombre=Acceso Menú del Usuario 
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=677
PosicionInicialArriba=301
PosicionInicialAlturaCliente=562
PosicionInicialAncho=575
Comentarios=Lista(Info.Usuario, Info.Menu)
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
Vista=UsuarioMenuOpcion
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
FiltroGeneral=UsuarioMenuOpcion.Usuario=<T>{Info.Usuario}<T> AND UsuarioMenuOpcion.Menu=<T>{Info.Menu}<T>

[Lista.UsuarioMenuOpcion.Opcion]
Carpeta=Lista
Clave=UsuarioMenuOpcion.Opcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MenuOpcion.Nombre]
Carpeta=Lista
Clave=MenuOpcion.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

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
Opcion=118
Nombre=248
Tipo=84
Estatus=84

[Acciones.Borrar]
Nombre=Borrar
Boton=5
NombreDesplegar=Borrar &Todo
EnBarraHerramientas=S
EspacioPrevio=S
ConfirmarAntes=S
TipoAccion=Expresion
Activo=S
Visible=S
NombreEnBoton=S
Expresion=EjecutarSQL(<T>spUsuarioMenuOpcionBorrar :tUsuario, :tMenu<T>, Info.Usuario, Info.Menu)<BR>Forma.ActualizarVista(<T>Lista<T>)

[Lista.MenuOpcion.Tipo]
Carpeta=Lista
Clave=MenuOpcion.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Lista.UsuarioMenuOpcion.Estatus]
Carpeta=Lista
Clave=UsuarioMenuOpcion.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Borrar
Borrar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=UsuarioMenuOpcion.Opcion
UsuarioMenuOpcion.Opcion=MenuOpcion.Tipo
MenuOpcion.Tipo=MenuOpcion.Nombre
MenuOpcion.Nombre=UsuarioMenuOpcion.Estatus
UsuarioMenuOpcion.Estatus=(Fin)
