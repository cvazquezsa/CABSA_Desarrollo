
[Forma]
Clave=OportunidadeMailUsuarioMensaje
Icono=286
Modulos=(Todos)
Nombre=Mensaje

ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
Comentarios=Lista(Info.Notificacion,Info.Nombre,Info.Mov)
PosicionInicialIzquierda=263
PosicionInicialArriba=133
PosicionInicialAlturaCliente=414
PosicionInicialAncho=725
MovModulo=OPORT
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Dise�o
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=2
[Ficha]
Estilo=Ficha
Clave=Ficha
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadeMailUsuarioMensaje
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
ListaEnCaptura=OportunidadeMailUsuario.Mensaje
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=OportunidadeMailUsuario.Usuario = {Comillas(Usuario)} AND OportunidadeMailUsuario.RID = {Comillas(Info.ID)}
[Ficha.OportunidadeMailUsuario.Mensaje]
Carpeta=Ficha
Clave=OportunidadeMailUsuario.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100X25
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
