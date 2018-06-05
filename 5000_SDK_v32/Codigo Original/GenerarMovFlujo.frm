[Forma]
Clave=GenerarMovFlujo
Nombre=Info.Mov+<T> <T>+Info.MovID
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraAcciones=S
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
PosicionInicialIzquierda=567
PosicionInicialArriba=288
PosicionInicialAltura=292
PosicionInicialAncho=306
AccionesCentro=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=290

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
OtroOrden=S
Zona=A1
Vista=CfgMovFlujo
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaOrden=CfgMovFlujo.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
MenuLocal=S
ListaAcciones=AceptarLocal
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento a Generar<T>
ElementosPorPagina=200
IconosNombre=Vacio(CfgMovFlujo:CfgMovFlujo.Nombre, CfgMovFlujo:CfgMovFlujo.DMov)
FiltroGeneral=Modulo=<T>{Info.Modulo}<T> AND OMov=<T>{Info.Mov}<T>

[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreDesplegar=&Generar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Asignar<BR>Aceptar
ConCondicion=S
EjecucionCondicion=ConDatos(CfgMovFlujo:CfgMovFlujo.DMov)

[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=&Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Lista.Columnas]
DMov=232
0=201

[Acciones.Aceptar.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.MovGenerar, CfgMovFlujo:CfgMovFlujo.DMov)

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.AceptarLocal]
Nombre=AceptarLocal
Boton=0
NombreDesplegar=&Generar
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CfgMovFlujo:CfgMovFlujo.DMov)
Antes=S
AntesExpresiones=Asigna(Info.MovGenerar, CfgMovFlujo:CfgMovFlujo.DMov)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
