[Forma]
Clave=SubModulo
Nombre=<T>Sub Módulos - <T>+Info.Nombre
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=238
PosicionInicialArriba=186
PosicionInicialAlturaCliente=361
PosicionInicialAncho=548
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Modulo

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SubModulo
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
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
OtroOrden=S
ListaOrden=(Lista)
FiltroGeneral=SubModulo.Modulo=<T>{Info.Modulo}<T>

[Lista.SubModulo.SubModulo]
Carpeta=Lista
Clave=SubModulo.SubModulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SubModulo.Nombre]
Carpeta=Lista
Clave=SubModulo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SubModulo.Filtrar]
Carpeta=Lista
Clave=SubModulo.Filtrar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
SubModulo=64
Nombre=304
Filtrar=109
Orden=39
NivelAcceso=120

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

[Lista.SubModulo.Orden]
Carpeta=Lista
Clave=SubModulo.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
ActivoCondicion=SubModulo:SubModulo.SubModulo<>SubModulo:SubModulo.Modulo
ConCondicion=S
EjecucionCondicion=SubModulo:SubModulo.SubModulo<>SubModulo:SubModulo.Modulo
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SubModulo.SubModulo
SubModulo.SubModulo=SubModulo.Nombre
SubModulo.Nombre=SubModulo.Filtrar
SubModulo.Filtrar=SubModulo.Orden
SubModulo.Orden=(Fin)

[Lista.ListaOrden]
(Inicio)=SubModulo.Orden<TAB>(Acendente)
SubModulo.Orden<TAB>(Acendente)=SubModulo.SubModulo<TAB>(Acendente)
SubModulo.SubModulo<TAB>(Acendente)=(Fin)
