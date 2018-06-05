
[Forma]
Clave=MFAConceptoLista
Icono=0
Modulos=(Todos)
Nombre=MFA - Lista Conceptos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=Seleccionar
PosicionInicialIzquierda=390
PosicionInicialArriba=219
PosicionInicialAlturaCliente=456
PosicionInicialAncho=500
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAConcepto
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
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
Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=MFAConcepto.concepto_tipo
FiltroAutoValidar=MFAConcepto.concepto_tipo
FiltroAutoOrden=MFAConcepto.concepto_tipo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroEstilo=Folder (1 línea)
FiltroRespetar=S
FiltroTipo=Automático
IconosNombre=MFAConcepto:MFAConcepto.concepto_clave
FiltroGeneral={Si(Info.Tipo = <T><T>,<T> 1 = 1 <T>,<T> concepto_tipo = <T> + ASCII(39) + Si(Info.Tipo = <T>Cliente<T>,<T>Articulo<T>,<T>Gastos<T>) + ASCII(39))}
[Lista.MFAConcepto.concepto_descripcion]
Carpeta=Lista
Clave=MFAConcepto.concepto_descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.MFAConcepto.concepto_tipo]
Carpeta=Lista
Clave=MFAConcepto.concepto_tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco

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
0=79
1=303
2=-2



[Lista.ListaEnCaptura]
(Inicio)=MFAConcepto.concepto_descripcion
MFAConcepto.concepto_descripcion=MFAConcepto.concepto_tipo
MFAConcepto.concepto_tipo=(Fin)
