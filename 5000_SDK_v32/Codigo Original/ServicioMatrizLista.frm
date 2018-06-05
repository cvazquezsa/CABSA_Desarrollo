[Forma]
Clave=ServicioMatrizLista
Icono=1
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=196
PosicionInicialArriba=237
PosicionInicialAlturaCliente=523
PosicionInicialAncho=887
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Nombre=Matriz de Servicios
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.ArtVersion, Info.Mov, Info.MovID)
VentanaExclusiva=S
ExpresionesAlMostrar=Asigna(Ver.Todo, Falso)<BR>Asigna(Ver.Descripcion, <T>&Sin Vigencia<T>)

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Servicios
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ServicioMatriz
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=ServicioMatriz.Modelo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroAncho=30
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
IconosSeleccionMultiple=S
FiltroTodo=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroGrupo2=ServicioMatriz.Motor
FiltroGrupo3=ServicioMatriz.Cilindros
FiltroGrupo4=ServicioMatriz.Transmision
FiltroGrupo5=ServicioMatriz.Traccion
FiltroGrupo6=ServicioMatriz.Paquete
IconosNombre=ServicioMatriz:ServicioMatriz.Articulo
FiltroGeneral=ServicioMatriz.Vehiculo=<T>{Info.ArtVersion}<T><BR>{Si(no Ver.Todo, <T> AND (GETDATE() BETWEEN ServicioMatriz.VigenciaD AND ServicioMatriz.VigenciaA OR (ServicioMatriz.VigenciaA IS NULL AND (ServicioMatriz.VigenciaD IS NULL OR ServicioMatriz.VigenciaD < GETDATE())))<T>, <T><T>)}

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioMatriz.Unidad]
Carpeta=Lista
Clave=ServicioMatriz.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioMatriz.Cantidad]
Carpeta=Lista
Clave=ServicioMatriz.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=111
1=229

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
Antes=S
AntesExpresiones=RegistrarSeleccionID(<T>Lista<T>)<BR>EjecutarSQL(<T>spGenerarMatrizServicio :nEstacion, :nID<T>,  EstacionTrabajo, Info.ID)

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=55
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S
NombreEnBoton=S
EspacioPrevio=S

[Acciones.LocalTodo]
Nombre=LocalTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.LocalQuitar]
Nombre=LocalQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.Ver]
Nombre=Ver
Boton=107
NombreEnBoton=S
NombreDesplegar=Ver.Descripcion
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Activo=S
Expresion=Asigna(Ver.Todo, no Ver.Todo)<BR>Si(Ver.Todo, Asigna(Ver.Descripcion, <T>&Con Vigencia<T>), Asigna(Ver.Descripcion, <T>&Sin Vigencia<T>))<BR>Forma.ActualizarVista

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cancelar
Cancelar=Seleccionar Todo
Seleccionar Todo=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=Ver
Ver=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=ServicioMatriz.Unidad
ServicioMatriz.Unidad=ServicioMatriz.Cantidad
ServicioMatriz.Cantidad=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)
