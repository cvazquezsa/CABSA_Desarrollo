[Forma]
Clave=PersonalUltimoPago
Nombre=Ultimo Pago
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=324
PosicionInicialArriba=230
PosicionInicialAlturaCliente=273
PosicionInicialAncho=423
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalUltimoPago
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PestanaOtroNombre=S
IconosNombre=PersonalUltimoPago:PersonalUltimoPago.Mov
FiltroGeneral=PersonalUltimoPago.Personal=<T>{Info.Personal}<T>

[Lista.PersonalUltimoPago.UltimoPago]
Carpeta=Lista
Clave=PersonalUltimoPago.UltimoPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
0=180
1=87

[Lista.PersonalUltimoPago.Empresa]
Carpeta=Lista
Clave=PersonalUltimoPago.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=PersonalUltimoPago.Empresa
PersonalUltimoPago.Empresa=PersonalUltimoPago.UltimoPago
PersonalUltimoPago.UltimoPago=(Fin)
