[Forma]
Clave=InformeContBalanza
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=RepParam
PosicionInicialIzquierda=598
PosicionInicialArriba=158
PosicionInicialAltura=409
PosicionInicialAncho=403
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
AccionesTamanoBoton=25x5
AccionesCentro=S
ListaAcciones=(Lista)
AccionesDivision=S
Nombre=Balanza de Comprobación
BarraHerramientas=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=516

VentanaEstadoInicial=Normal

VentanaExclusivaOpcion=0
ExpresionesAlMostrar=AUTOEXEC
[(Variables).Info.Ejercicio]
Carpeta=(Variables)
Clave=Info.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[(Variables).Info.PeriodoA]
Carpeta=(Variables)
Clave=Info.PeriodoA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreDesplegar=&Preliminar
EnBarraAcciones=S
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

GuardarAntes=S
TipoAccion=Expresion
Expresion=Asigna(RepParam:RepParam.RepTitulo, <T>Balanza de Comprobación<T>)<BR>GuardarCambios<BR>Informe( <T>InformeContBalanza<T>, RepParam:RepParam.RepTitulo)
[(Variables).Info.ConMovimientos]
Carpeta=(Variables)
Clave=Info.ConMovimientos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[(Variables).Info.PeriodoD]
Carpeta=(Variables)
Clave=Info.PeriodoD
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco


[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Imprimir.ContBalanza]
Nombre=ContBalanza
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=ContBalanza
Activo=S
Visible=S



[(Variables).Info.CtaNivel]
Carpeta=(Variables)
Clave=Info.CtaNivel
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[(Variables).Info.CuentaD]
Carpeta=(Variables)
Clave=Info.CuentaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
EspacioPrevio=S

[(Variables).Info.CuentaA]
Carpeta=(Variables)
Clave=Info.CuentaA
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[(Variables).Info.CentroCostos]
Carpeta=(Variables)
Clave=Info.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

EspacioPrevio=S
[(Variables).Info.CtaCat]
Carpeta=(Variables)
Clave=Info.CtaCat
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[(Variables).Info.CtaGrupo]
Carpeta=(Variables)
Clave=Info.CtaGrupo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[(Variables).Info.CtaFam]
Carpeta=(Variables)
Clave=Info.CtaFam
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
LineaNueva=S

[(Variables).Rep.Sucursal]
Carpeta=(Variables)
Clave=Rep.Sucursal
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

LineaNueva=S
[(Variables).Info.ContMoneda]
Carpeta=(Variables)
Clave=Info.ContMoneda
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
LineaNueva=N





[(Variables).Info.CentroCostos2]
Carpeta=(Variables)
Clave=Info.CentroCostos2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[(Variables).Info.CentroCostos3]
Carpeta=(Variables)
Clave=Info.CentroCostos3
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

LineaNueva=S
[(Variables).Info.Proyecto]
Carpeta=(Variables)
Clave=Info.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco

[(Variables).Info.UEN]
Carpeta=(Variables)
Clave=Info.UEN
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco








































[RepParam]
Estilo=Ficha
Clave=RepParam
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)


PestanaOtroNombre=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
Pestana=S
PestanaNombre=Filtros
FiltroGeneral=RepParam.Estacion={EstacionTrabajo}
[RepParam.RepParam.InfoEjercicio]
Carpeta=RepParam
Clave=RepParam.InfoEjercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=12
[RepParam.RepParam.InfoPeriodoD]
Carpeta=RepParam
Clave=RepParam.InfoPeriodoD
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=12
[RepParam.RepParam.InfoPeriodoA]
Carpeta=RepParam
Clave=RepParam.InfoPeriodoA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco




Tamano=12





[RepParam.RepParam.InfoConMovs]
Carpeta=RepParam
Clave=RepParam.InfoConMovs
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[RepParam.RepParam.InfoCtaNivel]
Carpeta=RepParam
Clave=RepParam.InfoCtaNivel
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco



[RepParam.RepParam.InfoCtaD]
Carpeta=RepParam
Clave=RepParam.InfoCtaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco

[RepParam.RepParam.InfoCtaA]
Carpeta=RepParam
Clave=RepParam.InfoCtaA
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco





[RepParam.RepParam.InfoCentroCostos]
Carpeta=RepParam
Clave=RepParam.InfoCentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco

[RepParam.RepParam.InfoCentroCostos2]
Carpeta=RepParam
Clave=RepParam.InfoCentroCostos2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[RepParam.RepParam.InfoCentroCostos3]
Carpeta=RepParam
Clave=RepParam.InfoCentroCostos3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco


[RepParam.RepParam.InfoUEN]
Carpeta=RepParam
Clave=RepParam.InfoUEN
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco




Tamano=25
[RepParam.RepParam.InfoCtaCat]
Carpeta=RepParam
Clave=RepParam.InfoCtaCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco

[RepParam.RepParam.InfoCtaGrupo]
Carpeta=RepParam
Clave=RepParam.InfoCtaGrupo
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[RepParam.RepParam.InfoCtaFam]
Carpeta=RepParam
Clave=RepParam.InfoCtaFam
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco




[RepParam.RepParam.InfoSucursal]
Carpeta=RepParam
Clave=RepParam.InfoSucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[RepParam.RepParam.InfoMoneda]
Carpeta=RepParam
Clave=RepParam.InfoMoneda
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco



[Lista.Columnas]
Moneda=144
TipoCambio=69
0=91
1=267



CentroCostos=127
Descripcion=235
UEN=44
Nombre=269
Categoria=250

[RepParam.RepParam.InfoProyecto]
Carpeta=RepParam
Clave=RepParam.InfoProyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco



[(Variables).ListaEnCaptura]
(Inicio)=Info.Ejercicio
Info.Ejercicio=Info.PeriodoD
Info.PeriodoD=Info.PeriodoA
Info.PeriodoA=Info.ConMovimientos
Info.ConMovimientos=Info.CtaNivel
Info.CtaNivel=Info.CuentaD
Info.CuentaD=Info.CuentaA
Info.CuentaA=Info.CentroCostos
Info.CentroCostos=Info.CentroCostos2
Info.CentroCostos2=Info.CentroCostos3
Info.CentroCostos3=Info.Proyecto
Info.Proyecto=Info.UEN
Info.UEN=Rep.Sucursal
Rep.Sucursal=Info.ContMoneda
Info.ContMoneda=Info.CtaCat
Info.CtaCat=Info.CtaGrupo
Info.CtaGrupo=Info.CtaFam
Info.CtaFam=(Fin)



































[Grafica]
Estilo=Ficha
PestanaOtroNombre=S
Clave=Grafica
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=132
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
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

Pestana=S
PestanaNombre=Grafica
FiltroGeneral=RepParam.Estacion={EstacionTrabajo}
[Grafica.RepParam.InformeGraficarTipo]
Carpeta=Grafica
Clave=RepParam.InformeGraficarTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Grafica.RepParam.InformeGraficarCantidad]
Carpeta=Grafica
Clave=RepParam.InformeGraficarCantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Grafica.RepParam.InfoEtiqueta]
Carpeta=Grafica
Clave=RepParam.InfoEtiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco









[RepParam.ListaEnCaptura]
(Inicio)=RepParam.InfoEjercicio
RepParam.InfoEjercicio=RepParam.InfoPeriodoD
RepParam.InfoPeriodoD=RepParam.InfoPeriodoA
RepParam.InfoPeriodoA=RepParam.InfoConMovs
RepParam.InfoConMovs=RepParam.InfoCtaNivel
RepParam.InfoCtaNivel=RepParam.InfoCtaD
RepParam.InfoCtaD=RepParam.InfoCtaA
RepParam.InfoCtaA=RepParam.InfoCentroCostos
RepParam.InfoCentroCostos=RepParam.InfoCentroCostos2
RepParam.InfoCentroCostos2=RepParam.InfoCentroCostos3
RepParam.InfoCentroCostos3=RepParam.InfoProyecto
RepParam.InfoProyecto=RepParam.InfoUEN
RepParam.InfoUEN=RepParam.InfoSucursal
RepParam.InfoSucursal=RepParam.InfoMoneda
RepParam.InfoMoneda=RepParam.InfoCtaCat
RepParam.InfoCtaCat=RepParam.InfoCtaGrupo
RepParam.InfoCtaGrupo=RepParam.InfoCtaFam
RepParam.InfoCtaFam=(Fin)











[Grafica.ListaEnCaptura]
(Inicio)=RepParam.InformeGraficarTipo
RepParam.InformeGraficarTipo=RepParam.InformeGraficarCantidad
RepParam.InformeGraficarCantidad=RepParam.InfoEtiqueta
RepParam.InfoEtiqueta=RepParam.VerGraficaDetalle
RepParam.VerGraficaDetalle=(Fin)

[Grafica.RepParam.VerGraficaDetalle]
Carpeta=Grafica
Clave=RepParam.VerGraficaDetalle
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Forma.ListaCarpetas]
(Inicio)=RepParam
RepParam=Grafica
Grafica=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=RepPan
RepPan=(Fin)
