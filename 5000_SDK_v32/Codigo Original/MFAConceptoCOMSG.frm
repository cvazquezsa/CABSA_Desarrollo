[Forma]
Clave=MFAConceptoCOMSG
Nombre=<T>Conceptos - Compras (Gastos Diversos)<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=265
PosicionInicialArriba=68
PosicionInicialAltura=400
PosicionInicialAncho=835
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=553
PosicionColumna1=43
MovModulo=GAS

PosicionCol1=637
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.Descripcion, <T>Gastos<T>)
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAConceptoCOMSG
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MFAConceptoCOMSG.Concepto
FiltroPredefinido=S
FiltroAncho=40
FiltroTipo=Múltiple (por Grupos)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
CarpetaVisible=S
OtroOrden=S
ListaOrden=MFAConceptoCOMSG.Orden<TAB>(Acendente)
PermiteLocalizar=S
HojaMantenerSeleccion=S
FiltroGrupo1=MFAConceptoCOMSG.Clase
FiltroValida1=MFAConceptoCOMSG.Clase
FiltroGrupo2=MFAConceptoCOMSG.SubClase
FiltroValida2=MFAConceptoCOMSG.SubClase
FiltroTodo=S
FiltroNull=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=40
BusquedaEnLinea=S
PestanaOtroNombre=S
PestanaNombre=Lista


[Lista.Columnas]
Concepto=400
Bloqueo=90
Orden=36
EsDeducible=51
ConSueldo=88
Cuenta=102
Impuestos=35
Retencion=86
Retencion2=86
Clase=88
SubClase=79
ValidarPresupuesto=75
Tipo=47
Actividad=71
PorcentajeDeducible=64
CentroCostos=127
Descripcion=235
CentroCostos2=127
CentroCostos3=127

0=64
1=-2
Modulo=38
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=MFAConceptoCOMSG
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
PestanaOtroNombre=S
PestanaNombre=Detalle








Pestana=S
[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S



[CentrosCostos.Concepto.ContUso]
Carpeta=CentrosCostos
Clave=Concepto.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CentrosCostos.Concepto.ContUso2]
Carpeta=CentrosCostos
Clave=Concepto.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CentrosCostos.Concepto.ContUso3]
Carpeta=CentrosCostos
Clave=Concepto.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro




[CentrosCostos.Concepto.ObjetoGasto]
Carpeta=CentrosCostos
Clave=Concepto.ObjetoGasto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CentrosCostos.CPObjetoGasto.Nombre]
Carpeta=CentrosCostos
Clave=CPObjetoGasto.Nombre
Editar=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro








[CentrosCostos.Concepto.Concepto]
Carpeta=CentrosCostos
Clave=Concepto.Concepto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70
ColorFondo=Plata
ColorFuente=Negro

Efectos=[Negritas]






[CentrosCostos.Concepto.ObjetoGastoRef]
Carpeta=CentrosCostos
Clave=Concepto.ObjetoGastoRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CentrosCostos.CPObjetoGastoRef.Nombre]
Carpeta=CentrosCostos
Clave=CPObjetoGastoRef.Nombre
Editar=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro







[CentrosCostos.Concepto.ClavePresupuestalImpuesto1]
Carpeta=CentrosCostos
Clave=Concepto.ClavePresupuestalImpuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CentrosCostos.ClavePresupuestal.Nombre]
Carpeta=CentrosCostos
Clave=ClavePresupuestal.Nombre
Editar=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro





[CentrosCostos.ListaEnCaptura]
(Inicio)=Concepto.Concepto
Concepto.Concepto=Concepto.ContUso
Concepto.ContUso=Concepto.ContUso2
Concepto.ContUso2=Concepto.ContUso3
Concepto.ContUso3=Concepto.ObjetoGasto
Concepto.ObjetoGasto=CPObjetoGasto.Nombre
CPObjetoGasto.Nombre=Concepto.ObjetoGastoRef
Concepto.ObjetoGastoRef=CPObjetoGastoRef.Nombre
CPObjetoGastoRef.Nombre=Concepto.ClavePresupuestalImpuesto1
Concepto.ClavePresupuestalImpuesto1=ClavePresupuestal.Nombre
ClavePresupuestal.Nombre=(Fin)














[Fiscal.Concepto.Concepto]
Carpeta=Fiscal
Clave=Concepto.Concepto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata

[Fiscal.Concepto.PorcentajeDeducible]
Carpeta=Fiscal
Clave=Concepto.PorcentajeDeducible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Fiscal.Concepto.LimiteDeducible]
Carpeta=Fiscal
Clave=Concepto.LimiteDeducible
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Fiscal.Concepto.EstimuloFiscal]
Carpeta=Fiscal
Clave=Concepto.EstimuloFiscal
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Fiscal.Concepto.TipoImpuesto1]
Carpeta=Fiscal
Clave=Concepto.TipoImpuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Fiscal.Concepto.TipoImpuesto2]
Carpeta=Fiscal
Clave=Concepto.TipoImpuesto2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Fiscal.Concepto.TipoImpuesto3]
Carpeta=Fiscal
Clave=Concepto.TipoImpuesto3
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Fiscal.Concepto.TipoRetencion1]
Carpeta=Fiscal
Clave=Concepto.TipoRetencion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco

[Fiscal.Concepto.TipoRetencion2]
Carpeta=Fiscal
Clave=Concepto.TipoRetencion2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Fiscal.Concepto.TipoRetencion3]
Carpeta=Fiscal
Clave=Concepto.TipoRetencion3
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco








[Fiscal.Concepto.Impuestos]
Carpeta=Fiscal
Clave=Concepto.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Fiscal.Concepto.Impuesto1Excento]
Carpeta=Fiscal
Clave=Concepto.Impuesto1Excento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Fiscal.Concepto.Retencion]
Carpeta=Fiscal
Clave=Concepto.Retencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Fiscal.Concepto.Retencion2]
Carpeta=Fiscal
Clave=Concepto.Retencion2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Fiscal.Concepto.Retencion3]
Carpeta=Fiscal
Clave=Concepto.Retencion3
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Fiscal.Concepto.TipoImpuesto4]
Carpeta=Fiscal
Clave=Concepto.TipoImpuesto4
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco















[Fiscal.TasaImpuesto1]
Carpeta=Fiscal
Clave=TasaImpuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=$00C8D0D4

[Fiscal.TasaImpuesto2]
Carpeta=Fiscal
Clave=TasaImpuesto2
Editar=S
LineaNueva=N
3D=S
Tamano=23
ColorFondo=$00C8D0D4

ValidaNombre=S
[Fiscal.TasaImpuesto3]
Carpeta=Fiscal
Clave=TasaImpuesto3
Editar=S
LineaNueva=N
3D=S
Tamano=23
ColorFondo=$00C8D0D4

ValidaNombre=S
[Fiscal.TasaImpuesto4]
Carpeta=Fiscal
Clave=TasaImpuesto4
Editar=S
LineaNueva=N
3D=S
Tamano=23
ColorFondo=$00C8D0D4

ValidaNombre=S
[Fiscal.TasaRetencion1]
Carpeta=Fiscal
Clave=TasaRetencion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=$00C8D0D4

[Fiscal.TasaRetencion2]
Carpeta=Fiscal
Clave=TasaRetencion2
Editar=S
LineaNueva=N
3D=S
Tamano=23
ColorFondo=$00C8D0D4

ValidaNombre=S
[Fiscal.TasaRetencion3]
Carpeta=Fiscal
Clave=TasaRetencion3
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=$00C8D0D4






[Fiscal.ListaEnCaptura]
(Inicio)=Concepto.Concepto
Concepto.Concepto=Concepto.PorcentajeDeducible
Concepto.PorcentajeDeducible=Concepto.LimiteDeducible
Concepto.LimiteDeducible=Concepto.EstimuloFiscal
Concepto.EstimuloFiscal=Concepto.Impuestos
Concepto.Impuestos=Concepto.Impuesto1Excento
Concepto.Impuesto1Excento=Concepto.Retencion
Concepto.Retencion=Concepto.Retencion2
Concepto.Retencion2=Concepto.Retencion3
Concepto.Retencion3=Concepto.TipoImpuesto1
Concepto.TipoImpuesto1=Concepto.TipoImpuesto2
Concepto.TipoImpuesto2=Concepto.TipoImpuesto3
Concepto.TipoImpuesto3=Concepto.TipoImpuesto4
Concepto.TipoImpuesto4=TasaImpuesto1
TasaImpuesto1=TasaImpuesto2
TasaImpuesto2=TasaImpuesto3
TasaImpuesto3=TasaImpuesto4
TasaImpuesto4=Concepto.TipoRetencion1
Concepto.TipoRetencion1=Concepto.TipoRetencion2
Concepto.TipoRetencion2=Concepto.TipoRetencion3
Concepto.TipoRetencion3=Concepto.TipoImpuesto5
Concepto.TipoImpuesto5=TasaRetencion1
TasaRetencion1=TasaRetencion2
TasaRetencion2=TasaRetencion3
TasaRetencion3=(Fin)

[Fiscal.Concepto.TipoImpuesto5]
Carpeta=Fiscal
Clave=Concepto.TipoImpuesto5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco








[Cfg.MFAConceptoGASCfg.EsImportacion]
Carpeta=Cfg
Clave=MFAConceptoGASCfg.EsImportacion
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco



Tamano=15












[Cfg.LlaveLocal]
(Inicio)=MFAConceptoGASCfg.Concepto
MFAConceptoGASCfg.Concepto=MFAConceptoGASCfg.Modulo
MFAConceptoGASCfg.Modulo=(Fin)

[Cfg.LlaveMaestra]
(Inicio)=Concepto.Concepto
Concepto.Concepto=Concepto.Modulo
Concepto.Modulo=(Fin)











[Detalle.MFAConceptoCOMSG.EsImportacion]
Carpeta=Detalle
Clave=MFAConceptoCOMSG.EsImportacion
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco



Tamano=20
[Lista.MFAConceptoCOMSG.Concepto]
Carpeta=Lista
Clave=MFAConceptoCOMSG.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
























[Detalle.MFAConceptoCOMSG.EsIVAImportacion]
Carpeta=Detalle
Clave=MFAConceptoCOMSG.EsIVAImportacion
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=20


[Detalle.ListaEnCaptura]
(Inicio)=MFAConceptoCOMSG.EsImportacion
MFAConceptoCOMSG.EsImportacion=MFAConceptoCOMSG.EsIVAImportacion
MFAConceptoCOMSG.EsIVAImportacion=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Navegador
Navegador=(Fin)
