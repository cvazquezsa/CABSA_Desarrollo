[Forma]
Clave=TareaBitacora
Nombre=<T>Bitácora<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=329
PosicionInicialArriba=256
PosicionInicialAltura=296
PosicionInicialAncho=622
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Descripcion
VentanaEscCerrar=S
VentanaExclusiva=S
PosicionInicialAlturaCliente=484

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TareaBitacora
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
OtroOrden=S
ListaOrden=TareaBitacora.Fecha<TAB>(Acendente)
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
IconosNombre=FechaEnTexto(TareaBitacora:TareaBitacora.Fecha, <T>dd/mmm/aaaa hh:nn am/pm<T>)
FiltroGeneral=TareaBitacora.ID=<T>{Info.TareaID}<T>

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
ClaveAccion=TareaBitacoraAgregar
Multiple=S
ListaAccionesMultiples=Agregar<BR>Actualizar Vista
VisibleCondicion=Info.PuedeEditar

[Acciones.Ampliar]
Nombre=Ampliar
Boton=0
NombreDesplegar=&Ampliar
EnMenu=S
TipoAccion=Expresion
Expresion=VerComentario(CampoNombre(TareaBitacora:TareaBitacora.Evento), TareaBitacora:TareaBitacora.Evento )
Activo=S
Visible=S

[Lista.TareaBitacora.Evento]
Carpeta=Lista
Clave=TareaBitacora.Evento
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
ClaveAccion=TareaBitacoraAgregar
Activo=S
Visible=S

[Acciones.Agregar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.TareaBitacora.Usuario]
Carpeta=Lista
Clave=TareaBitacora.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Agregar
Agregar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TareaBitacora.Evento
TareaBitacora.Evento=TareaBitacora.Usuario
TareaBitacora.Usuario=(Fin)
