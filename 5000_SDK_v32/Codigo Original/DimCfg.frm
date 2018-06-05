
[Forma]
Clave=DimCfg
Icono=0
CarpetaPrincipal=Lista
BarraHerramientas=S
Modulos=(Todos)
MovModulo=NOM
Nombre=DIM (Información Anual de Sueldos y Salarios)
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal

ListaCarpetas=(Lista)
PosicionInicialIzquierda=278
PosicionInicialArriba=132
PosicionInicialAlturaCliente=577
PosicionInicialAncho=717
PosicionCol1=603
PosicionSec1=395
ListaAcciones=(Lista)
ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spInsertarDIM<T>)<BR>EjecutarSQL(<T>EXEC spFiltroDim :nEstacion,:tEmpresa<T>, EstacionTrabajo,Empresa )
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
ValidarCampos=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DimCfg
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaIndicador=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaConfirmarEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ListaCamposAValidar=DimCfg.Descripcion
ListaOrden=DimCfg.Columna<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

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
BusquedaAncho=20
BusquedaEnLinea=S
BusquedaRespetarFiltros=S
FiltroGeneral={<T>DimCfg.Columna not in (Select Clave from listast where Estacion=<T>& Comillas(EstacionTrabajo) &<T>) and DimCfg.Empresa=<T>& Comillas(Empresa) &<T>}
[Lista.DimCfg.Columna]
Carpeta=Lista
Clave=DimCfg.Columna
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.DimCfg.Titulo]
Carpeta=Lista
Clave=DimCfg.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=90
ColorFondo=Blanco

[Lista.DimCfg.Tipo]
Carpeta=Lista
Clave=DimCfg.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.DimCfg.Campo]
Carpeta=Lista
Clave=DimCfg.Campo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
Columna=86
Titulo=116
Tipo=85
Campo=267

NominaConcepto=304
Concepto=304

Obligatorio=64
[Obligatorio.DimCfg.Obligatorio]
Carpeta=Obligatorio
Clave=DimCfg.Obligatorio
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco




[Detalle]
Estilo=Hoja
Clave=Detalle
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=DimCfgD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=DimCfg
LlaveLocal=DimCfgD.ID
LlaveMaestra=DimCfg.ID
HojaTitulos=S
HojaIndicador=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ControlRenglon=S
CampoRenglon=DimCfgD.Renglon

CondicionVisible=(DimCfg:DimCfg.Tipo = <T>Suma Concepto<T>) o (DimCfg:DimCfg.Columna = 9) o (DimCfg:DimCfg.Columna = 32)
[Detalle.DimCfgD.NominaConcepto]
Carpeta=Detalle
Clave=DimCfgD.NominaConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.DimCfgD.Concepto]
Carpeta=Detalle
Clave=DimCfgD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco




[Detalle.Columnas]
NominaConcepto=304
Concepto=380


Mov=124
MovConcepto=304
Cantidad=64
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S




[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S





Expresion=Si<BR>  Forma(<T>EspecificarEjercicio<T>)<BR>Entonces<BR>  ReportePantalla(<T>RepDimGrid<T>)<BR>Fin
[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreEnBoton=S
NombreDesplegar=&Actualizar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
AntesExpresiones=GuardarCambios<BR>EjecutarSQL(<T>EXEC SpFiltroDim :nEstacion,:tempresa<T>, EstacionTrabajo, Empresa )
Visible=S
















































[Lista.DimCfg.Obligatorio]
Carpeta=Lista
Clave=DimCfg.Obligatorio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco











































[Lista.ListaEnCaptura]
(Inicio)=DimCfg.Columna
DimCfg.Columna=DimCfg.Titulo
DimCfg.Titulo=DimCfg.Tipo
DimCfg.Tipo=DimCfg.Campo
DimCfg.Campo=DimCfg.Obligatorio
DimCfg.Obligatorio=(Fin)










[Detalle.DimCfgD.Mov]
Carpeta=Detalle
Clave=DimCfgD.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.DimCfgD.MovConcepto]
Carpeta=Detalle
Clave=DimCfgD.MovConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.DimCfgD.Cantidad]
Carpeta=Detalle
Clave=DimCfgD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco









[Detalle.ListaEnCaptura]
(Inicio)=DimCfgD.Mov
DimCfgD.Mov=DimCfgD.MovConcepto
DimCfgD.MovConcepto=DimCfgD.NominaConcepto
DimCfgD.NominaConcepto=DimCfgD.Cantidad
DimCfgD.Cantidad=DimCfgD.Concepto
DimCfgD.Concepto=(Fin)











[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S







[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Preliminar
Preliminar=Actualizar
Actualizar=Cancelar
Cancelar=(Fin)
