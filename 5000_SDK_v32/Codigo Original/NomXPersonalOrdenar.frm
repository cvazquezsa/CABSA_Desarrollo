[Forma]
Clave=NomXPersonalOrdenar
Nombre=Cambiar Orden - Recibo
Icono=48
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=296
PosicionInicialArriba=110
PosicionInicialAltura=540
PosicionInicialAncho=432
AccionesTamanoBoton=15x5
AccionesDerecha=S
BarraHerramientas=S
ListaAcciones=(Lista)
Comentarios=<T>Utilice arrastrar y soltar para cambiar el orden<T>
PosicionInicialAlturaCliente=513

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NomXPersonal
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=NomXPersonal.Concepto
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Orden<T>
ElementosPorPagina=200
IconosCambiarOrden=S
OtroOrden=S
ListaOrden=NomXPersonal.Orden<TAB>(Acendente)
PestanaOtroNombre=S
PestanaNombre=Registros
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=NomXPersonal:NomXPersonal.Orden
IconosNombreNumerico=S
FiltroGeneral=NomXPersonal.ID={Info.ID}

[Lista.Columnas]
Orden=42
Centro=114
Descripcion=236
0=60
1=298

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
AntesExpresiones=RegistrarListaSt(<T>Lista<T>, <T>NomXPersonal.Concepto<T>)<BR>EjecutarSQL(<T>spOrdenarMaestro :nEstacion, :tTabla, NULL, :nID<T>, EstacionTrabajo, <T>NomXPersonal<T>, Info.ID)

[Lista.NomXPersonal.Concepto]
Carpeta=Lista
Clave=NomXPersonal.Concepto
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
