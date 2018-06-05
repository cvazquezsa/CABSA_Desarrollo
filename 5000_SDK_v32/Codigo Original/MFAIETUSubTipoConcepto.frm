
[Forma]
Clave=MFAIETUSubTipoConcepto
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Conceptos - Sub Tipos de IETU
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
PosicionInicialIzquierda=432
PosicionInicialArriba=140
PosicionInicialAlturaCliente=409
PosicionInicialAncho=501
ListaCarpetas=MFAIETUSubTipoConcepto
CarpetaPrincipal=MFAIETUSubTipoConcepto
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[MFAIETUSubTipoConcepto]
Estilo=Hoja
Clave=MFAIETUSubTipoConcepto
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAIETUSubTipoConcepto
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

OtroOrden=S
ValidarCampos=S
ListaCamposAValidar=MFAConcepto.concepto_descripcion
ListaOrden=(Lista)
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
[MFAIETUSubTipoConcepto.MFAIETUSubTipoConcepto.Concepto]
Carpeta=MFAIETUSubTipoConcepto
Clave=MFAIETUSubTipoConcepto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[MFAIETUSubTipoConcepto.MFAIETUSubTipoConcepto.TipoAplicacion]
Carpeta=MFAIETUSubTipoConcepto
Clave=MFAIETUSubTipoConcepto.TipoAplicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[MFAIETUSubTipoConcepto.MFAIETUSubTipoConcepto.SubTipo]
Carpeta=MFAIETUSubTipoConcepto
Clave=MFAIETUSubTipoConcepto.SubTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MFAIETUSubTipoConcepto.Columnas]
Concepto=157
TipoAplicacion=167
SubTipo=86





[Datos.Columnas]
SubTipo=78
Descripcion=426

[MFAIETUSubTipoConcepto.ListaEnCaptura]
(Inicio)=MFAIETUSubTipoConcepto.Concepto
MFAIETUSubTipoConcepto.Concepto=MFAIETUSubTipoConcepto.TipoAplicacion
MFAIETUSubTipoConcepto.TipoAplicacion=MFAIETUSubTipoConcepto.SubTipo
MFAIETUSubTipoConcepto.SubTipo=(Fin)

[MFAIETUSubTipoConcepto.ListaOrden]
(Inicio)=MFAIETUSubTipoConcepto.Concepto	(Acendente)
MFAIETUSubTipoConcepto.Concepto	(Acendente)=MFAIETUSubTipoConcepto.TipoAplicacion	(Acendente)
MFAIETUSubTipoConcepto.TipoAplicacion	(Acendente)=(Fin)
