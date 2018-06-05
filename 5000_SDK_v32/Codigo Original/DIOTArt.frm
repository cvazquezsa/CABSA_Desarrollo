
[Forma]
Clave=DIOTArt
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=DPIVA - Configuración Artículos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Articulo
CarpetaPrincipal=Articulo
PosicionInicialIzquierda=479
PosicionInicialArriba=187
PosicionInicialAlturaCliente=315
PosicionInicialAncho=407
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Conceptos.DIOTConcepto.Concepto]
Carpeta=Conceptos
Clave=DIOTConcepto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Conceptos.Columnas]
Concepto=304

[Articulo]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Artículos
Clave=Articulo
ValidarCampos=S
BusquedaRapidaControles=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DIOTArt
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
ListaCamposAValidar=Art.Descripcion1
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
CarpetaVisible=S


[Articulo.Columnas]
Articulo_1=69

Descripcion1=286
Articulo=66
[Forma.ListaCarpetas]
(Inicio)=Conceptos
Conceptos=Articulo
Articulo=(Fin)


[Articulo.Art.Descripcion1]
Carpeta=Articulo
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Articulo.ListaEnCaptura]
(Inicio)=DIOTArt.Articulo
DIOTArt.Articulo=Art.Descripcion1
Art.Descripcion1=(Fin)

[Articulo.DIOTArt.Articulo]
Carpeta=Articulo
Clave=DIOTArt.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
Articulo=131
Descripcion1=244
