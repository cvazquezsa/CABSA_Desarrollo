
[Forma]
Clave=PuestoCompetencia
Icono=0
Modulos=(Todos)
Nombre=Competencias del Puesto

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=411
PosicionInicialArriba=162
PosicionInicialAlturaCliente=407
PosicionInicialAncho=606
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
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
Vista=PuestoCompetencia
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
FiltroTipo=Automático
CarpetaVisible=S

FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CompetenciaTipo
FiltroAplicaEn1=Competencia.Tipo
FiltroAplicaEn=Competencia.Tipo
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=CompetenciaTipo
FiltroEstilo=Directorio
FiltroGeneral=PuestoCompetencia.Puesto=<T>{Info.Puesto}<T>
[Lista.PuestoCompetencia.Competencia]
Carpeta=Lista
Clave=PuestoCompetencia.Competencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.PuestoCompetencia.Peso]
Carpeta=Lista
Clave=PuestoCompetencia.Peso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.Columnas]
Competencia=124
Peso=64


Nombre=304
ValorMinimo=64
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


Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Temp.Texto, SQL(<T>spPuestoCompetenciaOk :tPuesto<T>, Info.Puesto))<BR>Si<BR>  ConDatos(Temp.Texto)<BR>Entonces<BR>  Error(e(<T>No Cuadra: <T>)+Temp.Texto)<BR>  AbortarOperacion<BR>Fin
[Lista.Competencia.Nombre]
Carpeta=Lista
Clave=Competencia.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

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
Totalizadores2=Suma(PuestoCompetencia:PuestoCompetencia.Peso)
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




[Acciones.Tipos]
Nombre=Tipos
Boton=16
NombreEnBoton=S
NombreDesplegar=&Peso por Tipo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=PuestoCompetenciaTipo
Activo=S
Visible=S



EspacioPrevio=S









[Lista.ListaEnCaptura]
(Inicio)=PuestoCompetencia.Competencia
PuestoCompetencia.Competencia=Competencia.Nombre
Competencia.Nombre=PuestoCompetencia.Peso
PuestoCompetencia.Peso=PuestoCompetencia.ValorMinimo
PuestoCompetencia.ValorMinimo=(Fin)

[Lista.PuestoCompetencia.ValorMinimo]
Carpeta=Lista
Clave=PuestoCompetencia.ValorMinimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Tipos
Tipos=(Fin)
