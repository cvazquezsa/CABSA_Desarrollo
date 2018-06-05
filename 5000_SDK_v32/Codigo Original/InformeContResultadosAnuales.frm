[Forma]
Clave=InformeContResultadosAnuales
Nombre=Estado de Resultados (Varios Ejercicios)
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=RepParam
PosicionInicialIzquierda=552
PosicionInicialArriba=204
PosicionInicialAltura=375
PosicionInicialAncho=495
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
AccionesTamanoBoton=25x5
AccionesCentro=S
ListaAcciones=(Lista)
AccionesDivision=S
BarraHerramientas=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=424

VentanaEstadoInicial=Normal

VentanaExclusivaOpcion=0
ExpresionesAlMostrar=AUTOEXEC
[(Variables).Info.PeriodoA]
Carpeta=(Variables)
Clave=Info.PeriodoA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
Pegado=N
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
Expresion=GuardarCambios<BR>Informe( <T>InformeContResultadosAnulaes<T>, RepParam:RepParam.InfoTituloContResAnual)
[(Variables).Info.ConMovimientos]
Carpeta=(Variables)
Clave=Info.ConMovimientos
Editar=S
LineaNueva=N
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
Tamano=45
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
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
Pegado=N

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
Tamano=18
ColorFondo=Blanco
Pegado=S

[(Variables).Info.EjercicioD]
Carpeta=(Variables)
Clave=Info.EjercicioD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[(Variables).Info.EjercicioA]
Carpeta=(Variables)
Clave=Info.EjercicioA
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco


[Acciones.Imprimir.ContResultadosAnuales]
Nombre=ContResultadosAnuales
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si(Info.AgruparCC=<T>No<T>, ReporteImpresora(<T>ContResultados<T>), ReporteImpresora(<T>ContResultadosAnualesCC<T>))

[(Variables).Info.RepAnuales]
Carpeta=(Variables)
Clave=Info.RepAnuales
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco



[Acciones.RepPan.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=ContResultadosAnuales
ContResultadosAnuales=(Fin)



















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
[RepParam.RepParam.InfoPeriodoA]
Carpeta=RepParam
Clave=RepParam.InfoPeriodoA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=12
[RepParam.RepParam.InfoConMovs]
Carpeta=RepParam
Clave=RepParam.InfoConMovs
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[RepParam.RepParam.InfoDesglosar]
Carpeta=RepParam
Clave=RepParam.InfoDesglosar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco




[RepParam.RepParam.InfoContMoneda]
Carpeta=RepParam
Clave=RepParam.InfoContMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[RepParam.RepParam.InfoCentroCostos]
Carpeta=RepParam
Clave=RepParam.InfoCentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

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
[RepParam.RepParam.InfoAgrupadoCC]
Carpeta=RepParam
Clave=RepParam.InfoAgrupadoCC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[RepParam.RepParam.InfoGrupoLista]
Carpeta=RepParam
Clave=RepParam.InfoGrupoLista
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco




Pegado=S
[RepParam.RepParam.InfoEjercicioD]
Carpeta=RepParam
Clave=RepParam.InfoEjercicioD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[RepParam.RepParam.InfoEjercicioA]
Carpeta=RepParam
Clave=RepParam.InfoEjercicioA
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[RepParam.RepParam.InfoTituloContResAnual]
Carpeta=RepParam
Clave=RepParam.InfoTituloContResAnual
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=45
ColorFondo=Blanco










[(Variables).ListaEnCaptura]
(Inicio)=Info.EjercicioD
Info.EjercicioD=Info.EjercicioA
Info.EjercicioA=Info.PeriodoA
Info.PeriodoA=Info.ConMovimientos
Info.ConMovimientos=Info.Desglosar
Info.Desglosar=Info.RepAnuales
Info.RepAnuales=Info.ContMoneda
Info.ContMoneda=Info.CentroCostos
Info.CentroCostos=Info.CentroCostos2
Info.CentroCostos2=Info.CentroCostos3
Info.CentroCostos3=Info.Proyecto
Info.Proyecto=Info.UEN
Info.UEN=Rep.Sucursal
Rep.Sucursal=Info.AgruparCC
Info.AgruparCC=Info.Grupo
Info.Grupo=Rep.Titulo
Rep.Titulo=(Fin)





[RepParam.RepParam.InfoContResAnual]
Carpeta=RepParam
Clave=RepParam.InfoContResAnual
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco






























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
FichaEspacioNombres=128
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
Tamano=20
ColorFondo=Blanco





[RepParam.ListaEnCaptura]
(Inicio)=RepParam.InfoEjercicioD
RepParam.InfoEjercicioD=RepParam.InfoEjercicioA
RepParam.InfoEjercicioA=RepParam.InfoPeriodoA
RepParam.InfoPeriodoA=RepParam.InfoConMovs
RepParam.InfoConMovs=RepParam.InfoDesglosar
RepParam.InfoDesglosar=RepParam.InfoContResAnual
RepParam.InfoContResAnual=RepParam.InfoContMoneda
RepParam.InfoContMoneda=RepParam.InfoCentroCostos
RepParam.InfoCentroCostos=RepParam.InfoCentroCostos2
RepParam.InfoCentroCostos2=RepParam.InfoCentroCostos3
RepParam.InfoCentroCostos3=RepParam.InfoProyecto
RepParam.InfoProyecto=RepParam.InfoUEN
RepParam.InfoUEN=RepParam.InfoSucursal
RepParam.InfoSucursal=RepParam.InfoAgrupadoCC
RepParam.InfoAgrupadoCC=RepParam.InfoGrupoLista
RepParam.InfoGrupoLista=RepParam.InfoTituloContResAnual
RepParam.InfoTituloContResAnual=(Fin)











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
