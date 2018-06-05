[Forma]
Clave=CPCal
Icono=0
Modulos=(Todos)
Nombre=Calendarización Flujo

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Ejercicio, Info.ClavePresupuestal, Info.Tipo)
PosicionInicialAlturaCliente=312
PosicionInicialAncho=549
PosicionInicialIzquierda=425
PosicionInicialArriba=352
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Totalizadores=S
PosicionSec1=248
ExpresionesAlMostrar=EjecutarSQL(<T>spCPCal :nID, :nEjercicio, :tClave, :tTipo<T>, Info.ID, Info.Ejercicio, Info.ClavePresupuestal, Info.Tipo)
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CPCal
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

CondicionEdicion=Info.PuedeEditar


MenuLocal=S
ListaAcciones=Copiar
FiltroGeneral=CPCal.ID={Info.ID} AND CPCal.Ejercicio={Info.Ejercicio} AND CPCal.ClavePresupuestal=<T>{Info.ClavePresupuestal}<T> AND CPCal.Tipo=<T>{Info.Tipo}<T>
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

NombreEnBoton=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Redondea(Info.Importe, 2)=Redondea(Suma(CPCal:CPCal.Importe), 2)
EjecucionMensaje=<T>No Corresponde (Diferencia: <T>+ MonetarioEnTexto(Abs(Info.Importe-Suma(CPCal:CPCal.Importe)))+<T>)<T>
[Lista.Columnas]
Periodo=58
Importe=139



PeriodoNombre=127

Ejercicio=49
[Lista.PeriodoNombre]
Carpeta=Lista
Clave=PeriodoNombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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
Totalizadores1=Total<BR>Importe<BR>por Aplicar
Totalizadores2=Suma(CPCal:CPCal.Importe)<BR>Info.Importe<BR>Info.Importe-Suma(CPCal:CPCal.Importe)
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Gris
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]


Pegado=S
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
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Cancelar Cambios
Cancelar Cambios=Cancelar
Cancelar=(Fin)





















[Lista.CPCal.Periodo]
Carpeta=Lista
Clave=CPCal.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CPCal.Importe]
Carpeta=Lista
Clave=CPCal.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco















[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]











[Acciones.Asistente]
Nombre=Asistente
Boton=12
NombreEnBoton=S
NombreDesplegar=A&sistente
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Wizards
ClaveAccion=Asistente Presupuestos
ListaParametros1=Info.ClavePresupuestal<BR>Info.Nombre<BR>CPCal:CPCal.Periodo<BR>CPCal:CPCal.Importe
ListaParametros=S




























Activo=S
VisibleCondicion=Info.PuedeEditar












[(Carpeta Totalizadores).por Aplicar]
Carpeta=(Carpeta Totalizadores)
Clave=por Aplicar
Editar=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Gris
Efectos=[Negritas]



ValidaNombre=S

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe
Importe=por Aplicar
por Aplicar=Total
Total=(Fin)


[Acciones.Copiar]
Nombre=Copiar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=<T>&Copiar<T>
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(CPCal:CPCal.Importe, Info.Importe-Suma(CPCal:CPCal.Importe))
Activo=S
Visible=S


[Acciones.Ejercicio]
Nombre=Ejercicio
Boton=53
NombreEnBoton=S
NombreDesplegar=&Ejercicio
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EspecificarEjercicio
Activo=S






[Lista.ListaEnCaptura]
(Inicio)=CPCal.Periodo
CPCal.Periodo=PeriodoNombre
PeriodoNombre=CPCal.Importe
CPCal.Importe=CPCal.Ejercicio
CPCal.Ejercicio=(Fin)

[Lista.CPCal.Ejercicio]
Carpeta=Lista
Clave=CPCal.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Asistente
Asistente=Ejercicio
Ejercicio=(Fin)
