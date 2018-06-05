[Forma]
Clave=PuestoCompetenciaTipo
Icono=0
Modulos=(Todos)
Nombre=Tipos Competencias del Puesto

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=474
PosicionInicialArriba=162
PosicionInicialAlturaCliente=407
PosicionInicialAncho=417
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Puesto
Totalizadores=S
PosicionSec1=341
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PuestoCompetenciaTipo
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

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CompetenciaTipo
FiltroAplicaEn1=Competencia.Tipo

FiltroGeneral=PuestoCompetenciaTipo.Puesto=<T>{Info.Puesto}<T>
[Lista.PuestoCompetenciaTipo.Peso]
Carpeta=Lista
Clave=PuestoCompetenciaTipo.Peso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.Columnas]
Competencia=124
Peso=64


Nombre=304
Tipo=304
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S



ConCondicion=S
EjecucionCondicion=Suma(PuestoCompetenciaTipo:PuestoCompetenciaTipo.Peso)=100
EjecucionMensaje=<T>No Cuadra<T>
EjecucionConError=S
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
Totalizadores1=Peso
Totalizadores2=Suma(PuestoCompetenciaTipo:PuestoCompetenciaTipo.Peso)
Totalizadores3=#.##%
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=$00808040
CampoColorFondo=Plata
ListaEnCaptura=Peso
CarpetaVisible=S

[(Carpeta Totalizadores).Peso]
Carpeta=(Carpeta Totalizadores)
Clave=Peso
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]






[Lista.PuestoCompetenciaTipo.Tipo]
Carpeta=Lista
Clave=PuestoCompetenciaTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=PuestoCompetenciaTipo.Tipo
PuestoCompetenciaTipo.Tipo=PuestoCompetenciaTipo.Peso
PuestoCompetenciaTipo.Peso=(Fin)
