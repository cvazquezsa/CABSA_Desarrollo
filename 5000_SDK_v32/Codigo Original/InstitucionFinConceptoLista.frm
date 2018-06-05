[Forma]
Clave=InstitucionFinConceptoLista
Nombre=Conceptos (Conciliación)
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Cuenta
ListaAcciones=Seleccionar
PosicionInicialIzquierda=755
PosicionInicialArriba=323
PosicionInicialAlturaCliente=518
PosicionInicialAncho=409
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InstitucionFinConcepto
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
PermiteEditar=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=(Lista)
ValidarCampos=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Concepto<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Conceptos
IconosNombre=InstitucionFinConcepto:InstitucionFinConcepto.ConceptoBanco
FiltroGeneral=InstitucionFinConcepto.Institucion=<T>{Info.Cuenta}<T>

[Lista.Columnas]
ConceptoBanco=264
TipoMovimiento=84
ConceptoGasto=171
PermiteAbonoNoIdentificado=172
Acreedor=91
0=325

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

[Lista.ListaOrden]
(Inicio)=InstitucionFinConcepto.TipoMovimiento<TAB>(Acendente)
InstitucionFinConcepto.TipoMovimiento<TAB>(Acendente)=InstitucionFinConcepto.ConceptoBanco<TAB>(Acendente)
InstitucionFinConcepto.ConceptoBanco<TAB>(Acendente)=(Fin)
