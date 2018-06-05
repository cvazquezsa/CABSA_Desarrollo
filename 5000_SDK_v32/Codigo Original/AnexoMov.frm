[Forma]
Clave=AnexoMov
Nombre=e(<T>Anexos<T>)+<T> - <T>+Info.Descripcion
Icono=61
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=656
PosicionInicialArriba=348
PosicionInicialAltura=301
PosicionInicialAncho=608
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=468
ExpresionesAlCerrar=Asigna(Info.AnexoCfg, Falso)

[Lista]
Estilo=Iconos
PestanaNombre=Anexo(s)
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AnexoMov
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaOrden=AnexoMov.Orden<TAB>(Acendente)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
IconosCampo=AnexoMov.Icono
IconosEstilo=Iconos grandes
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Nombre<T>
ElementosPorPagina=200
PestanaOtroNombre=S
ListaEnCaptura=(Lista)
MenuLocal=S
ListaAcciones=Examinar
IconosNombre=AnexoMov:AnexoMov.Nombre
FiltroGeneral=Rama=<T>{Info.Rama}<T> AND ID={Info.ID}

[Detalle.Anexo.Nombre]
Carpeta=Detalle
Clave=Anexo.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Anexo.Direccion]
Carpeta=Detalle
Clave=Anexo.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Detalle.Anexo.Icono]
Carpeta=Detalle
Clave=Anexo.Icono
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Detalle.Anexo.Orden]
Carpeta=Detalle
Clave=Anexo.Orden
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=6

[Lista.Columnas]
Nombre=289
Direccion=321
Tipo=105
0=345
1=82

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Detalle.Anexo.Tipo]
Carpeta=Detalle
Clave=Anexo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Imagen.Anexo.Imagen]
Carpeta=Imagen
Clave=Anexo.Imagen
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Comentario.Anexo.Comentario]
Carpeta=Comentario
Clave=Anexo.Comentario
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Anexo.Comentario]
Carpeta=Detalle
Clave=Anexo.Comentario
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=N
Tamano=57x12
ColorFondo=Blanco
ColorFuente=Negro
ConScroll=N

[Acciones.Editar.Anexo]
Nombre=Anexo
Boton=0
TipoAccion=Formas
ClaveAccion=AnexoMovCfg
Activo=S
Visible=S

[Acciones.Editar.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.Cambiar Estilo]
Nombre=Cambiar Estilo
Boton=0
NombreDesplegar=Cambiar Estilo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Estilo (Iconos)
Activo=S
Visible=S

[Acciones.Examinar]
Nombre=Examinar
Boton=0
NombreDesplegar=Examinar
TipoAccion=Expresion
Activo=S
EnMenu=S
EsDefault=S
Expresion=Caso AnexoMov:AnexoMov.Tipo<BR>  Es <T>Comentario<T> Entonces VerComentario(AnexoMov:AnexoMov.Nombre+<T> - <T>+Info.Descripcion, AnexoMov:AnexoMov.Comentario) <BR>  Es <T>Mensaje<T>    Entonces VerComentario(AnexoMov:AnexoMov.Nombre+<T> - <T>+Info.Descripcion, AnexoMov:AnexoMov.Comentario) <BR>  Es <T>Imagen<T>     Entonces VerImagen(AnexoMov:AnexoMov.Nombre+<T> - <T>+Info.Descripcion, AnexoMov:AnexoMov.Direccion)<BR>Sino<BR>  URL(AnexoMov:AnexoMov.Direccion)<BR>Fin
VisibleCondicion=ConDatos(AnexoMov:AnexoMov.Nombre)

[Acciones.Editar]
Nombre=Editar
Boton=78
NombreEnBoton=S
NombreDesplegar=&Editar
Multiple=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=AnexoCfg
ListaAccionesMultiples=Anexo<BR>Actualizar Forma
Visible=S
ActivoCondicion=Info.AnexoCfg

[Lista.AnexoMov.Tipo]
Carpeta=Lista
Clave=AnexoMov.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AnexoMov.Direccion]
Carpeta=Lista
Clave=AnexoMov.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Digitalizar]
Nombre=Digitalizar
Boton=86
NombreEnBoton=S
NombreDesplegar=&Digitalizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Antes=S
ActivoCondicion=Usuario.Digitalizar y Info.AnexoCfg
AntesExpresiones=DigitalizarAnexoMov(Info.Rama, Info.ID, Info.Fecha)
Visible=S

[Acciones.BandejaEntrada]
Nombre=BandejaEntrada
Boton=84
NombreEnBoton=S
NombreDesplegar=&Bandeja Entrada
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Visible=S
Multiple=S
ListaAccionesMultiples=BandejaEntrada<BR>Actualizar Forma
Antes=S
ActivoCondicion=Info.AnexoCfg
AntesExpresiones=Asigna(Info.Cuenta, Nulo)

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=Actualizar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.BandejaEntrada.BandejaEntrada]
Nombre=BandejaEntrada
Boton=0
TipoAccion=Formas
ClaveAccion=BandejaEntrada
Activo=S
Visible=S

[Acciones.BandejaEntrada.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
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

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cambiar Estilo
Cambiar Estilo=Digitalizar
Digitalizar=Editar
Editar=BandejaEntrada
BandejaEntrada=Actualizar
Actualizar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=AnexoMov.Tipo
AnexoMov.Tipo=AnexoMov.Direccion
AnexoMov.Direccion=(Fin)
