[Forma]
Clave=ConceptoGASLista
Nombre=<T>Conceptos - Gastos<T>
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=321
PosicionInicialArriba=225
PosicionInicialAltura=400
PosicionInicialAncho=638
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=547
PosicionColumna1=43
MovModulo=GAS
ListaAcciones=(Lista)

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Concepto
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroAncho=30
FiltroTipo=Múltiple (por Grupos)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
CarpetaVisible=S
OtroOrden=S
ListaOrden=Concepto.Orden<TAB>(Acendente)
PermiteLocalizar=S
FiltroGrupo1=Concepto.Clase
FiltroValida1=Concepto.Clase
FiltroGrupo2=Concepto.SubClase
FiltroValida2=Concepto.SubClase
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
BusquedaAncho=30
BusquedaEnLinea=S
PestanaOtroNombre=S
PestanaNombre=Conceptos
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Concepto<T>
ElementosPorPagina=200
IconosNombre=Concepto:Concepto.Concepto
FiltroGeneral=Concepto.Modulo=<T>GAS<T>

[Lista.Columnas]
Concepto=386
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
0=277

[Detalle.Concepto.Concepto]
Carpeta=Detalle
Clave=Concepto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.Concepto.Cuenta]
Carpeta=Detalle
Clave=Concepto.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Concepto.Impuestos]
Carpeta=Detalle
Clave=Concepto.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Detalle.Concepto.Retencion]
Carpeta=Detalle
Clave=Concepto.Retencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Detalle.Concepto.Retencion2]
Carpeta=Detalle
Clave=Concepto.Retencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Detalle.Concepto.Clase]
Carpeta=Detalle
Clave=Concepto.Clase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Detalle.Concepto.SubClase]
Carpeta=Detalle
Clave=Concepto.SubClase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Concepto.ValidarPresupuesto]
Carpeta=Detalle
Clave=Concepto.ValidarPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Concepto.Tipo]
Carpeta=Detalle
Clave=Concepto.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Concepto.Actividad]
Carpeta=Detalle
Clave=Concepto.Actividad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Detalle.Concepto.PorcentajeDeducible]
Carpeta=Detalle
Clave=Concepto.PorcentajeDeducible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20
EspacioPrevio=S

[Detalle.Cta.Descripcion]
Carpeta=Detalle
Clave=Cta.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Concepto.Indirecto]
Carpeta=Detalle
Clave=Concepto.Indirecto
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Concepto.NivelAcceso]
Carpeta=Detalle
Clave=Concepto.NivelAcceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Concepto.EstimuloFiscal]
Carpeta=Detalle
Clave=Concepto.EstimuloFiscal
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Detalle.Concepto.CR]
Carpeta=Detalle
Clave=Concepto.CR
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Concepto.UEN]
Carpeta=Detalle
Clave=Concepto.UEN
Editar=S
ValidaNombre=S
3D=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Detalle.Concepto.Retencion3]
Carpeta=Detalle
Clave=Concepto.Retencion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Concepto.LimiteDeducible]
Carpeta=Detalle
Clave=Concepto.LimiteDeducible
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Concepto.ConceptoCxp]
Carpeta=Detalle
Clave=Concepto.ConceptoCxp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Concepto.Provisionable]
Carpeta=Detalle
Clave=Concepto.Provisionable
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=12

[Detalle.Concepto.ProvisionImporte]
Carpeta=Detalle
Clave=Concepto.ProvisionImporte
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=N

[Detalle.Concepto.CuentaPresupuesto]
Carpeta=Detalle
Clave=Concepto.CuentaPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CtaPresupuesto.Descripcion]
Carpeta=Detalle
Clave=CtaPresupuesto.Descripcion
Editar=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Concepto.CalcularPresupuesto]
Carpeta=Detalle
Clave=Concepto.CalcularPresupuesto
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Detalle.Concepto.InflacionPresupuesto]
Carpeta=Detalle
Clave=Concepto.InflacionPresupuesto
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S
Tamano=9

[Detalle.Concepto.DepartamentoDetallista]
Carpeta=Detalle
Clave=Concepto.DepartamentoDetallista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.DepartamentoDetallista.Nombre]
Carpeta=Detalle
Clave=DepartamentoDetallista.Nombre
Editar=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Detalle.DepartamentoDetallista.Merma]
Carpeta=Detalle
Clave=DepartamentoDetallista.Merma
Editar=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Pegado=S
ValidaNombre=S

[Detalle.Concepto.Impuesto1Excento]
Carpeta=Detalle
Clave=Concepto.Impuesto1Excento
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Concepto.Proyecto]
Carpeta=Detalle
Clave=Concepto.Proyecto
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)
