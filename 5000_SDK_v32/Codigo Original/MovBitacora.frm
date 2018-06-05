[Forma]
Clave=MovBitacora
Nombre=<T>Bitácora del Movimiento<T>
Icono=61
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=608
PosicionInicialArriba=391
PosicionInicialAltura=296
PosicionInicialAncho=703
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Info.Mov+<T> <T>+Info.MovID
VentanaEscCerrar=S
VentanaExclusiva=S
PosicionInicialAlturaCliente=382

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovBitacora
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
OtroOrden=S
ListaOrden=MovBitacora.Fecha<TAB>(Acendente)
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
IconosCampo=EventoTipo.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tipo<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Evento(s)
MenuLocal=S
ListaAcciones=Ampliar
IconosNombre=MovBitacora:MovBitacora.Tipo
FiltroGeneral=MovBitacora.Modulo=<T>{Info.Modulo}<T> AND MovBitacora.ID={Info.ID}

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
0=134
1=311

[Acciones.Agregar]
Nombre=Agregar
Boton=56
NombreEnBoton=S
NombreDesplegar=&Agregar Evento
EnBarraHerramientas=S
TipoAccion=Formas
Activo=S
EspacioPrevio=S
ClaveAccion=MovBitacoraAgregar
Multiple=S
ListaAccionesMultiples=Agregar<BR>Actualizar Vista
VisibleCondicion=Info.PuedeEditar

[Acciones.Ampliar]
Nombre=Ampliar
Boton=0
NombreDesplegar=&Ampliar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=VerComentario(MovBitacora:MovBitacora.Tipo+<T> - <T>+FechaEnTexto( MovBitacora:MovBitacora.Fecha, <T>dd/mmm/aaaa hh:nn am/pm<T>), MovBitacora:MovBitacora.Evento )

[Lista.MovBitacora.Evento]
Carpeta=Lista
Clave=MovBitacora.Evento
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
ClaveAccion=MovBitacoraAgregar
Activo=S
Visible=S

[Acciones.Agregar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.MovBitacora.Usuario]
Carpeta=Lista
Clave=MovBitacora.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovBitacora.Fecha]
Carpeta=Lista
Clave=MovBitacora.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CambiarEstilo]
Nombre=CambiarEstilo
Boton=0
NombreDesplegar=CambiarEstilo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Estilo (Iconos)
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
Aceptar=CambiarEstilo
CambiarEstilo=Agregar
Agregar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=MovBitacora.Evento
MovBitacora.Evento=MovBitacora.Fecha
MovBitacora.Fecha=MovBitacora.Usuario
MovBitacora.Usuario=(Fin)
