[Forma]
Clave=CampanaEncuesta
Nombre=Encuesta
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=566
PosicionInicialArriba=319
PosicionInicialAlturaCliente=526
PosicionInicialAncho=787
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Clave, Info.Nombre)
VentanaExclusiva=S
ExpresionesAlMostrar=EjecutarSQL(<T>spCampanaEncuesta :nID, :nRID, :tCampanaTipo<T>, Info.ID, Info.RID, Info.Tipo)
PosicionSec1=408

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaEncuesta
Fuente={Tahoma, 8, Negro, []}
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
OtroOrden=S
ListaOrden=CampanaTipoEncuesta.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CondicionEdicion=Info.PuedeEditar
FiltroGeneral=CampanaEncuesta.ID={Info.ID} AND CampanaEncuesta.RID={Info.RID}

[Lista.CampanaTipoEncuesta.Nombre]
Carpeta=Lista
Clave=CampanaTipoEncuesta.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Lista.CampanaEncuesta.Respuesta]
Carpeta=Lista
Clave=CampanaEncuesta.Respuesta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Antes=S
AntesExpresiones=EjecutarSQL(<T>spCampanaEncuestaAceptar :nID, :nRID<T>, Info.ID, Info.RID)
DespuesGuardar=S

[Lista.Columnas]
Nombre=396
Respuesta=341

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Descripcion]
Estilo=Ficha
Clave=Descripcion
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CampanaEncuesta
Fuente={Tahoma, 12, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=CampanaTipoEncuesta.Descripcion
CarpetaVisible=S
AlinearTodaCarpeta=S
ConFuenteEspecial=S

[Descripcion.CampanaTipoEncuesta.Descripcion]
Carpeta=Descripcion
Clave=CampanaTipoEncuesta.Descripcion
Editar=S
ValidaNombre=N
3D=S
Tamano=255x2
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Descripcion
Descripcion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CampanaTipoEncuesta.Nombre
CampanaTipoEncuesta.Nombre=CampanaEncuesta.Respuesta
CampanaEncuesta.Respuesta=(Fin)
