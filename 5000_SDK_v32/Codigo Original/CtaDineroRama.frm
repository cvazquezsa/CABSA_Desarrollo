[Forma]
Clave=CtaDineroRama
Nombre=Ramas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAltura=414
PosicionInicialAncho=580
PosicionInicialIzquierda=222
PosicionInicialArriba=173
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialAlturaCliente=387

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtaDinero
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=CtaDinero.Descripcion
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=Todas
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Rama<T>
ElementosPorPagina=200
FiltroArbolClave=CteRama.Cuenta
FiltroArbolValidar=CteRama.Nombre
FiltroArbolRama=CteRama.Rama
FiltroTodo=S
PestanaOtroNombre=S
PestanaNombre=Ramas
FiltroArbol=Cuentas Dinero
FiltroArbolAplica=CtaDinero.Rama
IconosNombre=CtaDinero:CtaDinero.CtaDinero
FiltroGeneral=CtaDinero.Tipo=<T>Estructura<T>

[Lista.Columnas]
0=126
1=246

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

[Lista.CtaDinero.Descripcion]
Carpeta=Lista
Clave=CtaDinero.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
