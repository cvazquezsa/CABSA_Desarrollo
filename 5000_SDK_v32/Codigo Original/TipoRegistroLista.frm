
[Forma]
Clave=TipoRegistroLista
Icono=0
Modulos=(Todos)
Nombre=Tipo Registro

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=470
PosicionInicialArriba=300
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoRegistro
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tipo Identificacion<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S


ListaEnCaptura=TipoRegistro.Concepto
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=TipoRegistro:TipoRegistro.TipoRegistro
FiltroGeneral=(<T>{Info.Tipo}<T> = TipoRegistro.TipoContacto)  AND (TipoRegistro.VigenciaD <= <T>{FechaFormatoServidor(HOY)}<T>)<BR>OR (<T>{Info.Tipo}<T> = TipoRegistro.TipoID)  AND (TipoRegistro.VigenciaD <= <T>{FechaFormatoServidor(HOY)}<T>)<BR>OR (TipoRegistro.TipoContacto = <T>(Todos)<T>)  AND (TipoRegistro.VigenciaD <= <T>{FechaFormatoServidor(HOY)}<T>)
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

[Lista.TipoRegistro.Concepto]
Carpeta=Lista
Clave=TipoRegistro.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
