[Forma]
Clave=PresupuestoInfo
Nombre=Presupuesto
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialAlturaCliente=352
PosicionInicialAncho=707
PosicionInicialIzquierda=370
PosicionInicialArriba=322
Comentarios=Lista(Info.Nombre, Info.Cuenta)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Presupuesto
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>UEN<T>
IconosNombreNumerico=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroPeriodos=S
FiltroEjercicios=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroEditarFueraPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMonedas=S
FiltroFechasNormal=S
FiltroMonedasCampo=Presupuesto.Moneda
FiltroFechasNombre=&Fecha
CarpetaVisible=S
PestanaOtroNombre=S
IconosNombre=Presupuesto:Presupuesto.UEN
FiltroGeneral=Presupuesto.Empresa=<T>{Empresa}<T> AND<BR>Presupuesto.Cuenta=<T>{Info.Cuenta}<T>

[Lista.Presupuesto.Periodo]
Carpeta=Lista
Clave=Presupuesto.Periodo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Presupuesto.Presupuesto]
Carpeta=Lista
Clave=Presupuesto.Presupuesto
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Presupuesto.Reservado]
Carpeta=Lista
Clave=Presupuesto.Reservado
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Presupuesto.Ejercido]
Carpeta=Lista
Clave=Presupuesto.Ejercido
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Disponible]
Carpeta=Lista
Clave=Disponible
Editar=S
Totalizador=1
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
0=35
1=51

[Lista.Presupuesto.Comprometido]
Carpeta=Lista
Clave=Presupuesto.Comprometido
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Presupuesto.Devengado]
Carpeta=Lista
Clave=Presupuesto.Devengado
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=Presupuesto.Periodo
Presupuesto.Periodo=Presupuesto.Presupuesto
Presupuesto.Presupuesto=Presupuesto.Reservado
Presupuesto.Reservado=Presupuesto.Comprometido
Presupuesto.Comprometido=Presupuesto.Devengado
Presupuesto.Devengado=Presupuesto.Ejercido
Presupuesto.Ejercido=Disponible
Disponible=(Fin)
