
[Forma]
Clave=eDocInNodoAtributoTemp
Icono=0
Modulos=(Todos)
Nombre=Campo XML
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=eDocInNodoAtributoTemp
CarpetaPrincipal=eDocInNodoAtributoTemp
PosicionInicialIzquierda=525
PosicionInicialArriba=197
PosicionInicialAlturaCliente=428
PosicionInicialAncho=549
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[eDocInNodoAtributoTemp]
Estilo=Iconos
Clave=eDocInNodoAtributoTemp
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocInNodoAtributoTemp
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=eDocInNodoAtributoTemp.CampoTipoxml

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
IconosSubTitulo=<T>Campo XML<T>
PestanaOtroNombre=S
PestanaNombre=Campos
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
IconosNombre=eDocInNodoAtributoTemp:eDocInNodoAtributoTemp.NodoNombre
FiltroGeneral=eDocInNodoAtributoTemp.Estacion = {SPID}
[eDocInNodoAtributoTemp.ListaEnCaptura]
(Inicio)=eDocInNodoAtributoTemp.NodoNombre
eDocInNodoAtributoTemp.NodoNombre=eDocInNodoAtributoTemp.CampoTipoxml
eDocInNodoAtributoTemp.CampoTipoxml=(Fin)


[eDocInNodoAtributoTemp.eDocInNodoAtributoTemp.CampoTipoxml]
Carpeta=eDocInNodoAtributoTemp
Clave=eDocInNodoAtributoTemp.CampoTipoxml
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[eDocInNodoAtributoTemp.Columnas]
0=-2
1=-2

[Acciones.Seleccionar/Aceptar]
Nombre=Seleccionar/Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

GuardarAntes=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Motivo,eDocInNodoAtributoTemp:eDocInNodoAtributoTemp.Ruta)<BR>Asigna(Info.Destino,eDocInNodoAtributoTemp:eDocInNodoAtributoTemp.CampoTipoxml)<BR>Asigna(Info.Dato,eDocInNodoAtributoTemp:eDocInNodoAtributoTemp.Atributo)<BR>Asigna(Info.Anuncio,eDocInNodoAtributoTemp:eDocInNodoAtributoTemp.NodoNombre)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S





NombreEnBoton=S
EspacioPrevio=S






































































[Forma.ListaAcciones]
(Inicio)=Seleccionar/Aceptar
Seleccionar/Aceptar=Cancelar
Cancelar=(Fin)
