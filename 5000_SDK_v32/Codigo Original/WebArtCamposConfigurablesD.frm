
[Forma]
Clave=WebArtCamposConfigurablesD
Icono=0
CarpetaPrincipal=WebArtCamposConfigurablesD
Modulos=(Todos)
Nombre=Detalle

ListaCarpetas=WebArtCamposConfigurablesD
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=618
PosicionInicialArriba=363
PosicionInicialAlturaCliente=273
PosicionInicialAncho=588
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Comentarios=Info.Articulo
[WebArtCamposConfigurablesD]
Estilo=Hoja
Clave=WebArtCamposConfigurablesD
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtCamposConfigurablesD
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
CarpetaVisible=S
Filtros=S
PermiteEditar=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

OtroOrden=S
ListaOrden=WebArtCamposConfigurablesD.Orden<TAB>(Acendente)
FiltroGeneral=WebArtCamposConfigurablesD.ID = {Info.IDR}
[WebArtCamposConfigurablesD.WebArtCamposConfigurablesD.Valor]
Carpeta=WebArtCamposConfigurablesD
Clave=WebArtCamposConfigurablesD.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[WebArtCamposConfigurablesD.Columnas]
Valor=459


OpcionIntelisis=88
[Acciones.Orden]
Nombre=Orden
Boton=50
NombreEnBoton=S
NombreDesplegar=Cambiar &Orden
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
DespuesGuardar=S
Visible=S



AntesExpresiones=FormaModal(<T>WebArtCamposConfigurablesDOrdenar<T>)



[WebArtCamposConfigurablesD.ListaEnCaptura]
(Inicio)=WebArtCamposConfigurablesD.Valor
WebArtCamposConfigurablesD.Valor=WebArtCamposConfigurablesD.OpcionIntelisis
WebArtCamposConfigurablesD.OpcionIntelisis=(Fin)

[WebArtCamposConfigurablesD.WebArtCamposConfigurablesD.OpcionIntelisis]
Carpeta=WebArtCamposConfigurablesD
Clave=WebArtCamposConfigurablesD.OpcionIntelisis
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Orden
Orden=(Fin)
