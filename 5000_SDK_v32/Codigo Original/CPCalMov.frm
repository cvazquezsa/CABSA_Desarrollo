[Forma]
Clave=CPCalMov
Icono=0
Modulos=(Todos)
Nombre=Si(Info.Tipo=<T>Ampliacion<T>, <T>Reservar<T>, <T>Desreservar<T>)+<T> Flujo Movimiento<T>

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Ejercicio)
PosicionInicialAlturaCliente=547
PosicionInicialAncho=551
PosicionInicialIzquierda=407
PosicionInicialArriba=92
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Totalizadores=S
PosicionSec1=241
ExpresionesAlMostrar=EjecutarSQL(<T>spCPCalMovAyuda :nEstacion, :tModulo, :nID<T>,  EstacionTrabajo, Info.Modulo, Info.ID)
PosicionCol1=320
PosicionSec2=485
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CPCalMov
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
FiltroGeneral=CPCalMov.Modulo=<T>{Info.Modulo}<T> AND CPCalMov.ModuloID={Info.ID} AND CPCalMov.Ejercicio={Info.Ejercicio} AND CPCalMov.Tipo=<T>{Info.Tipo}<T>
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
EjecucionCondicion=Si<BR>  Redondea(Info.Importe, 2)=Redondea(Suma(CPCalMov:CPCalMov.Importe), 2)<BR>Entonces<BR>  Verdadero<BR>Sino<BR> Si<BR>   Confirmacion(<T>No Corresponde (Diferencia: <T>+ MonetarioEnTexto(Abs(Info.Importe-Suma(CPCalMov:CPCalMov.Importe)))+<T>)<T>+NuevaLinea+NuevaLinea+<T>¿ Desea Continuar ?<T>,BotonSi, BotonNo)=BotonSi<BR> Entonces<BR>   Verdadero<BR> Sino<BR>   Falso<BR> Fin<BR>Fin
[Lista.Columnas]
Periodo=58
Importe=125



PeriodoNombre=121

Ejercicio=49
ClavePresupuestal=205
0=-2
1=227
2=-2
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
Zona=C1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Total<BR>Importe<BR>por Aplicar
Totalizadores2=Suma(CPCalMov:CPCalMov.Importe)<BR>Info.Importe<BR>Info.Importe-Suma(CPCalMov:CPCalMov.Importe)
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
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





















[Lista.CPCalMov.Periodo]
Carpeta=Lista
Clave=CPCalMov.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CPCalMov.Importe]
Carpeta=Lista
Clave=CPCalMov.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro















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











Pegado=S
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
ListaParametros1=Info.ClavePresupuestal<BR>Info.Nombre<BR>CPCalMov:CPCalMov.Periodo<BR>CPCalMov:CPCalMov.Importe
ListaParametros=S




























Activo=S










VisibleCondicion=Info.PuedeEditar

[Lista.CPCalMov.ClavePresupuestal]
Carpeta=Lista
Clave=CPCalMov.ClavePresupuestal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro







[Ayuda]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Ayuda
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CPCalMovAyuda
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave Presupuestal<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
MenuLocal=S

ListaAcciones=AyudaPersonalizar
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=CPCalMovAyuda:CPCalMovAyuda.ClavePresupuestal
FiltroGeneral=CPCalMovAyuda.Estacion={EstacionTrabajo}
[Ayuda.ClavePresupuestal.Nombre]
Carpeta=Ayuda
Clave=ClavePresupuestal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Ayuda.CPCalMovAyuda.Importe]
Carpeta=Ayuda
Clave=CPCalMovAyuda.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



Totalizador=1
[Ayuda.Columnas]
0=-2
1=236
2=139






[Acciones.AyudaPersonalizar]
Nombre=AyudaPersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
Carpeta=Ayuda
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S


[(Carpeta Totalizadores).por Aplicar]
Carpeta=(Carpeta Totalizadores)
Clave=por Aplicar
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Gris
Efectos=[Negritas]



Pegado=S






[Acciones.Copiar]
Nombre=Copiar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Copiar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(CPCalMov:CPCalMov.Importe,Info.Importe-Suma(CPCalMov:CPCalMov.Importe))




[Lista.ListaEnCaptura]
(Inicio)=CPCalMov.ClavePresupuestal
CPCalMov.ClavePresupuestal=CPCalMov.Periodo
CPCalMov.Periodo=PeriodoNombre
PeriodoNombre=CPCalMov.Importe
CPCalMov.Importe=(Fin)









[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe
Importe=por Aplicar
por Aplicar=Total
Total=(Fin)




















[Ayuda.ListaEnCaptura]
(Inicio)=ClavePresupuestal.Nombre
ClavePresupuestal.Nombre=CPCalMovAyuda.Importe
CPCalMovAyuda.Importe=(Fin)









[Forma.ListaCarpetas]
(Inicio)=Ayuda
Ayuda=Lista
Lista=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Asistente
Asistente=(Fin)
