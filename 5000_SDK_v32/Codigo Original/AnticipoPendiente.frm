[Forma]
Clave=AnticipoPendiente
Nombre=Anticipos Pendientes
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=294
PosicionInicialArriba=175
PosicionInicialAltura=410
PosicionInicialAncho=436
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
Comentarios=Lista(Info.Moneda, Info.Cuenta)
VentanaExclusiva=S
PosicionInicialAlturaCliente=383

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AnticipoPendiente
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=AnticipoPendiente.Fecha<TAB>(Acendente)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Referencia<T>
ElementosPorPagina=200
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Pendientes
IconosNombre=AnticipoPendiente:AnticipoPendiente.Referencia
FiltroGeneral=AnticipoPendiente.Empresa=<T>{Empresa}<T> AND<BR>AnticipoPendiente.Rama=<T>{Info.Rama}<T> AND<BR>AnticipoPendiente.Cuenta=<T>{Info.Cuenta}<T>

[Lista.AnticipoPendiente.Saldo]
Carpeta=Lista
Clave=AnticipoPendiente.Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.AnticipoPendiente.Fecha]
Carpeta=Lista
Clave=AnticipoPendiente.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Referencia=195
Saldo=128
Fecha=83
0=133
1=134

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar/Aceptar
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Referencia, AnticipoPendiente:AnticipoPendiente.Referencia)<BR>Asigna(Info.Importe, AnticipoPendiente:AnticipoPendiente.Saldo)

[Lista.ListaEnCaptura]
(Inicio)=AnticipoPendiente.Saldo
AnticipoPendiente.Saldo=AnticipoPendiente.Fecha
AnticipoPendiente.Fecha=(Fin)
