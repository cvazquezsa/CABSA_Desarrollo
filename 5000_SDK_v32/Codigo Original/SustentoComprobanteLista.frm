
[Forma]
Clave=SustentoComprobanteLista
Icono=0
Modulos=(Todos)
Nombre=Lista Sustento Comprobante

ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=Seleccionar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=470
PosicionInicialArriba=300
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SustentoComprobante
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Sustento Comprobante<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco

CarpetaVisible=S



Filtros=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=SustentoComprobante:SustentoComprobante.SustentoComprobante
FiltroGeneral=SustentoComprobante.VigenciaD <= <T>{FechaFormatoServidor(HOY)}<T>
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.Columnas]
0=-2
1=-2
2=-2






[Lista.SustentoComprobante.Concepto]
Carpeta=Lista
Clave=SustentoComprobante.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.SustentoComprobante.VigenciaD]
Carpeta=Lista
Clave=SustentoComprobante.VigenciaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=SustentoComprobante.Concepto
SustentoComprobante.Concepto=SustentoComprobante.VigenciaD
SustentoComprobante.VigenciaD=(Fin)
