
[Forma]
Clave=NotificacionConsulta
Icono=0
Modulos=(Todos)
Nombre=Notificación - Etiquetas de Usuario
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
Comentarios=Lista(Info.Notificacion)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=441
PosicionInicialArriba=171
PosicionInicialAlturaCliente=366
PosicionInicialAncho=398
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionConsulta
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

PermiteEditar=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
ListaEnCaptura=NotificacionConsulta.ConsultaNombre
HojaMantenerSeleccion=S
FiltroGeneral=NotificacionConsulta.Notificacion = {Comillas(Info.Notificacion)}
[Lista.Columnas]
0=-2

ConsultaNombre=367
[Acciones.Consulta]
Nombre=Consulta
Boton=75
NombreEnBoton=S
NombreDesplegar=&Consulta
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NotificacionConsultaSQL
Activo=S
Visible=S

Antes=S

























GuardarAntes=S
AntesExpresiones=Asigna(Info.Nombre,NotificacionConsulta:NotificacionConsulta.ConsultaNombre)
[Lista.NotificacionConsulta.ConsultaNombre]
Carpeta=Lista
Clave=NotificacionConsulta.ConsultaNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Consulta
Consulta=(Fin)
