
[Forma]
Clave=NotificacionClaveConsultaSQL
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Consulta Clave Notificacion - SQL
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaAcciones=Cerrar
Comentarios=Lista(Info.NotificacionClave,Info.Nombre)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=438
PosicionInicialArriba=207
PosicionInicialAlturaCliente=418
PosicionInicialAncho=724
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

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionClaveConsultaSQL
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
ListaEnCaptura=NotificacionClaveConsultaSQL.Consulta
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
AlinearTodaCarpeta=S
FiltroGeneral=NotificacionClaveConsultaSQL.Clave = {Comillas(Info.NotificacionClave)} AND NotificacionClaveConsultaSQL.ConsultaNombre = {Comillas(Info.Nombre)}
[Ficha.NotificacionClaveConsultaSQL.Consulta]
Carpeta=Ficha
Clave=NotificacionClaveConsultaSQL.Consulta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100X25
ColorFondo=Blanco
