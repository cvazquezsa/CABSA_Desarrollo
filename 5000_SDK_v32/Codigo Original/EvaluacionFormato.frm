[Forma]
Clave=EvaluacionFormato
Nombre=Formato de Evaluación
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=613
PosicionInicialArriba=371
PosicionInicialAlturaCliente=422
PosicionInicialAncho=694
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionSeccion1=91
PosicionSeccion2=91
Comentarios=Info.Evaluacion
Totalizadores=S
PosicionColumna1=74
PosicionSec1=359

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EvaluacionFormato
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
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=(Lista)
FiltroAplicaEn=EvaluacionFormato.Seccion
FiltroAutoCampo=EvaluacionFormato.Seccion
FiltroAutoValidar=EvaluacionFormato.Seccion
FiltroGeneral=EvaluacionFormato.Evaluacion=<T>{Info.Evaluacion}<T>

[Lista.EvaluacionFormato.Punto]
Carpeta=Lista
Clave=EvaluacionFormato.Punto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Lista.EvaluacionFormato.Seccion]
Carpeta=Lista
Clave=EvaluacionFormato.Seccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EvaluacionFormato.Peso]
Carpeta=Lista
Clave=EvaluacionFormato.Peso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Punto=322
Descripcion=407
Seccion=93
Peso=43
Tipo=54
Respuesta=59
Referencia=134

[Ficha.EvaluacionFormato.Descripcion]
Carpeta=Ficha
Clave=EvaluacionFormato.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=50x3
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Total
Totalizadores2=Suma( EvaluacionFormato:EvaluacionFormato.Peso )
Totalizadores3=#.##%
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total
CarpetaVisible=S

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar &Orden
EnBarraHerramientas=S
Activo=S
Visible=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Antes=S
GuardarAntes=S
AntesExpresiones=Forma(<T>EvaluacionFormatoOrdenar<T>)
DespuesGuardar=S

[Desc.EvaluacionFormato.Descripcion]
Carpeta=Desc
Clave=EvaluacionFormato.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20x10
ColorFondo=Blanco
ColorFuente=Negro

[Desc.EvaluacionFormato.Punto]
Carpeta=Desc
Clave=EvaluacionFormato.Punto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Descripcion]
Nombre=Descripcion
Boton=38
NombreEnBoton=S
NombreDesplegar=&Descripción
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EvaluacionFormatoDesc
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
GuardarAntes=S
AntesExpresiones=Asigna(Info.Nombre, EvaluacionFormato:EvaluacionFormato.Punto)
DespuesGuardar=S

[Lista.EvaluacionFormato.Respuesta]
Carpeta=Lista
Clave=EvaluacionFormato.Respuesta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EvaluacionFormato.Referencia]
Carpeta=Lista
Clave=EvaluacionFormato.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Descripcion
Descripcion=Ordenar
Ordenar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=EvaluacionFormato.Punto
EvaluacionFormato.Punto=EvaluacionFormato.Seccion
EvaluacionFormato.Seccion=EvaluacionFormato.Respuesta
EvaluacionFormato.Respuesta=EvaluacionFormato.Peso
EvaluacionFormato.Peso=EvaluacionFormato.Referencia
EvaluacionFormato.Referencia=(Fin)

[Lista.ListaOrden]
(Inicio)=EvaluacionFormato.Orden<TAB>(Acendente)
EvaluacionFormato.Orden<TAB>(Acendente)=EvaluacionFormato.Punto<TAB>(Acendente)
EvaluacionFormato.Punto<TAB>(Acendente)=(Fin)
