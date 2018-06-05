
[Forma]
Clave=MovSituacionBinariaCondUsuario
Icono=166
Modulos=(Todos)
MovModulo=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Condicion
CarpetaPrincipal=Condicion
PosicionInicialIzquierda=293
PosicionInicialArriba=162
PosicionInicialAlturaCliente=366
PosicionInicialAncho=780


BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Nombre=<T>Condición Usuario - <T>+Info.Situacion
[Condicion]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Condicion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovSituacion
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
ListaEnCaptura=MovSituacion.CondicionUsuario
CarpetaVisible=S

AlinearTodaCarpeta=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=MovSituacion.ID={Info.ID}
FiltroRespetar=S
FiltroTipo=General
[Condicion.MovSituacion.CondicionUsuario]
Carpeta=Condicion
Clave=MovSituacion.CondicionUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ConScroll=S
SinRecapitular=S
Tamano=100x25

[Condicion.ListaEnCaptura]
(Inicio)=MovSituacion.CondicionUsuario
MovSituacion.CondicionUsuario=MovSituacion.Estatus
MovSituacion.Estatus=MovSituacion.Situacion
MovSituacion.Situacion=MovSituacion.PermiteAfectacion
MovSituacion.PermiteAfectacion=MovSituacion.PermiteRetroceder
MovSituacion.PermiteRetroceder=(Fin)






[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
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
ClaveAccion=MovSituacionBinariaTagAyuda
Activo=S
Visible=S















[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Ayuda
Ayuda=(Fin)
