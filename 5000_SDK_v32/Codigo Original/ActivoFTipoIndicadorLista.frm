
[Forma]
Clave=ActivoFTipoIndicadorLista
Icono=0
Modulos=(Todos)
Nombre=Valores Validos por Indicador
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=470
PosicionInicialArriba=300
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
BarraHerramientas=S
Comentarios=Lista(Info.Tipo,Info.Observaciones)
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoFTipoIndicadorLista
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ActivoFTipoIndicadorLista.Valor

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

ListaOrden=ActivoFTipoIndicadorLista.Orden<TAB>(Acendente)
FiltroGeneral=ActivoFTipoIndicadorLista.Tipo = {Comillas(Info.Tipo)}<BR>AND ActivoFTipoIndicadorLista.Indicador = {Comillas(Info.Observaciones)}
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


[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar y Cerrar
GuardarAntes=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

EnBarraHerramientas=S
[Lista.Columnas]
Valor=179
Orden=64







0=-2
1=-2
[Lista.ListaEnCaptura]
(Inicio)=ActivoFTipoIndicadorLista.Valor
ActivoFTipoIndicadorLista.Valor=ActivoFTipoIndicadorLista.Orden
ActivoFTipoIndicadorLista.Orden=(Fin)

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar &Orden
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S









GuardarAntes=S
























Antes=S








DespuesGuardar=S




















AntesExpresiones=FormaModal(<T>ActivoFTipoIndicadorListaOrdenar<T>)












[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Ordenar
Ordenar=(Fin)
