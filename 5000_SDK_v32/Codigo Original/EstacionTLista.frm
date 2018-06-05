[Forma]
Clave=EstacionTLista
Nombre=Estaciones Trabajo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=205
PosicionInicialArriba=141
PosicionInicialAlturaCliente=452
PosicionInicialAncho=613
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EstacionT
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Estación<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Estaciones
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=EstacionT.Centro
FiltroValida1=EstacionT.Centro
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
FiltroAplicaEn=EstacionT.Centro
FiltroAutoCampo=EstacionT.Centro
FiltroAutoValidar=EstacionT.Centro
FiltroEstilo=Folder (1 línea)
IconosNombre=EstacionT:EstacionT.Estacion

[Lista.EstacionT.Descripcion]
Carpeta=Lista
Clave=EstacionT.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EstacionT.Centro]
Carpeta=Lista
Clave=EstacionT.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=133
1=270

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=EstacionT.Descripcion
EstacionT.Descripcion=EstacionT.Centro
EstacionT.Centro=(Fin)
