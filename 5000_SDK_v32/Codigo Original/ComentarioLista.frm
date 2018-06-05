[Forma]
Clave=ComentarioLista
Nombre=Comentarios
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=230
PosicionInicialArriba=173
PosicionInicialAlturaCliente=387
PosicionInicialAncho=563
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaExclusiva=S

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Comentarios
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Comentario
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Comentario<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Negro
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
IconosNombre=Comentario:Comentario.Comentario
FiltroGeneral=Comentario.Modulo=<T>{Info.Modulo}<T>

[Lista.Columnas]
0=525

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(Comentario:Comentario.Comentario)
AntesExpresiones=Asigna(Temp.Texto, Comentario:Comentario.Comentario)
