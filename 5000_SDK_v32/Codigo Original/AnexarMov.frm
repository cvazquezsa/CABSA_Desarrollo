[Forma]
Clave=AnexarMov
Nombre=Movimiento a Anexar
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=793
PosicionInicialArriba=445
PosicionInicialAlturaCliente=273
PosicionInicialAncho=334
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
OtroOrden=S
Zona=A1
Vista=CfgAnexarMov
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Negro
ListaOrden=CfgAnexarMov.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
IconosNombre=CfgAnexarMov:CfgAnexarMov.MovDestino
FiltroGeneral=CfgAnexarMov.Modulo=<T>{Info.Modulo}<T> AND CfgAnexarMov.Mov=<T>{Info.Mov}<T>

[Lista.Columnas]
0=296

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(CfgAnexarMov:CfgAnexarMov.MovDestino)
Antes=S
AntesExpresiones=Asigna(Afectar.GenerarMov, CfgAnexarMov:CfgAnexarMov.MovDestino)

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
