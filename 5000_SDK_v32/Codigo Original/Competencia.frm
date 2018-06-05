
[Forma]
Clave=Competencia
Icono=4
Modulos=(Todos)
Nombre=Competencias

ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=411
PosicionInicialArriba=189
PosicionInicialAlturaCliente=330
PosicionInicialAncho=662
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionCol1=434
DialogoAbrir=S

Menus=S
ListaAcciones=(Lista)
MenuPrincipal=(Lista)
[Lista.Competencia.Competencia]
Carpeta=Lista
Clave=Competencia.Competencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Competencia.Nombre]
Carpeta=Lista
Clave=Competencia.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco




[Lista.Columnas]
Competencia=113
Nombre=277
Descripcion=236
Categoria=267
Estatus=115




[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Competencia
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
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Ficha.Competencia.Competencia]
Carpeta=Ficha
Clave=Competencia.Competencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

Efectos=[Negritas]
[Ficha.Competencia.Nombre]
Carpeta=Ficha
Clave=Competencia.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco

[Ficha.Competencia.Descripcion]
Carpeta=Ficha
Clave=Competencia.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80x3
ColorFondo=Blanco

[Ficha.Competencia.Categoria]
Carpeta=Ficha
Clave=Competencia.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

EspacioPrevio=S
[Ficha.Competencia.Grupo]
Carpeta=Ficha
Clave=Competencia.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.Competencia.Familia]
Carpeta=Ficha
Clave=Competencia.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.Competencia.Estatus]
Carpeta=Ficha
Clave=Competencia.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco










[Lista.ListaEnCaptura]
(Inicio)=Competencia.Competencia
Competencia.Competencia=Competencia.Nombre
Competencia.Nombre=(Fin)







[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=CompetenciaA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

Filtros=S
BusquedaRapidaControles=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por grupos)
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
PestanaOtroNombre=S
PestanaNombre=Competencias
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CompetenciaCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CompetenciaGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CompetenciaFam
FiltroAplicaEn1=Competencia.Categoria
FiltroAplicaEn2=Competencia.Grupo
FiltroAplicaEn3=Competencia.Familia
FiltroTodo=S
FiltroTodoFinal=S
IconosConPaginas=S
IconosNombre=CompetenciaA:Competencia.Competencia
[(Carpeta Abrir).Competencia.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Competencia.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco







[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)





[(Carpeta Abrir).Columnas]
0=190
1=164
2=93
3=139
4=-2






[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=<T>&Nuevo<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S


[Acciones.Abrir]
Nombre=Abrir
Boton=2
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=<T>&Abrir...<T>
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
NombreDesplegar=<T>&Guardar Cambios<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S





[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Activo=S
Visible=S



[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=<T>&Cerrar<T>
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S





[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S







[Acciones.CompetenciaCat]
Nombre=CompetenciaCat
Boton=0
Menu=&Maestros
NombreDesplegar=<T>&Categorías<T>
EnMenu=S
TipoAccion=Formas
ClaveAccion=CompetenciaCat
Activo=S
Visible=S



EspacioPrevio=S
[Acciones.CompetenciaGrupo]
Nombre=CompetenciaGrupo
Boton=0
Menu=&Maestros
NombreDesplegar=<T>&Grupos<T>
EnMenu=S
TipoAccion=Formas
ClaveAccion=CompetenciaGrupo
Activo=S
Visible=S



[Acciones.CompetenciaFam]
Nombre=CompetenciaFam
Boton=0
Menu=&Maestros
NombreDesplegar=<T>&Familias<T>
EnMenu=S
TipoAccion=Formas
ClaveAccion=CompetenciaFam
Activo=S
Visible=S



























[(Carpeta Abrir).Competencia.Tipo]
Carpeta=(Carpeta Abrir)
Clave=Competencia.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco







[Ficha.Competencia.Tipo]
Carpeta=Ficha
Clave=Competencia.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=50
ColorFondo=Blanco



[Acciones.CompetenciaTipo]
Nombre=CompetenciaTipo
Boton=0
Menu=&Maestros
NombreDesplegar=<T>&Tipos<T>
EnMenu=S
TipoAccion=Formas
ClaveAccion=CompetenciaTipo
Activo=S
Visible=S

































[Acciones.Resultados]
Nombre=Resultados
Boton=47
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=<T>&Resultados<T>
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CompetenciaResultado
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Competencia:Competencia.Competencia)
Antes=S
AntesExpresiones=Asigna(Info.Competencia, Competencia:Competencia.Competencia)<BR>Asigna(Info.Nombre, Competencia:Competencia.Nombre)
Visible=S




















[Ficha.ListaEnCaptura]
(Inicio)=Competencia.Competencia
Competencia.Competencia=Competencia.Nombre
Competencia.Nombre=Competencia.Descripcion
Competencia.Descripcion=Competencia.Tipo
Competencia.Tipo=Competencia.Categoria
Competencia.Categoria=Competencia.Grupo
Competencia.Grupo=Competencia.Familia
Competencia.Familia=Competencia.Estatus
Competencia.Estatus=(Fin)

































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Competencia.Nombre
Competencia.Nombre=Competencia.Tipo
Competencia.Tipo=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)



[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=Cerrar
Cerrar=Resultados
Resultados=Navegador
Navegador=CompetenciaTipo
CompetenciaTipo=CompetenciaCat
CompetenciaCat=CompetenciaGrupo
CompetenciaGrupo=CompetenciaFam
CompetenciaFam=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)
