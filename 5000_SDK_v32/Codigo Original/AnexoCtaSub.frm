[Forma]
Clave=AnexoCtaSub
Nombre=e(<T>Anexos<T>)+<T> - <T>+Info.Descripcion + <T> - <T> + Info.SubCuenta
Icono=61
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=127
PosicionInicialArriba=123
PosicionInicialAltura=301
PosicionInicialAncho=769
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaEscCerrar=S
Comentarios=Lista(Info.Cuenta, Info.SubCuenta)
PosicionInicialAlturaCliente=487
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
Vista=AnexoCtaSub
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaOrden=AnexoCtaSub.Orden<TAB>(Acendente)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
IconosCampo=AnexoCtaSub.Icono
IconosEstilo=Iconos grandes
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Nombre<T>
ElementosPorPagina=200
PestanaOtroNombre=S
ListaEnCaptura=(Lista)
MenuLocal=S
ListaAcciones=Examinar

IconosNombre=AnexoCtaSub:AnexoCtaSub.Nombre
FiltroGeneral=Rama=<T>{Info.Rama}<T> AND Cuenta=<T>{Info.Cuenta}<T> AND SubCuenta = <T>{Info.SubCuenta}<T>
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
0=130
1=95

2=-2
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
ClaveAccion=AnexoCtaSubCfg
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
Expresion=Caso AnexoCtaSub:AnexoCtaSub.Tipo<BR>  Es <T>Comentario<T> Entonces VerComentario(AnexoCtaSub:AnexoCtaSub.Nombre+<T> - <T>+Info.Descripcion, AnexoCtaSub:AnexoCtaSub.Comentario) <BR>  Es <T>Mensaje<T>    Entonces VerComentario(AnexoCtaSub:AnexoCtaSub.Nombre+<T> - <T>+Info.Descripcion, AnexoCtaSub:AnexoCtaSub.Comentario) <BR>  Es <T>Imagen<T>     Entonces VerImagen(AnexoCtaSub:AnexoCtaSub.Nombre+<T> - <T>+Info.Descripcion, AnexoCtaSub:AnexoCtaSub.Direccion)<BR>Sino<BR>  URL(AnexoCtaSub:AnexoCtaSub.Direccion)<BR>Fin
VisibleCondicion=ConDatos(AnexoCtaSub:AnexoCtaSub.Nombre)

[Acciones.Editar]
Nombre=Editar
Boton=78
NombreEnBoton=S
NombreDesplegar=&Editar
Multiple=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=AnexoCfg
ListaAccionesMultiples=(Lista)
Visible=S

ActivoCondicion=Info.AnexoCfg
[Lista.AnexoCtaSub.Tipo]
Carpeta=Lista
Clave=AnexoCtaSub.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AnexoCtaSub.Direccion]
Carpeta=Lista
Clave=AnexoCtaSub.Direccion
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
NombreDesplegar=&Digitalizar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
NombreEnBoton=S
Antes=S
EspacioPrevio=S
Visible=S

ActivoCondicion=Usuario.Digitalizar y Info.AnexoCfg
AntesExpresiones=DigitalizarAnexoCta(Info.Rama, Info.Cuenta)
[Acciones.Doc]
Nombre=Doc
Boton=17
NombreDesplegar=D&ocumentación
TipoAccion=Expresion
ConCondicion=S
EspacioPrevio=S
NombreEnBoton=S

Expresion=Si(Info.Rama=<T>NOM<T>, Asigna(Temp.Texto, <T>RH<T>), Asigna(Temp.Texto, Info.Rama))<BR>Si <BR> Info.AnexoCfg<BR>Entonces<BR> EditarDocumentacion(Temp.Texto, Info.Cuenta, <T>Documentación - <T>+Info.Descripcion)<BR>Sino<BR> VerDocumentacion(Temp.Texto, Info.Cuenta, <T>Documentación - <T>+Info.Descripcion)<BR>Fin
EjecucionCondicion=ConDatos(Info.Rama)
[Acciones.Movimientos]
Nombre=Movimientos
Boton=77
NombreDesplegar=&Movimientos
TipoAccion=Expresion
Activo=S
EspacioPrevio=S

Expresion=Caso Info.Rama<BR>  Es <T>CXC<T> Entonces Forma(<T>CteAnexoMov<T>)<BR>Fin
VisibleCondicion=//Info.Rama=<T>CXC<T>
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

[Acciones.BandejaEntrada]
Nombre=BandejaEntrada
Boton=84
NombreDesplegar=&Bandeja Entrada
Multiple=S
ListaAccionesMultiples=(Lista)
Antes=S

ActivoCondicion=Info.AnexoCfg
AntesExpresiones=Asigna(Info.ID, Nulo)
[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=Actualizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S



[Acciones.BandejaEntrada.ListaAccionesMultiples]
(Inicio)=BandejaEntrada
BandejaEntrada=Actualizar Forma
Actualizar Forma=(Fin)
















[Lista.ListaEnCaptura]
(Inicio)=AnexoCtaSub.Tipo
AnexoCtaSub.Tipo=AnexoCtaSub.Direccion
AnexoCtaSub.Direccion=(Fin)




[Acciones.Editar.ListaAccionesMultiples]
(Inicio)=Anexo
Anexo=Actualizar Forma
Actualizar Forma=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cambiar Estilo
Cambiar Estilo=Digitalizar
Digitalizar=Editar
Editar=BandejaEntrada
BandejaEntrada=Doc
Doc=Movimientos
Movimientos=Actualizar
Actualizar=Personalizar
Personalizar=(Fin)
