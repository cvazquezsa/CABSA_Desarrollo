[Forma]
Clave=InformeContResultados
Nombre=Estado de Resultados
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=RepParam
PosicionInicialIzquierda=496
PosicionInicialArriba=206
PosicionInicialAltura=375
PosicionInicialAncho=607
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
AccionesTamanoBoton=25x5
AccionesCentro=S
ListaAcciones=(Lista)
AccionesDivision=S
BarraHerramientas=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=419

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
Pegado=S
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
Expresion=GuardarCambios<BR>Informe( <T>InformeContResultados<T>, RepParam:RepParam.InfoTituloContRes)
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
LineaNueva=S
ColorFondo=Blanco

[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S



[Acciones.Imprimir.ContResultados]
Nombre=ContResultados
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si(Info.AgruparCC=<T>No<T>, ReporteImpresora(<T>ContResultados<T>), ReporteImpresora(<T>ContResultadosCC<T>))

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

[(Variables).Info.CentroCostos]
Carpeta=(Variables)
Clave=Info.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco

[(Variables).Rep.Titulo]
Carpeta=(Variables)
Clave=Rep.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
EspacioPrevio=S

[(Variables).Rep.Sucursal]
Carpeta=(Variables)
Clave=Rep.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Desglosar]
Carpeta=(Variables)
Clave=Info.Desglosar
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
Pegado=S

[(Variables).Info.AgruparCC]
Carpeta=(Variables)
Clave=Info.AgruparCC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ContMoneda]
Carpeta=(Variables)
Clave=Info.ContMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Grupo]
Carpeta=(Variables)
Clave=Info.Grupo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
Pegado=N





[(Variables).Info.CentroCostos2]
Carpeta=(Variables)
Clave=Info.CentroCostos2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.CentroCostos3]
Carpeta=(Variables)
Clave=Info.CentroCostos3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Proyecto]
Carpeta=(Variables)
Clave=Info.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.UEN]
Carpeta=(Variables)
Clave=Info.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco














[(Variables).Info.AlCentroCostos]
Carpeta=(Variables)
Clave=Info.AlCentroCostos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.AlCentroCostos2]
Carpeta=(Variables)
Clave=Info.AlCentroCostos2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.AlCentroCostos3]
Carpeta=(Variables)
Clave=Info.AlCentroCostos3
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Acciones.RepPan.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=ContResultados
ContResultados=(Fin)






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
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
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
Pestana=S
PestanaOtroNombre=S
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
EspacioPrevio=N
[RepParam.RepParam.InfoPeriodoD]
Carpeta=RepParam
Clave=RepParam.InfoPeriodoD
Editar=S
LineaNueva=S
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
Pegado=S
[RepParam.RepParam.InfoConMovs]
Carpeta=RepParam
Clave=RepParam.InfoConMovs
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[RepParam.RepParam.InfoDesglosar]
Carpeta=RepParam
Clave=RepParam.InfoDesglosar
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

Pegado=S
[RepParam.RepParam.InfoCentroCostos]
Carpeta=RepParam
Clave=RepParam.InfoCentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=N
[RepParam.RepParam.InfoCentroCostos2]
Carpeta=RepParam
Clave=RepParam.InfoCentroCostos2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoCentroCostos3]
Carpeta=RepParam
Clave=RepParam.InfoCentroCostos3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoProyecto]
Carpeta=RepParam
Clave=RepParam.InfoProyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[RepParam.RepParam.InfoUEN]
Carpeta=RepParam
Clave=RepParam.InfoUEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[RepParam.RepParam.InfoSucursal]
Carpeta=RepParam
Clave=RepParam.InfoSucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





Tamano=20

[RepParam.RepParam.InfoContMoneda]
Carpeta=RepParam
Clave=RepParam.InfoContMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoAlCentroCostos]
Carpeta=RepParam
Clave=RepParam.InfoAlCentroCostos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoAlCentroCostos2]
Carpeta=RepParam
Clave=RepParam.InfoAlCentroCostos2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoAlCentroCostos3]
Carpeta=RepParam
Clave=RepParam.InfoAlCentroCostos3
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco










[Lista.Columnas]
Moneda=144
TipoCambio=69





0=233





[RepParam.RepParam.InfoAgrupadoCC]
Carpeta=RepParam
Clave=RepParam.InfoAgrupadoCC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoGrupoLista]
Carpeta=RepParam
Clave=RepParam.InfoGrupoLista
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco








[RepParam.RepParam.InfoTituloContRes]
Carpeta=RepParam
Clave=RepParam.InfoTituloContRes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=60
ColorFondo=Blanco

[(Variables).ListaEnCaptura]
(Inicio)=Info.Ejercicio
Info.Ejercicio=Info.PeriodoD
Info.PeriodoD=Info.PeriodoA
Info.PeriodoA=Info.ConMovimientos
Info.ConMovimientos=Info.Desglosar
Info.Desglosar=Info.ContMoneda
Info.ContMoneda=Info.CentroCostos
Info.CentroCostos=Info.AlCentroCostos
Info.AlCentroCostos=Info.CentroCostos2
Info.CentroCostos2=Info.AlCentroCostos2
Info.AlCentroCostos2=Info.CentroCostos3
Info.CentroCostos3=Info.AlCentroCostos3
Info.AlCentroCostos3=Info.Proyecto
Info.Proyecto=Info.UEN
Info.UEN=Rep.Sucursal
Rep.Sucursal=Info.AgruparCC
Info.AgruparCC=Info.Grupo
Info.Grupo=Rep.Titulo
Rep.Titulo=(Fin)

















[RepParam.ListaEnCaptura]
(Inicio)=RepParam.InfoEjercicio
RepParam.InfoEjercicio=RepParam.InfoPeriodoD
RepParam.InfoPeriodoD=RepParam.InfoPeriodoA
RepParam.InfoPeriodoA=RepParam.InfoConMovs
RepParam.InfoConMovs=RepParam.InfoDesglosar
RepParam.InfoDesglosar=RepParam.InfoContMoneda
RepParam.InfoContMoneda=RepParam.InfoCentroCostos
RepParam.InfoCentroCostos=RepParam.InfoAlCentroCostos
RepParam.InfoAlCentroCostos=RepParam.InfoCentroCostos2
RepParam.InfoCentroCostos2=RepParam.InfoAlCentroCostos2
RepParam.InfoAlCentroCostos2=RepParam.InfoCentroCostos3
RepParam.InfoCentroCostos3=RepParam.InfoAlCentroCostos3
RepParam.InfoAlCentroCostos3=RepParam.InfoProyecto
RepParam.InfoProyecto=RepParam.InfoUEN
RepParam.InfoUEN=RepParam.InfoSucursal
RepParam.InfoSucursal=RepParam.InfoAgrupadoCC
RepParam.InfoAgrupadoCC=RepParam.InfoGrupoLista
RepParam.InfoGrupoLista=RepParam.InfoTituloContRes
RepParam.InfoTituloContRes=(Fin)




[Grafica]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Grafica
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
FichaEspacioNombres=127
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

FiltroGeneral=RepParam.Estacion={EstacionTrabajo}
[Grafica.RepParam.InfoEtiqueta]
Carpeta=Grafica
Clave=RepParam.InfoEtiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco













[Grafica.ListaEnCaptura]
(Inicio)=RepParam.InfoEtiqueta
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
