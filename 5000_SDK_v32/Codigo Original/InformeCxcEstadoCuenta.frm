[Forma]
Clave=InformeCxcEstadoCuenta
Nombre=Estado de Cuentas
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=RepParam
PosicionInicialIzquierda=633
PosicionInicialArriba=314
PosicionInicialAltura=233
PosicionInicialAncho=334
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
AccionesTamanoBoton=25x5
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
BarraHerramientas=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=204

VentanaEstadoInicial=Normal

VentanaExclusivaOpcion=0
ExpresionesAlMostrar=AUTOEXEC
[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreDesplegar=&Preliminar
EnBarraAcciones=S
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S


TipoAccion=Expresion
GuardarAntes=S
Expresion=Asigna(RepParamInformes:RepParam.InfoModulo, <T>CXC<T>)<BR>GuardarCambios<BR>Informe( <T>InformeCxcEstadoCuenta<T>, RepParamInformes:RepParam.InfoTituloCXCEC)
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


[Acciones.Imprimir.Imprimir]
Nombre=Imprimir
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=CxcEstadoCuenta
Activo=S
Visible=S

[(Variables).Rep.Titulo]
Carpeta=(Variables)
Clave=Rep.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=41
ColorFondo=Blanco

[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Moneda]
Carpeta=(Variables)
Clave=Info.Moneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Rep.EdoCtaEstatus]
Carpeta=(Variables)
Clave=Rep.EdoCtaEstatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Cliente]
Carpeta=(Variables)
Clave=Info.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Sucursal]
Carpeta=(Variables)
Clave=Info.Sucursal
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Lista.Columnas]
Cliente=117
Nombre=293
RFC=107














0=91
1=267
[Acciones.Imprimir.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Imprimir
Imprimir=(Fin)






























[RepParam]
Estilo=Ficha
Clave=RepParam
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParamInformes
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
ListaEnCaptura=(Lista)
CarpetaVisible=S

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
FiltroGeneral=RepParam.Estacion = {EstacionTrabajo}
[RepParam.RepParam.InfoCliente]
Carpeta=RepParam
Clave=RepParam.InfoCliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[RepParam.RepParam.InfoFechaD]
Carpeta=RepParam
Clave=RepParam.InfoFechaD
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=20

[RepParam.RepParam.InfoMoneda]
Carpeta=RepParam
Clave=RepParam.InfoMoneda
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco










[(Variables).ListaEnCaptura]
(Inicio)=Info.Cliente
Info.Cliente=Info.Sucursal
Info.Sucursal=Info.FechaD
Info.FechaD=Rep.EdoCtaEstatus
Rep.EdoCtaEstatus=Info.Moneda
Info.Moneda=Rep.Titulo
Rep.Titulo=(Fin)







[RepParam.RepParam.InfoTituloCXCEC]
Carpeta=RepParam
Clave=RepParam.InfoTituloCXCEC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=41
ColorFondo=Blanco





















[RepParam.RepParam.InfoEstatusEspecifico]
Carpeta=RepParam
Clave=RepParam.InfoEstatusEspecifico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=S




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
Vista=RepParamInformes
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


FiltroGeneral=RepParam.Estacion = {EstacionTrabajo}
[Grafica.RepParam.InfoEtiqueta]
Carpeta=Grafica
Clave=RepParam.InfoEtiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco















[Grafica.RepParam.InformeGraficarTipo]
Carpeta=Grafica
Clave=RepParam.InformeGraficarTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Grafica.RepParam.InformeGraficarFecha]
Carpeta=Grafica
Clave=RepParam.InformeGraficarFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Grafica.RepParam.InformeGraficarCantidad]
Carpeta=Grafica
Clave=RepParam.InformeGraficarCantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20















[RepParam.ListaEnCaptura]
(Inicio)=RepParam.InfoCliente
RepParam.InfoCliente=RepParam.InfoFechaD
RepParam.InfoFechaD=RepParam.InfoEstatusEspecifico
RepParam.InfoEstatusEspecifico=RepParam.InfoMoneda
RepParam.InfoMoneda=RepParam.InfoTituloCXCEC
RepParam.InfoTituloCXCEC=(Fin)









[Grafica.ListaEnCaptura]
(Inicio)=RepParam.InformeGraficarFecha
RepParam.InformeGraficarFecha=RepParam.InformeGraficarTipo
RepParam.InformeGraficarTipo=RepParam.InformeGraficarCantidad
RepParam.InformeGraficarCantidad=RepParam.InfoEtiqueta
RepParam.InfoEtiqueta=RepParam.VerGraficaDetalle
RepParam.VerGraficaDetalle=(Fin)

[Grafica.RepParam.VerGraficaDetalle]
Carpeta=Grafica
Clave=RepParam.VerGraficaDetalle
Editar=S
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
