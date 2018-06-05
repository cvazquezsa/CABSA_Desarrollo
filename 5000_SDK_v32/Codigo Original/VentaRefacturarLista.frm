[Forma]
Clave=VentaRefacturarLista
Icono=0
CarpetaPrincipal=VentaRefacturar
Modulos=(Todos)
Nombre=Lista Notas Refacturar

ListaCarpetas=VentaRefacturar
PosicionInicialAlturaCliente=690
PosicionInicialAncho=878
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialIzquierda=1801
PosicionInicialArriba=148




[TipoImpuesto1.Columnas]
0=-2
1=88
2=277
3=-2



[TipoImpuesto1.ListaEnCaptura]
(Inicio)=TipoImpuesto1.TipoImpuesto
TipoImpuesto1.TipoImpuesto=TipoImpuesto.Concepto
TipoImpuesto.Concepto=TipoImpuesto.Tasa
TipoImpuesto.Tasa=(Fin)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

Antes=S
Multiple=S
ListaAccionesMultiples=(Lista)
AntesExpresiones=Asigna(Info.MovID,VentaRefacturar:VentaRefacturar.MovID)
[VentaRefacturar]
Estilo=Iconos
Clave=VentaRefacturar
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaRefacturar
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=Alm
FiltroAplicaEn1=VentaRefacturar.Almacen
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroUsuarios=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSucursales=S
FiltroFechasCampo=VentaRefacturar.FechaEmision
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S

FiltroUsuarioDefault=(Usuario)
FiltroFechasDefault=Hoy
BusquedaRapida=S
BusquedaEnLinea=S
PestanaOtroNombre=S
PestanaNombre=Notas
IconosSeleccionMultiple=S
MenuLocal=S
IconosNombre=VentaRefacturar:VentaRefacturar.Mov
ListaAcciones=(Lista)
[VentaRefacturar.VentaRefacturar.MovID]
Carpeta=VentaRefacturar
Clave=VentaRefacturar.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[VentaRefacturar.VentaRefacturar.Importe]
Carpeta=VentaRefacturar
Clave=VentaRefacturar.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[VentaRefacturar.VentaRefacturar.Impuestos]
Carpeta=VentaRefacturar
Clave=VentaRefacturar.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[VentaRefacturar.Columnas]
0=-2
1=59
2=176
3=77



4=95

[VentaRefacturar.VentaRefacturar.Nombre]
Carpeta=VentaRefacturar
Clave=VentaRefacturar.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco










[Acciones.Seleccionar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=RegistrarSeleccionID(<T>VentaRefacturar<T> )<BR>EjecutarSQL(<T>spPOSInsertarVentaRefacturarTemp :nEstacion<T>,EstacionTrabajo)<BR> Forma.ActualizarForma(<T>VentaRefacturarTemp<T>)
[Acciones.Seleccionar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S




[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[VentaRefacturar.ListaEnCaptura]
(Inicio)=VentaRefacturar.MovID
VentaRefacturar.MovID=VentaRefacturar.Nombre
VentaRefacturar.Nombre=VentaRefacturar.Importe
VentaRefacturar.Importe=VentaRefacturar.Impuestos
VentaRefacturar.Impuestos=(Fin)

[VentaRefacturar.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=(Fin)

[Acciones.Seleccionar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)
