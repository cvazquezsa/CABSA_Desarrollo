[Forma]
Clave=WebPaginaAcceso
Nombre=Control Acceso
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=747
PosicionInicialArriba=377
PosicionInicialAlturaCliente=409
PosicionInicialAncho=426
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Pagina
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebPaginaAcceso
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
FiltroGeneral=WebPaginaAcceso.Pagina=<T>{Info.Pagina}<T>

[Lista.WebPaginaAcceso.Rol]
Carpeta=Lista
Clave=WebPaginaAcceso.Rol
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S

[Lista.Columnas]
Rol=304
PermiteEditarContenido=84

[Lista.WebPaginaAcceso.PermiteEditarContenido]
Carpeta=Lista
Clave=WebPaginaAcceso.PermiteEditarContenido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=WebPaginaAcceso.Rol
WebPaginaAcceso.Rol=WebPaginaAcceso.PermiteEditarContenido
WebPaginaAcceso.PermiteEditarContenido=(Fin)
