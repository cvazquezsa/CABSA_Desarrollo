[Forma]
Clave=NomXFormulaOrdenar
Nombre=Cambiar Orden - Fórmulas
Icono=48
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=261
PosicionInicialArriba=115
PosicionInicialAltura=531
PosicionInicialAncho=501
AccionesTamanoBoton=15x5
AccionesDerecha=S
BarraHerramientas=S
ListaAcciones=(Lista)
Comentarios=<T>Utilice arrastrar y soltar para cambiar el orden<T>
PosicionInicialAlturaCliente=504

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NomXFormula
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Fórmula<T>
ElementosPorPagina=200
IconosCambiarOrden=S
OtroOrden=S
ListaOrden=(Lista)
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
IconosNombreNumerico=S
IconosNombre=NomXFormula:NomXFormula.Formula
FiltroGeneral=NomXFormula.ID={Info.ID} AND NomXFormula.Tipo=<T>Formula<T>

[Lista.Columnas]
Orden=42
Centro=114
Descripcion=236
0=358
1=57

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
AntesExpresiones=RegistrarListaSt(<T>Lista<T>, <T>NomXFormula.Formula<T>)<BR>EjecutarSQL(<T>spOrdenarMaestro :nEstacion, :tTabla, NULL, :nID<T>, EstacionTrabajo, <T>NomXFormula<T>, Info.ID)

[Lista.NomXFormula.Calculo]
Carpeta=Lista
Clave=NomXFormula.Calculo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NomXFormula.Orden]
Carpeta=Lista
Clave=NomXFormula.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cambiar Estilo (Iconos)]
Nombre=Cambiar Estilo (Iconos)
Boton=0
NombreDesplegar=Cambiar Estilo (Iconos)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Estilo (Iconos)
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Ordenar
Ordenar=Campos
Campos=Cambiar Estilo (Iconos)
Cambiar Estilo (Iconos)=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=NomXFormula.Calculo
NomXFormula.Calculo=NomXFormula.Orden
NomXFormula.Orden=(Fin)

[Lista.ListaOrden]
(Inicio)=NomXFormula.Calculo<TAB>(Decendente)
NomXFormula.Calculo<TAB>(Decendente)=NomXFormula.Orden<TAB>(Acendente)
NomXFormula.Orden<TAB>(Acendente)=(Fin)
