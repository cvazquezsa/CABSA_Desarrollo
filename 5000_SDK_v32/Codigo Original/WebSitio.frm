[Forma]
Clave=WebSitio
Nombre=Sitios Web
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=220
PosicionInicialArriba=202
PosicionInicialAlturaCliente=361
PosicionInicialAncho=840
DialogoAbrir=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Menus=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
BarraAyuda=S

VentanaEscCerrar=S
VentanaEstadoInicial=Normal
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebSitio
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

[Ficha.WebSitio.Nombre]
Carpeta=Ficha
Clave=WebSitio.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebSitio.Descripcion]
Carpeta=Ficha
Clave=WebSitio.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebSitio.Estatus]
Carpeta=Ficha
Clave=WebSitio.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=WebSitioA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>Clave<T>
BusquedaRapidaControles=S
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
FiltroUsuarioDefault=(Todos)
PestanaOtroNombre=S
PestanaNombre=Sitios Web
IconosNombre=WebSitioA:WebSitio.Sitio
ListaEnCaptura=(Lista)

[(Carpeta Abrir).Columnas]
0=136
1=231

2=-2
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
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
EspacioPrevio=S
ActivoCondicion=SQL(<T>SELECT COUNT(*) FROM WebSitioD WHERE Sitio=:tSitio<T>, WebSitio:WebSitio.Sitio)=0

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

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Si<BR>  WebSitio:WebSitio.VerBienvenida<BR>Entonces<BR>   Si<BR>     Longitud( WebSitio:WebSitio.LeyendaBienvenida ) >0<BR>   Entonces<BR>     VERDADERO<BR>   Sino<BR>     FALSO <BR>   Fin<BR>Fin<BR><BR>Si<BR>   WebSitio:WebSitio.VerSPinformacion<BR>Entonces<BR>   Si<BR>     Longitud(WebSitio:WebSitio.SPinformacion) >0<BR>   Entonces<BR>     VERDADERO<BR>   Sino<BR>     FALSO <BR>   Fin<BR>Fin
EjecucionMensaje=Si<BR>  Longitud( WebSitio:WebSitio.LeyendaBienvenida )  <=0<BR>Entonces<BR>  <T>El campo de mensaje de bienvenida debe contener algun valor<T><BR>Fin<BR><BR>Si<BR>  Longitud(WebSitio:WebSitio.SPinformacion)  <=0<BR>Entonces<BR>  <T>El campo de SP Informacion debe contener algun valor<T><BR>Fin
[Ficha.WebSitio.Sitio]
Carpeta=Ficha
Clave=WebSitio.Sitio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebSitio.URL_Sitio]
Carpeta=Ficha
Clave=WebSitio.URL_Sitio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Menu]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Menú
Clave=Menu
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebSitio
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=139
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S



FichaAlineacionDerecha=S
[Acciones.Encabezado]
Nombre=Encabezado
Boton=35
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=&Encabezado
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Asigna(WebSitio:WebSitio.EncabezadoHTML, EditorHTML.Directo(<T>Encabezado - <T>+WebSitio:WebSitio.Nombre, WebSitio:WebSitio.EncabezadoHTML))

[Acciones.Pie]
Nombre=Pie
Boton=35
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=&Pie
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(WebSitio:WebSitio.PieHTML, EditorHTML.Directo(<T>Pie - <T>+WebSitio:WebSitio.Nombre, WebSitio:WebSitio.PieHTML))
Activo=S
Visible=S

[Acciones.Contenido]
Nombre=Contenido
Boton=47
NombreEnBoton=S
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=&Contenido
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=WebSitioD
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(WebSitio:WebSitio.Sitio)
AntesExpresiones=Asigna(Info.Sitio, WebSitio:WebSitio.Sitio)<BR>Asigna(Info.Nombre, WebSitio:WebSitio.Nombre)<BR>Asigna(Info.Posicion, WebSitio:WebSitio.MenuPosicion)<BR>Asigna(Ver.Posicion, WebSitio:WebSitio.MenuPosicionNivelDetalle)<BR>Asigna(Info.PuedeEditar, WebSitio:WebSitio.Estatus<>EstatusPublicado)

[(Carpeta Abrir).WebSitio.Nombre]
Carpeta=(Carpeta Abrir)
Clave=WebSitio.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).WebSitio.Descripcion]
Carpeta=(Carpeta Abrir)
Clave=WebSitio.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Estilo.WebSitio.PaginaInicio]
Carpeta=Estilo
Clave=WebSitio.PaginaInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Estilo.WebPagina.Nombre]
Carpeta=Estilo
Clave=WebPagina.Nombre
Editar=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Estilo.WebSitio.Estilo]
Carpeta=Estilo
Clave=WebSitio.Estilo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebSitio.Estilo]
Carpeta=Ficha
Clave=WebSitio.Estilo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=46
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.WebSitio.PaginaInicio]
Carpeta=Ficha
Clave=WebSitio.PaginaInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebPagina.Nombre]
Carpeta=Ficha
Clave=WebPagina.Nombre
Editar=S
3D=S
Tamano=79
ColorFondo=Plata
ColorFuente=Negro


[Ficha.WebSitio.URL_Documentos]
Carpeta=Ficha
Clave=WebSitio.URL_Documentos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebSitio.RutaDocumentos]
Carpeta=Ficha
Clave=WebSitio.RutaDocumentos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Documentos]
Nombre=Documentos
Boton=47
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=&Documentos
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=WebSitioDoc
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(WebSitio:WebSitio.Sitio)
Antes=S
AntesExpresiones=Asigna(Info.Sitio, WebSitio:WebSitio.Sitio)<BR>Asigna(Info.Nombre, WebSitio:WebSitio.Nombre)<BR>Asigna(Info.Directorio, WebSitio:WebSitio.RutaDocumentos)<BR>Si(Medio(Info.Directorio, Longitud(Info.Directorio), 1)<><T>\<T>, Asigna(Info.Directorio, Info.Directorio+<T>\<T>))



[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=PUBLICADO
PUBLICADO=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=WebSitio.Nombre
WebSitio.Nombre=WebSitio.Descripcion
WebSitio.Descripcion=(Fin)








[Lista.Columnas]
0=185
1=237
2=-2




































[Ficha.ListaEnCaptura]
(Inicio)=WebSitio.Sitio
WebSitio.Sitio=WebSitio.Estilo
WebSitio.Estilo=WebSitio.Estatus
WebSitio.Estatus=WebSitio.Nombre
WebSitio.Nombre=WebSitio.Descripcion
WebSitio.Descripcion=WebSitio.PaginaInicio
WebSitio.PaginaInicio=WebPagina.Nombre
WebPagina.Nombre=WebSitio.URL_Sitio
WebSitio.URL_Sitio=WebSitio.URL_Documentos
WebSitio.URL_Documentos=WebSitio.RutaDocumentos
WebSitio.RutaDocumentos=WebSitio.NivelAcceso
WebSitio.NivelAcceso=(Fin)

[Ficha.WebSitio.NivelAcceso]
Carpeta=Ficha
Clave=WebSitio.NivelAcceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro





































[Acciones.Acceso Especifico]
Nombre=Acceso Especifico
Boton=0
Menu=&Edición
NombreDesplegar=Acceso Especifico
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=WebSitioAcceso
Activo=S










ConCondicion=S
Antes=S






















































EspacioPrevio=S






























EjecucionCondicion=ConDatos(WebSitio:WebSitio.Sitio)
AntesExpresiones=Asigna(Info.Sitio, WebSitio:WebSitio.Sitio )
VisibleCondicion=General.NivelAccesoEsp y (WebSitio:WebSitio.NivelAcceso=<T>(Especifico)<T>)



















[Menu.WebSitio.MenuPosicion]
Carpeta=Menu
Clave=WebSitio.MenuPosicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro





[Menu.WebSitio.MenuFondoColor]
Carpeta=Menu
Clave=WebSitio.MenuFondoColor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro















[Menu.WebSitio.MenuPosicionNivelDetalle]
Carpeta=Menu
Clave=WebSitio.MenuPosicionNivelDetalle
Editar=S
3D=S
Pegado=N
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

























































































[Menu.WebSitio.AnchoMenuEncabezado]
Carpeta=Menu
Clave=WebSitio.AnchoMenuEncabezado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

Tamano=20
[Menu.WebSitio.AnchoMenuCuerpo]
Carpeta=Menu
Clave=WebSitio.AnchoMenuCuerpo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

Tamano=20
[Menu.WebSitio.AnchoMenuPie]
Carpeta=Menu
Clave=WebSitio.AnchoMenuPie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

Tamano=20































[Configuracion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Configuracion
Clave=Configuracion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebSitio
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S




ListaEnCaptura=(Lista)



FichaEspacioEntreLineas=6
FichaEspacioNombres=148
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
[Menu.ListaEnCaptura]
(Inicio)=WebSitio.MenuPosicion
WebSitio.MenuPosicion=WebSitio.MenuPosicionNivelDetalle
WebSitio.MenuPosicionNivelDetalle=WebSitio.MenuFondoColor
WebSitio.MenuFondoColor=WebSitio.AnchoMenuEncabezado
WebSitio.AnchoMenuEncabezado=WebSitio.AnchoMenuCuerpo
WebSitio.AnchoMenuCuerpo=WebSitio.AnchoMenuPie
WebSitio.AnchoMenuPie=(Fin)


[Configuracion.WebSitio.BotonAcceso]
Carpeta=Configuracion
Clave=WebSitio.BotonAcceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.WebSitio.LeyendaAcceso]
Carpeta=Configuracion
Clave=WebSitio.LeyendaAcceso
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

Pegado=S
[Configuracion.WebSitio.VerExplorador]
Carpeta=Configuracion
Clave=WebSitio.VerExplorador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

EspacioPrevio=S
[Configuracion.WebSitio.VerCalendario]
Carpeta=Configuracion
Clave=WebSitio.VerCalendario
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.WebSitio.OlvidoClave]
Carpeta=Configuracion
Clave=WebSitio.OlvidoClave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

EspacioPrevio=S
[Configuracion.WebSitio.PaginaOlvidoClave]
Carpeta=Configuracion
Clave=WebSitio.PaginaOlvidoClave
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

Pegado=S
[Configuracion.WebSitio.VerBotonPerfil]
Carpeta=Configuracion
Clave=WebSitio.VerBotonPerfil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.WebSitio.LeyendaBotonPerfil]
Carpeta=Configuracion
Clave=WebSitio.LeyendaBotonPerfil
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

Pegado=S
[Configuracion.WebSitio.VerBienvenida]
Carpeta=Configuracion
Clave=WebSitio.VerBienvenida
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.WebSitio.LeyendaBienvenida]
Carpeta=Configuracion
Clave=WebSitio.LeyendaBienvenida
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

Pegado=S
[Configuracion.WebSitio.VerSPinformacion]
Carpeta=Configuracion
Clave=WebSitio.VerSPinformacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

EspacioPrevio=S
[Configuracion.WebSitio.SPinformacion]
Carpeta=Configuracion
Clave=WebSitio.SPinformacion
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro




Pegado=S
[Configuracion.Columnas]
BotonAcceso=69
LeyendaAcceso=304
VerExplorador=64
VerCalendario=64
OlvidoClave=64
VerBotonPerfil=64
VerBienvenida=99
VerSPinformacion=79
SPinformacion=304














[Configuracion.WebSitio.IniciaPaginaPerfil]
Carpeta=Configuracion
Clave=WebSitio.IniciaPaginaPerfil
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro























[Configuracion.WebSitio.spSesion]
Carpeta=Configuracion
Clave=WebSitio.spSesion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.WebSitio.spOrigen]
Carpeta=Configuracion
Clave=WebSitio.spOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.WebSitio.spPagina]
Carpeta=Configuracion
Clave=WebSitio.spPagina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro


























[Configuracion.ListaEnCaptura]
(Inicio)=WebSitio.BotonAcceso
WebSitio.BotonAcceso=WebSitio.LeyendaAcceso
WebSitio.LeyendaAcceso=WebSitio.VerBienvenida
WebSitio.VerBienvenida=WebSitio.LeyendaBienvenida
WebSitio.LeyendaBienvenida=WebSitio.VerSPinformacion
WebSitio.VerSPinformacion=WebSitio.SPinformacion
WebSitio.SPinformacion=WebSitio.spSesion
WebSitio.spSesion=WebSitio.spOrigen
WebSitio.spOrigen=WebSitio.spPagina
WebSitio.spPagina=WebSitio.OlvidoClave
WebSitio.OlvidoClave=WebSitio.PaginaOlvidoClave
WebSitio.PaginaOlvidoClave=WebSitio.VerBotonPerfil
WebSitio.VerBotonPerfil=WebSitio.LeyendaBotonPerfil
WebSitio.LeyendaBotonPerfil=WebSitio.IniciaPaginaPerfil
WebSitio.IniciaPaginaPerfil=WebSitio.VerExplorador
WebSitio.VerExplorador=WebSitio.VerCalendario
WebSitio.VerCalendario=(Fin)

































































































































































































[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Menu
Menu=Configuracion
Configuracion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=Cerrar
Cerrar=Encabezado
Encabezado=Pie
Pie=Contenido
Contenido=Documentos
Documentos=Navegador
Navegador=Acceso Especifico
Acceso Especifico=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)
