[Forma]
Clave=FormaVirtualAccion
Nombre=Acciones de la Forma Virtual
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.FormaVirtual
PosicionInicialIzquierda=575
PosicionInicialArriba=306
PosicionInicialAlturaCliente=552
PosicionInicialAncho=770
VentanaTipoMarco=Normal
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
Vista=FormaVirtualAccion
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaAjustarColumnas=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
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
FiltroGeneral=FormaVirtualAccion.FormaVirtual=<T>{Info.FormaVirtual}<T>

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
Menu=135
SubMenu=148
Nombre=219
Etiqueta=233
Invisible=46
Bloqueado=53
Accion=188
Visible=44
Activo=44

[Lista.FormaVirtualAccion.Accion]
Carpeta=Lista
Clave=FormaVirtualAccion.Accion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[Lista.FormaVirtualAccion.Nombre]
Carpeta=Lista
Clave=FormaVirtualAccion.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[Lista.FormaVirtualAccion.Etiqueta]
Carpeta=Lista
Clave=FormaVirtualAccion.Etiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.FormaVirtualAccion.Visible]
Carpeta=Lista
Clave=FormaVirtualAccion.Visible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.FormaVirtualAccion.Activo]
Carpeta=Lista
Clave=FormaVirtualAccion.Activo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=FormaVirtualAccion.Accion
FormaVirtualAccion.Accion=FormaVirtualAccion.Nombre
FormaVirtualAccion.Nombre=FormaVirtualAccion.Etiqueta
FormaVirtualAccion.Etiqueta=FormaVirtualAccion.Visible
FormaVirtualAccion.Visible=FormaVirtualAccion.Activo
FormaVirtualAccion.Activo=(Fin)
