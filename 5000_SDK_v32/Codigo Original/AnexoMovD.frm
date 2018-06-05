[Forma]
Clave=AnexoMovD
Nombre=e(<T>Anexos<T>)+<T> - <T>+Info.Descripcion
Icono=61
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=641
PosicionInicialArriba=347
PosicionInicialAltura=301
PosicionInicialAncho=638
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaEscCerrar=S
Comentarios=Info.Cuenta
ExpresionesAlCerrar=Asigna(Info.AnexoCfg, Falso)
PosicionInicialAlturaCliente=472

[Lista]
Estilo=Iconos
PestanaNombre=Anexo(s)
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AnexoMovD
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaOrden=AnexoMovD.Orden<TAB>(Acendente)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
IconosCampo=AnexoMovD.Icono
IconosEstilo=Iconos grandes
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Nombre<T>
ElementosPorPagina=200
PestanaOtroNombre=S
ListaEnCaptura=(Lista)
MenuLocal=S
ListaAcciones=Examinar
IconosNombre=AnexoMovD:AnexoMovD.Nombre
FiltroGeneral=Rama=<T>{Info.Rama}<T> AND ID={Info.ID} AND Cuenta=<T>{Info.Cuenta}<T>

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
0=118
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
ClaveAccion=AnexoMovDCfg
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
Expresion=Caso AnexoMovD:AnexoMovD.Tipo<BR>  Es <T>Comentario<T> Entonces  VerComentario(AnexoMovD:AnexoMovD.Nombre+<T> - <T>+Info.Descripcion, AnexoMovD:AnexoMovD.Comentario) <BR>  Es <T>Imagen<T> Entonces VerImagen(AnexoMovD:AnexoMovD.Nombre+<T> - <T>+Info.Descripcion, AnexoMovD:AnexoMovD.Direccion)<BR>Sino<BR>  URL(AnexoMovD:AnexoMovD.Direccion)<BR>Fin
VisibleCondicion=ConDatos(AnexoMovD:AnexoMovD.Nombre)

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

[Lista.AnexoMovD.Tipo]
Carpeta=Lista
Clave=AnexoMovD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AnexoMovD.Direccion]
Carpeta=Lista
Clave=AnexoMovD.Direccion
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
AntesExpresiones=DigitalizarAnexoMovD(Info.Rama, Info.ID, Info.Fecha, Info.Cuenta)
Visible=S

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar &Orden
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
AntesExpresiones=Forma(<T>AnexoMovDOrdenar<T>)
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
NombreEnBoton=S
NombreDesplegar=&Bandeja Entrada
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=BandejaEntrada<BR>Actualizar Forma
Visible=S
ActivoCondicion=Info.AnexoCfg

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

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cambiar Estilo
Cambiar Estilo=Digitalizar
Digitalizar=Editar
Editar=BandejaEntrada
BandejaEntrada=Actualizar
Actualizar=Ordenar
Ordenar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=AnexoMovD.Tipo
AnexoMovD.Tipo=AnexoMovD.Direccion
AnexoMovD.Direccion=(Fin)
