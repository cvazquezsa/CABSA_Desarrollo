
[Forma]
Clave=WebArtCamposConfigurables
Icono=0
CarpetaPrincipal=WebArtCamposConfigurables
BarraHerramientas=S
Modulos=(Todos)
Nombre=Campos Configurables Artículos eCommerce
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=WebArtCamposConfigurables
ListaAcciones=(Lista)
PosicionInicialIzquierda=692
PosicionInicialArriba=332
PosicionInicialAlturaCliente=336
PosicionInicialAncho=535
Comentarios=Info.Articulo
[WebArtCamposConfigurables]
Estilo=Hoja
Clave=WebArtCamposConfigurables
Filtros=S
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtCamposConfigurables
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
ListaEnCaptura=(Lista)
ListaOrden=WebArtCamposConfigurables.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=WebArtCamposConfigurables.IDArt = {Info.ID}
[WebArtCamposConfigurables.WebArtCamposConfigurables.Nombre]
Carpeta=WebArtCamposConfigurables
Clave=WebArtCamposConfigurables.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[WebArtCamposConfigurables.WebArtCamposConfigurables.TipoCampo]
Carpeta=WebArtCamposConfigurables
Clave=WebArtCamposConfigurables.TipoCampo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[WebArtCamposConfigurables.WebArtCamposConfigurables.Requerido]
Carpeta=WebArtCamposConfigurables
Clave=WebArtCamposConfigurables.Requerido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

NombreEnBoton=S
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
Visible=S

Antes=S
DespuesGuardar=S
AntesExpresiones=FormaModal(<T>WebArtCamposConfigurablesOrdenar<T>)
[WebArtCamposConfigurables.Columnas]
Nombre=218
ValorSelect=304
TipoCampo=126
Requerido=64

OpcionIntelisis=81
[Lista.Columnas]
0=79
1=427

2=-2
[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=WebArtCamposConfigurablesD
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S

ActivoCondicion=WebArtCamposConfigurables:WebArtCamposConfigurables.TipoCampo en (<T>Menú de selección<T>,<T>Seleccionar Opciones<T>)
AntesExpresiones=Asigna(Info.IDR,WebArtCamposConfigurables:WebArtCamposConfigurables.ID)<BR>Asigna(Info.ABC,WebArtCamposConfigurables:WebArtCamposConfigurables.TipoCampo)
[Acciones.Expresion]
Nombre=Expresion
Boton=20
NombreEnBoton=S
NombreDesplegar=&Generar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S

Expresion=FormaModal(<T>WebArtCamposConfigurablesCatTemp<T>)<BR>ActualizarForma



























































[WebArtCamposConfigurables.ListaEnCaptura]
(Inicio)=WebArtCamposConfigurables.Requerido
WebArtCamposConfigurables.Requerido=WebArtCamposConfigurables.Nombre
WebArtCamposConfigurables.Nombre=WebArtCamposConfigurables.TipoCampo
WebArtCamposConfigurables.TipoCampo=WebArtCamposConfigurables.OpcionIntelisis
WebArtCamposConfigurables.OpcionIntelisis=(Fin)

[WebArtCamposConfigurables.WebArtCamposConfigurables.OpcionIntelisis]
Carpeta=WebArtCamposConfigurables
Clave=WebArtCamposConfigurables.OpcionIntelisis
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco













[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Orden
Orden=Expresion
Expresion=Detalle
Detalle=(Fin)
