[Forma]
Clave=CtaBitacora
Nombre=<T>Bitácora del <T>+Info.Tipo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=207
PosicionInicialArriba=232
PosicionInicialAltura=296
PosicionInicialAncho=609
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Descripcion
VentanaEscCerrar=S
VentanaExclusiva=S
PosicionInicialAlturaCliente=269

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtaBitacora
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
OtroOrden=S
ListaOrden=CtaBitacora.Fecha<TAB>(Acendente)
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Fecha/Hora<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Evento(s)
MenuLocal=S
ListaAcciones=Ampliar
IconosNombre=FechaEnTexto(CtaBitacora:CtaBitacora.Fecha, <T>dd/mmm/aaaa hh:nn am/pm<T>)
FiltroGeneral=CtaBitacora.Modulo=<T>{Info.Modulo}<T> AND CtaBitacora.Cuenta=<T>{Info.Cuenta}<T>

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Evento=429
Fecha=117
0=128
1=389

[Acciones.Agregar]
Nombre=Agregar
Boton=56
NombreEnBoton=S
NombreDesplegar=&Agregar Evento
EnBarraHerramientas=S
TipoAccion=Formas
Activo=S
EspacioPrevio=S
ClaveAccion=CtaBitacoraAgregar
Multiple=S
ListaAccionesMultiples=Agregar<BR>Actualizar Vista
VisibleCondicion=Info.PuedeEditar

[Acciones.Ampliar]
Nombre=Ampliar
Boton=0
NombreDesplegar=&Ampliar
EnMenu=S
TipoAccion=Expresion
Expresion=VerComentario(CampoNombre(CtaBitacora:CtaBitacora.Evento), CtaBitacora:CtaBitacora.Evento )
Activo=S
Visible=S

[Lista.CtaBitacora.Evento]
Carpeta=Lista
Clave=CtaBitacora.Evento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Agregar.Agregar]
Nombre=Agregar
Boton=0
TipoAccion=Formas
ClaveAccion=CtaBitacoraAgregar
Activo=S
Visible=S

[Acciones.Agregar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.CtaBitacora.Usuario]
Carpeta=Lista
Clave=CtaBitacora.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Movimientos]
Nombre=Movimientos
Boton=50
NombreEnBoton=S
NombreDesplegar=Bitácora &Movimientos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Caso Info.Modulo<BR>  Es <T>CXC<T> Entonces Forma(<T>CteMovBitacora<T>)<BR>Fin

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Movimientos
Movimientos=Agregar
Agregar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CtaBitacora.Evento
CtaBitacora.Evento=CtaBitacora.Usuario
CtaBitacora.Usuario=(Fin)
