[Forma]
Clave=heExamenCurso
Icono=700
Modulos=(Todos)
ListaCarpetas=heExamenCurso
CarpetaPrincipal=heExamenCurso
DialogoAbrir=S
PosicionInicialAlturaCliente=310
PosicionInicialAncho=587
PosicionInicialIzquierda=223
PosicionInicialArriba=231
Nombre=<T>Alta de Cursos<T>
Menus=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
MenuPrincipal=&Archivo
[heExamenCurso]
Estilo=Ficha
Clave=heExamenCurso
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=heExamenCurso
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=heExamenCurso.Curso<BR>heExamenCurso.Estatus<BR>heExamenCurso.Descripcion
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Alta de Cursos
[heExamenCurso.heExamenCurso.Curso]
Carpeta=heExamenCurso
Clave=heExamenCurso.Curso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[heExamenCurso.heExamenCurso.Descripcion]
Carpeta=heExamenCurso
Clave=heExamenCurso.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=50x15
IgnoraFlujo=N
ConScroll=S
[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=heExamenCursoA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Curso<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=heExamenCurso.Descripcion
ListaOrden=heExamenCurso.Curso<TAB>(Acendente)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
BusquedaRapida=S
BusquedaEnLinea=S
PestanaOtroNombre=S
PestanaNombre=Cursos
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
IconosConPaginas=S
IconosNombre=heExamenCursoA:heExamenCurso.Curso
[(Carpeta Abrir).heExamenCurso.Descripcion]
Carpeta=(Carpeta Abrir)
Clave=heExamenCurso.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
[(Carpeta Abrir).Columnas]
0=-2
1=-2
[Acciones.Documento Nuevo]
Nombre=Documento Nuevo
Boton=1
Menu=&Archivo
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
[heExamenCurso.heExamenCurso.Estatus]
Carpeta=heExamenCurso
Clave=heExamenCurso.Estatus
Editar=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
[Acciones.Documento Abrir]
Nombre=Documento Abrir
Boton=2
Menu=&Archivo
NombreDesplegar=&Abrir
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Grabar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Salir
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S








[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BAJA
BAJA=(Fin)





[Forma.ListaAcciones]
(Inicio)=Documento Nuevo
Documento Nuevo=Documento Abrir
Documento Abrir=Aceptar
Aceptar=Cerrar
Cerrar=(Fin)
