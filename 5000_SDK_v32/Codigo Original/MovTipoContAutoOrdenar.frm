[Forma]
Clave=MovTipoContAutoOrdenar
Nombre=Ordenar Póliza
Icono=48
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=432
PosicionInicialArriba=309
PosicionInicialAltura=398
PosicionInicialAncho=415
AccionesTamanoBoton=15x5
AccionesDerecha=S
BarraHerramientas=S
ListaAcciones=(Lista)
Comentarios=<T>Utilice arrastrar y soltar para cambiar el orden<T>
VentanaExclusiva=S
PosicionInicialAlturaCliente=371

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoContAuto
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Orden<T>
ElementosPorPagina=200
IconosCambiarOrden=S
PestanaOtroNombre=S
PestanaNombre=Registros
OtroOrden=S
ListaEnCaptura=MovTipoContAuto.Nombre
ListaOrden=MovTipoContAuto.Orden<TAB>(Acendente)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=MovTipoContAuto:MovTipoContAuto.Orden
FiltroGeneral=MovTipoContAuto.Modulo=<T>{Info.Modulo}<T> AND<BR>MovTipoContAuto.Clave=<T>{Info.Clave}<T>

[Lista.Columnas]
Orden=42
Centro=114
Descripcion=236
0=46
1=289

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Ordenar]
Nombre=Ordenar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar Nuevo Orden
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S
ClaveAccion=Cerrar
Antes=S

AntesExpresiones=RegistrarListaSt(<T>Lista<T>, <T>MovTipoContAuto.Nombre<T>)<BR>EjecutarSQL(<T>spOrdenarMaestro :nEstacion, :tTabla, :tModulo, NULL, :tCta, :tLlave<T>, EstacionTrabajo, <T>MovTipoContAuto<T>, Info.Modulo, Info.Clave, Info.Empresa)
[Lista.MovTipoContAuto.Nombre]
Carpeta=Lista
Clave=MovTipoContAuto.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro





[Forma.ListaAcciones]
(Inicio)=Ordenar
Ordenar=Campos
Campos=(Fin)
