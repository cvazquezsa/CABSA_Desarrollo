[Forma]
Clave=MovTipoPlantillaOffice
Nombre=<T>Plantillas Office - <T>+Info.Nombre
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=412
PosicionInicialArriba=103
PosicionInicialAlturaCliente=501
PosicionInicialAncho=659
PosicionSeccion1=19
Menus=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
DialogoAbrir=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
Comentarios=Lista(Info.Modulo, Info.Mov)

PosicionSec1=83
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PlantillaOffice
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.PlantillaOffice.Nombre]
Carpeta=Ficha
Clave=PlantillaOffice.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PlantillaOffice.Tipo]
Carpeta=Ficha
Clave=PlantillaOffice.Tipo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PlantillaOffice.Archivo]
Carpeta=Ficha
Clave=PlantillaOffice.Archivo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Detalle]
Estilo=Hoja
Clave=Detalle
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=PlantillaOfficeD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=PlantillaOffice
LlaveLocal=PlantillaOfficeD.ID
LlaveMaestra=PlantillaOffice.ID
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
ControlRenglon=S
CampoRenglon=PlantillaOfficeD.Renglon

[Detalle.PlantillaOfficeD.Referencia]
Carpeta=Detalle
Clave=PlantillaOfficeD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.PlantillaOfficeD.Expresion]
Carpeta=Detalle
Clave=PlantillaOfficeD.Expresion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Columnas]
Referencia=141
Expresion=478

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N

[Acciones.Abrir]
Nombre=Abrir
Boton=2
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=&Abrir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=Guardar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=PlantillaOfficeA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=PlantillaOffice.Icono
IconosEstilo=Iconos grandes
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Plantillas
Filtros=S
IconosSubTitulo=<T>Nombre<T>
FiltroPredefinido=S
FiltroGrupo1=PlantillaOffice.Tipo
FiltroValida1=PlantillaOffice.Tipo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
FiltroAutoCampo=PlantillaOffice.Tipo
FiltroAutoValidar=PlantillaOffice.Tipo
FiltroTodo=S
FiltroTodoFinal=S

IconosConPaginas=S
IconosNombre=PlantillaOfficeA:PlantillaOffice.Nombre
FiltroGeneral=PlantillaOffice.Modulo=<T>{Info.Modulo}<T> AND<BR>PlantillaOffice.Mov=<T>{Info.Mov}<T>
[(Carpeta Abrir).Columnas]
0=719
1=85

[Ficha.PlantillaOffice.Icono]
Carpeta=Ficha
Clave=PlantillaOffice.Icono
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.VerDocumento]
Nombre=VerDocumento
Boton=68
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=&Documento
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=URL(General.DirectorioPlantillasOffice+<T>\<T>+PlantillaOffice:PlantillaOffice.Archivo)
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S




[Ficha.ListaEnCaptura]
(Inicio)=PlantillaOffice.Nombre
PlantillaOffice.Nombre=PlantillaOffice.Tipo
PlantillaOffice.Tipo=PlantillaOffice.Archivo
PlantillaOffice.Archivo=PlantillaOffice.Icono
PlantillaOffice.Icono=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=PlantillaOfficeD.Referencia
PlantillaOfficeD.Referencia=PlantillaOfficeD.Expresion
PlantillaOfficeD.Expresion=(Fin)




























[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=VerDocumento
VerDocumento=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=(Fin)
