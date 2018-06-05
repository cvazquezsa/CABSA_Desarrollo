[Forma]
Clave=FormaTipo
Nombre=Tipos Formas / Características
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=401
PosicionInicialArriba=126
PosicionInicialAlturaCliente=437
PosicionInicialAncho=564
Menus=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
DialogoAbrir=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaTipo
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
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales

[Ficha.FormaTipo.FormaTipo]
Carpeta=Ficha
Clave=FormaTipo.FormaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ficha.FormaTipo.Titulo]
Carpeta=Ficha
Clave=FormaTipo.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.FormaTipo.Encabezado]
Carpeta=Ficha
Clave=FormaTipo.Encabezado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=36x3
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.FormaTipo.Icono]
Carpeta=Ficha
Clave=FormaTipo.Icono
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.FormaTipo.Tipo]
Carpeta=Ficha
Clave=FormaTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.FormaTipo.PuedeRetroceder]
Carpeta=Ficha
Clave=FormaTipo.PuedeRetroceder
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25
EspacioPrevio=S

[Ficha.FormaTipo.PuedeCancelar]
Carpeta=Ficha
Clave=FormaTipo.PuedeCancelar
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[Ficha.FormaTipo.OrdenEspecial]
Carpeta=Ficha
Clave=FormaTipo.OrdenEspecial
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[Ficha.FormaTipo.FuenteEspecial]
Carpeta=Ficha
Clave=FormaTipo.FuenteEspecial
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25
EspacioPrevio=N

[Fuente]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Fuente Especial
Clave=Fuente
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaTipo
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
PermiteEditar=S
CondicionVisible=FormaTipo:FormaTipo.FuenteEspecial

[Fuente.FormaTipo.FuenteNombre]
Carpeta=Fuente
Clave=FormaTipo.FuenteNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Fuente.FormaTipo.FuenteEstilo]
Carpeta=Fuente
Clave=FormaTipo.FuenteEstilo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fuente.FormaTipo.FuenteTamano]
Carpeta=Fuente
Clave=FormaTipo.FuenteTamano
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Fuente.FormaTipo.FuenteColor]
Carpeta=Fuente
Clave=FormaTipo.FuenteColor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Fuente.FormaTipo.FuenteSubrayado]
Carpeta=Fuente
Clave=FormaTipo.FuenteSubrayado
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=FormaTipoA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=FormaTipo.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Tipos Formas / Características
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
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroEstatus=S
Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=FormaTipoCat
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=FormaTipoCat
FiltroAplicaEn1=FormaTipo.Categoria
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por grupos)
FiltroNull=S

IconosConPaginas=S
IconosNombre=FormaTipoA:FormaTipo.FormaTipo
[(Carpeta Abrir).Columnas]
0=124
1=255

2=-2
[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=&Nuevo
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
NombreDesplegar=&Guardar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
EspacioPrevio=S

[Ficha.FormaTipo.Estatus]
Carpeta=Ficha
Clave=FormaTipo.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

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
ActivoCondicion=no FormaTipo:FormaTipo.TieneMovimientos
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

[Acciones.Grupos]
Nombre=Grupos
Boton=47
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=&Grupos
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=FormaExtraGrupo
Activo=S
ConCondicion=S
Antes=S
Visible=S
GuardarAntes=S
EjecucionCondicion=ConDatos(FormaTipo:FormaTipo.FormaTipo)
AntesExpresiones=Asigna(Info.FormaTipo, FormaTipo:FormaTipo.FormaTipo)

[Acciones.Campos]
Nombre=Campos
Boton=47
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=&Campos
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=FormaExtraCampo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(FormaTipo:FormaTipo.FormaTipo)
AntesExpresiones=Asigna(Info.FormaTipo, FormaTipo:FormaTipo.FormaTipo)<BR>Asigna(Info.Tipo, FormaTipo:FormaTipo.Tipo)<BR>Asigna(Info.Uso, FormaTipo:FormaTipo.Uso)

[Ficha.FormaTipo.VerGrupoEnResumen]
Carpeta=Ficha
Clave=FormaTipo.VerGrupoEnResumen
Editar=S
LineaNueva=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.FormaTipo.Uso]
Carpeta=Ficha
Clave=FormaTipo.Uso
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[Ficha.FormaTipo.NombreCorto]
Carpeta=Ficha
Clave=FormaTipo.NombreCorto
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Ficha.FormaTipo.VerNombreCortoEnResumen]
Carpeta=Ficha
Clave=FormaTipo.VerNombreCortoEnResumen
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).FormaTipo.NombreCorto]
Carpeta=(Carpeta Abrir)
Clave=FormaTipo.NombreCorto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.FormaTipo.Categoria]
Carpeta=Ficha
Clave=FormaTipo.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Fondo]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Fondo
Clave=Fondo
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaTipo
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

[Fondo.FormaTipo.FondoImagen]
Carpeta=Fondo
Clave=FormaTipo.FondoImagen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Fondo.FormaTipo.FondoColor]
Carpeta=Fondo
Clave=FormaTipo.FondoColor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Categorias]
Nombre=Categorias
Boton=0
Menu=&Maestros
NombreDesplegar=&Categorías
EnMenu=S
TipoAccion=Formas
ClaveAccion=FormaTipoCat
Activo=S
Visible=S

[Acciones.Visibilidad]
Nombre=Visibilidad
Boton=47
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=&Visibilidad
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=FormaExtraVisible
ActivoCondicion=FormaTipo:FormaTipo.Uso=<T>Caracteristicas<T>
ConCondicion=S
EjecucionCondicion=ConDatos(FormaTipo:FormaTipo.FormaTipo)
Antes=S
AntesExpresiones=Asigna(Info.FormaTipo, FormaTipo:FormaTipo.FormaTipo)
Visible=S

[(Carpeta Abrir).FormaTipo.Uso]
Carpeta=(Carpeta Abrir)
Clave=FormaTipo.Uso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.FormaTipoHTML]
Nombre=FormaTipoHTML
Boton=35
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=&Correo Electrónico
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=FormaTipoHTML
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(FormaTipo:FormaTipo.FormaTipo)
AntesExpresiones=Asigna(Info.FormaTipo, FormaTipo:FormaTipo.FormaTipo)

[Acciones.GenerarHTML]
Nombre=GenerarHTML
Boton=20
Menu=&Edición
NombreDesplegar=&Sugerir Correo Electrónico
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=PlugIn(<T>GenerarHTML<T>, FormaTipo:FormaTipo.FormaTipo, FormaTipo:FormaTipo.NombreCorto)




[Ficha.ListaEnCaptura]
(Inicio)=FormaTipo.FormaTipo
FormaTipo.FormaTipo=FormaTipo.NombreCorto
FormaTipo.NombreCorto=FormaTipo.Categoria
FormaTipo.Categoria=FormaTipo.Titulo
FormaTipo.Titulo=FormaTipo.Encabezado
FormaTipo.Encabezado=FormaTipo.Icono
FormaTipo.Icono=FormaTipo.Uso
FormaTipo.Uso=FormaTipo.Tipo
FormaTipo.Tipo=FormaTipo.Estatus
FormaTipo.Estatus=FormaTipo.PuedeRetroceder
FormaTipo.PuedeRetroceder=FormaTipo.PuedeCancelar
FormaTipo.PuedeCancelar=FormaTipo.VerGrupoEnResumen
FormaTipo.VerGrupoEnResumen=FormaTipo.VerNombreCortoEnResumen
FormaTipo.VerNombreCortoEnResumen=FormaTipo.FuenteEspecial
FormaTipo.FuenteEspecial=FormaTipo.OrdenEspecial
FormaTipo.OrdenEspecial=(Fin)

[Fuente.ListaEnCaptura]
(Inicio)=FormaTipo.FuenteNombre
FormaTipo.FuenteNombre=FormaTipo.FuenteEstilo
FormaTipo.FuenteEstilo=FormaTipo.FuenteTamano
FormaTipo.FuenteTamano=FormaTipo.FuenteColor
FormaTipo.FuenteColor=FormaTipo.FuenteSubrayado
FormaTipo.FuenteSubrayado=(Fin)



[Fondo.ListaEnCaptura]
(Inicio)=FormaTipo.FondoImagen
FormaTipo.FondoImagen=FormaTipo.FondoColor
FormaTipo.FondoColor=(Fin)



















[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=FormaTipo.NombreCorto
FormaTipo.NombreCorto=FormaTipo.Uso
FormaTipo.Uso=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)




[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Fuente
Fuente=Fondo
Fondo=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=Grupos
Grupos=Campos
Campos=Visibilidad
Visibilidad=GenerarHTML
GenerarHTML=FormaTipoHTML
FormaTipoHTML=Navegador
Navegador=Cerrar
Cerrar=Categorias
Categorias=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)
