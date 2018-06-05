[Forma]
Clave=InformeCxpEstadoCuentaSimple
Nombre=Estado de Cuentas (Simple)
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=RepParam
PosicionInicialIzquierda=633
PosicionInicialArriba=289
PosicionInicialAltura=234
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
PosicionInicialAlturaCliente=253


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


GuardarAntes=S
TipoAccion=Expresion
Expresion=Asigna(RepParamInformes:RepParam.InfoModulo, <T>CXP<T>)<BR>GuardarCambios<BR>Informe( <T>InformeCxpEstadoCuentaSimple<T>, RepParamInformes:RepParam.InfoTituloCXPEC)
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
ClaveAccion=CxpEstadoCuenta
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

[(Variables).Info.Proveedor]
Carpeta=(Variables)
Clave=Info.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[RepParam]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Filtros
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
CarpetaVisible=S
ListaEnCaptura=(Lista)


Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=RepParam.Estacion = {EstacionTrabajo}
[RepParam.RepParam.InfoFechaD]
Carpeta=RepParam
Clave=RepParam.InfoFechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
EspacioPrevio=S
[RepParam.RepParam.InfoEstatusEspecifico]
Carpeta=RepParam
Clave=RepParam.InfoEstatusEspecifico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[RepParam.RepParam.InfoMoneda]
Carpeta=RepParam
Clave=RepParam.InfoMoneda
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoTituloCXPEC]
Carpeta=RepParam
Clave=RepParam.InfoTituloCXPEC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

EspacioPrevio=S






[(Variables).ListaEnCaptura]
(Inicio)=Info.Proveedor
Info.Proveedor=Info.FechaD
Info.FechaD=Rep.EdoCtaEstatus
Rep.EdoCtaEstatus=Info.Moneda
Info.Moneda=Rep.Titulo
Rep.Titulo=(Fin)








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


FiltroGeneral=RepParam.Estacion = { EstacionTrabajo }
[Grafica.RepParam.InfoEtiqueta]
Carpeta=Grafica
Clave=RepParam.InfoEtiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






































[Lista.Columnas]
0=116
1=266








[RepParam.RepParam.InfoProveedorD]
Carpeta=RepParam
Clave=RepParam.InfoProveedorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoProveedorA]
Carpeta=RepParam
Clave=RepParam.InfoProveedorA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[RepParam.ListaEnCaptura]
(Inicio)=RepParam.InfoProveedorD
RepParam.InfoProveedorD=RepParam.InfoProveedorA
RepParam.InfoProveedorA=RepParam.InfoFechaD
RepParam.InfoFechaD=RepParam.InfoEstatusEspecifico
RepParam.InfoEstatusEspecifico=RepParam.InfoMoneda
RepParam.InfoMoneda=RepParam.InfoTituloCXPEC
RepParam.InfoTituloCXPEC=(Fin)







































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
