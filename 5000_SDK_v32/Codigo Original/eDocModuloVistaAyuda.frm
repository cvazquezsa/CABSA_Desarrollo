
[Forma]
Clave=eDocModuloVistaAyuda
Icono=5
Modulos=(Todos)
Nombre=Ayuda Documento Electrónico

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialAlturaCliente=470
PosicionInicialAncho=733
Comentarios=Lista(Info.Vista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=273
PosicionInicialArriba=116
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocModuloVistaAyuda
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Campo<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=eDocModuloVistaAyuda.Descripcion
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

IconosNombre=eDocModuloVistaAyuda:eDocModuloVistaAyuda.Campo
FiltroGeneral=eDocModuloVistaAyuda.Modulo = {Comillas(Info.Modulo)}<BR>AND eDocModuloVistaAyuda.Vista  = {Comillas(Info.Vista)}<BR>{Si( Vacio(Info.Campo) o (Info.Campo = <T><T>),<T><T>,<T> AND eDocModuloVistaAyuda.Campo Like <T> & Comillas(<T>%<T> & Info.Campo & <T>%<T>))}
[Lista.eDocModuloVistaAyuda.Descripcion]
Carpeta=Lista
Clave=eDocModuloVistaAyuda.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
0=165
1=538
