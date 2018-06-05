
[Forma]
Clave=NotificacionClaveConsulta
Icono=0
Modulos=(Todos)
Nombre=Claves de Notificación - Consultas
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
Comentarios=Lista(Info.NotificacionClave)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=394
PosicionInicialArriba=167
PosicionInicialAlturaCliente=370
PosicionInicialAncho=491
VentanaExclusiva=S
VentanaExclusivaOpcion=3
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
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionClaveConsulta
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Nombre<T>
ElementosPorPaginaEsp=200
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

IconosNombre=NotificacionClaveConsulta:NotificacionClaveConsulta.ConsultaNombre
FiltroGeneral=NotificacionClaveConsulta.Clave = {Comillas(Info.NotificacionClave)}
[Lista.Columnas]
0=-2

[Acciones.Consulta]
Nombre=Consulta
Boton=75
NombreEnBoton=S
NombreDesplegar=&Consulta
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NotificacionClaveConsultaSQL
Activo=S
Visible=S

Antes=S




AntesExpresiones=Asigna(Info.Nombre,NotificacionClaveConsulta:NotificacionClaveConsulta.ConsultaNombre)
















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Consulta
Consulta=(Fin)
