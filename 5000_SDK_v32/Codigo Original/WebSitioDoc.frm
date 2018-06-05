[Forma]
Clave=WebSitioDoc
Nombre=Documentos del Sitio
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=528
PosicionInicialArriba=179
PosicionInicialAlturaCliente=349
PosicionInicialAncho=428
Comentarios=Info.Sitio
PosicionCol1=468
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Menus=S
DialogoAbrir=S

VentanaEstadoInicial=Normal
MenuPrincipal=(Lista)
[Lista.WebSitioDoc.Nombre]
Carpeta=Lista
Clave=WebSitioDoc.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Nombre=292
Descripcion=177
Categoria=192
Grupo=164
Familia=94
RID=64
ID=47

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebSitioDoc
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

[Ficha.WebSitioDoc.Nombre]
Carpeta=Ficha
Clave=WebSitioDoc.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=56
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebSitioDoc.Descripcion]
Carpeta=Ficha
Clave=WebSitioDoc.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=56x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebSitioDoc.Categoria]
Carpeta=Ficha
Clave=WebSitioDoc.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=56
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebSitioDoc.Grupo]
Carpeta=Ficha
Clave=WebSitioDoc.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=56
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebSitioDoc.Familia]
Carpeta=Ficha
Clave=WebSitioDoc.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=56
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Subir]
Nombre=Subir
Boton=26
NombreEnBoton=S
NombreDesplegar=&Subir Documento
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
ConCondicion=S
Menu=&Edición
EnMenu=S
Expresion=Asigna(Temp.Texto, BuscarArchivo(<T><T>, <T><T>, <T>*<T>, <T>Documento<T>, <T>Documentos<T>))<BR>Si<BR>  Temp.Texto<><T><T><BR>Entonces<BR>  Asigna(WebSitioDoc:WebSitioDoc.Archivo, WebSitioDoc:WebSitioDoc.Documento+Archivo.Extencion(Temp.Texto))<BR>  CopiarArchivo(Temp.Texto, Info.Directorio+WebSitioDoc:WebSitioDoc.Archivo)<BR>Fin
EjecucionCondicion=ConDatos(WebSitioDoc:WebSitioDoc.Documento)

[Acciones.Editar]
Nombre=Editar
Boton=35
NombreEnBoton=S
NombreDesplegar=&Editar Documento
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
ConCondicion=S
Menu=&Edición
EnMenu=S
Expresion=URL(Info.Directorio+WebSitioDoc:WebSitioDoc.Archivo)
EjecucionCondicion=ConDatos(WebSitioDoc:WebSitioDoc.Archivo)

[Ficha.WebSitioDoc.Archivo]
Carpeta=Ficha
Clave=WebSitioDoc.Archivo
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Categoria]
Nombre=Categoria
Boton=91
NombreEnBoton=S
NombreDesplegar=&Categorías
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=WebSitioDocCat
Activo=S
Visible=S
Menu=&Maestros
EnMenu=S

[Acciones.Grupo]
Nombre=Grupo
Boton=91
NombreEnBoton=S
NombreDesplegar=G&rupos
TipoAccion=Formas
ClaveAccion=WebSitioDocGrupo
Activo=S
Visible=S
Menu=&Maestros
EnMenu=S

[Acciones.Familia]
Nombre=Familia
Boton=91
NombreDesplegar=&Familias
TipoAccion=Formas
ClaveAccion=WebSitioDocFam
Activo=S
Visible=S
NombreEnBoton=S
Menu=&Maestros
EnMenu=S

[Ficha.WebSitioDoc.Documento]
Carpeta=Ficha
Clave=WebSitioDoc.Documento
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

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

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Activo=S
Visible=S
EnBarraHerramientas=S
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

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=WebSitioDocA
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
PestanaOtroNombre=S
MenuLocal=S
ListaAcciones=Personalizar
PestanaNombre=Documentos del Sitio

IconosConPaginas=S
IconosNombre=WebSitioDocA:WebSitioDoc.Documento
FiltroGeneral=WebSitioDoc.Sitio=<T>{Info.Sitio}<T>
[(Carpeta Abrir).WebSitioDoc.Nombre]
Carpeta=(Carpeta Abrir)
Clave=WebSitioDoc.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[(Carpeta Abrir).WebSitioDoc.Descripcion]
Carpeta=(Carpeta Abrir)
Clave=WebSitioDoc.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[(Carpeta Abrir).Columnas]
0=90
1=300

2=-2
[Acciones.Personalizar]
Nombre=Personalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S
EnBarraHerramientas=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S





[Ficha.ListaEnCaptura]
(Inicio)=WebSitioDoc.Documento
WebSitioDoc.Documento=WebSitioDoc.Archivo
WebSitioDoc.Archivo=WebSitioDoc.Nombre
WebSitioDoc.Nombre=WebSitioDoc.Descripcion
WebSitioDoc.Descripcion=WebSitioDoc.Categoria
WebSitioDoc.Categoria=WebSitioDoc.Grupo
WebSitioDoc.Grupo=WebSitioDoc.Familia
WebSitioDoc.Familia=(Fin)
























[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=WebSitioDoc.Nombre
WebSitioDoc.Nombre=WebSitioDoc.Descripcion
WebSitioDoc.Descripcion=(Fin)





[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=Subir
Subir=Editar
Editar=Categoria
Categoria=Grupo
Grupo=Familia
Familia=Cerrar
Cerrar=Navegador
Navegador=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)
