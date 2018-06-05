
[Forma]
Clave=VarReporteSUA
Icono=5
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Especificar Reporte
VentanaTipoMarco=Normal
VentanaPosicionInicial=Por diseño
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
VentanaColor=Plata
BarraAcciones=S
AccionesTamanoBoton=15x5
AccionesCentro=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=588
PosicionInicialArriba=230
PosicionInicialAlturaCliente=220
PosicionInicialAncho=284
ListaAcciones=(Lista)
[Lista]
Estilo=Ficha
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SUAFiltro
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
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

FiltroGeneral={<T>SUAFiltro.Estacion = <T>& Comillas(EstacionTrabajo)} AND {<T>SUAFiltro.Empresa = <T>& Comillas(Empresa)}
[Lista.SUAFiltro.Reporte]
Carpeta=Lista
Clave=SUAFiltro.Reporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15

ColorFondo=Blanco
[Lista.SUAFiltro.RegistroPatronal]
Carpeta=Lista
Clave=SUAFiltro.RegistroPatronal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.SUAFiltro.Ejercicio]
Carpeta=Lista
Clave=SUAFiltro.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.SUAFiltro.Periodo]
Carpeta=Lista
Clave=SUAFiltro.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=&Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreDesplegar=&Aceptar
GuardarAntes=S
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S












[Acciones.Aceptar.Variables]
Nombre=Variables
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S










Expresion=Asigna(Info.Reporte,SUAFiltro:SUAFiltro.Reporte)<BR>Asigna(Info.SUARegistroPatronal,SUAFiltro:SUAFiltro.RegistroPatronal)<BR>Asigna(Info.Ejercicio,SUAFiltro:SUAFiltro.Ejercicio)<BR>Asigna(Info.Periodo,SUAFiltro:SUAFiltro.Periodo)<BR>EjecutarSQL(<T>EXEC spSUA :nEstacion, :tEmpresa, :tReporte, :tRegistroPatronal, :nEjercicio, :nPeriodo<T>, EstacionTrabajo, Empresa, Info.Reporte, Info.SUARegistroPatronal, Info.Ejercicio, Info.Periodo)
[SUAComparacion.Columnas]
NSS=141
Nombre=163
Origen=110
Tipo=98
Fecha=107
Dias=64
SDI=64
TipoDescuento=95
ValorDescuento=99
Credito=124















OrigenDatos=64



[Lista.ListaEnCaptura]
(Inicio)=SUAFiltro.Reporte
SUAFiltro.Reporte=SUAFiltro.RegistroPatronal
SUAFiltro.RegistroPatronal=SUAFiltro.Ejercicio
SUAFiltro.Ejercicio=SUAFiltro.Periodo
SUAFiltro.Periodo=(Fin)
















[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Variables
Variables=Cerrar
Cerrar=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
