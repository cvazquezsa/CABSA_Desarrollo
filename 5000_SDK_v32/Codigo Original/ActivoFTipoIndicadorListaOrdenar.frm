
[Forma]
Clave=ActivoFTipoIndicadorListaOrdenar
Icono=0
Modulos=(Todos)
Nombre=Ordenar Valores Indicador

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=<T>Utilice arrastrar y soltar para cambiar el orden<T>
ListaAcciones=Ordenar
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Iconos
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoFTipoIndicadorLista
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
IconosSubTitulo=<T>Orden<T>
ListaEnCaptura=ActivoFTipoIndicadorLista.Valor
ListaOrden=ActivoFTipoIndicadorLista.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

PestanaOtroNombre=S
PestanaNombre=Registros
IconosCambiarOrden=S
IconosNombre=ActivoFTipoIndicadorLista:ActivoFTipoIndicadorLista.Orden
FiltroGeneral=ActivoFTipoIndicadorLista.Tipo = {Comillas(Info.Tipo)} AND ActivoFTipoIndicadorLista.Indicador = {Comillas(Info.Observaciones)}
[Lista.ActivoFTipoIndicadorLista.Valor]
Carpeta=Lista
Clave=ActivoFTipoIndicadorLista.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Ordenar]
Nombre=Ordenar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar Nuevo Orden
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
Antes=S

AntesExpresiones=RegistrarListaSt(<T>Lista<T>,<T>ActivoFTipoIndicadorLista.Valor<T>)<BR>EjecutarSQL(<T>spOrdenarMaestro :nEstacion, :tTabla,NULL,NULL, :tTipo, :tIndicador<T>,EstacionTrabajo,<T>ActivoFTipoIndicadorLista<T>,ActivoFTipoIndicadorLista:ActivoFTipoIndicadorLista.Tipo,ActivoFTipoIndicadorLista:ActivoFTipoIndicadorLista.Indicador)
[Lista.Columnas]
0=-2
1=-2
