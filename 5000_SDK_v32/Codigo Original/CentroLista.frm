[Forma]
Clave=CentroLista
Nombre=Centros/Estaciones Trabajo
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=224
PosicionInicialArriba=178
PosicionInicialAltura=404
PosicionInicialAncho=576
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
PosicionInicialAlturaCliente=377

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Centro
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Centro.Descripcion
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CentroTipo
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Centro<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Centros Trabajo
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=CentroCat
FiltroAutoOrden=Centro.Categoria
FiltroAplicaEn=Centro.Categoria
OtroOrden=S
ListaOrden=(Lista)
FiltroAplicaEn1=Centro.Tipo
FiltroArbolClave=Centro.Centro
FiltroArbolValidar=Centro.Centro
FiltroArbolRama=Centro.Rama
IconosNombre=Centro:Centro.Centro

[Lista.Centro.Descripcion]
Carpeta=Lista
Clave=Centro.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Centro=94
Descripcion=283
0=94
1=284

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

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Plan]
Nombre=Plan
Boton=88
NombreEnBoton=S
NombreDesplegar=&Plan
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=VerCRP(<T>Plan: <T>+Centro:Centro.Descripcion, Centro:Centro.Centro)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Centro:Centro.Centro)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Plan
Plan=Campos
Campos=(Fin)

[Lista.ListaOrden]
(Inicio)=Centro.Orden<TAB>(Acendente)
Centro.Orden<TAB>(Acendente)=Centro.Centro<TAB>(Acendente)
Centro.Centro<TAB>(Acendente)=(Fin)
