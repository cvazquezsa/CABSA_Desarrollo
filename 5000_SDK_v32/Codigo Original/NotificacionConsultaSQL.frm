
[Forma]
Clave=NotificacionConsultaSQL
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Consulta Clave Notificacion - SQL
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaAcciones=(Lista)
Comentarios=Lista(Info.Notificacion,Info.Nombre)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=438
PosicionInicialArriba=207
PosicionInicialAlturaCliente=418
PosicionInicialAncho=724

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionConsultaSQL
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
ListaEnCaptura=NotificacionConsultaSQL.Consulta
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PermiteEditar=S
FiltroGeneral=NotificacionConsultaSQL.Notificacion = {Comillas(Info.Notificacion)} AND NotificacionConsultaSQL.ConsultaNombre = {Comillas(Info.Nombre)}
AlinearTodaCarpeta=S
[Ficha.NotificacionConsultaSQL.Consulta]
Carpeta=Ficha
Clave=NotificacionConsultaSQL.Consulta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100X25
ColorFondo=Blanco

ConScroll=S
SinRecapitular=S
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Ayuda]
Nombre=Ayuda
Boton=101
NombreEnBoton=S
NombreDesplegar=&Ayuda Etiquetas
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NotificacionTagAyuda
Activo=S
Visible=S











[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Ayuda
Ayuda=(Fin)
