
[Forma]
Clave=CFDINominaConceptoLista
Icono=0
CarpetaPrincipal=Lista
BarraHerramientas=S
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Nómina - Lista Conceptos
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal

ListaCarpetas=Lista
PosicionInicialIzquierda=365
PosicionInicialArriba=109
PosicionInicialAlturaCliente=449
PosicionInicialAncho=492
ListaAcciones=Seleccionar
ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spCFDINominaConceptoLista :tEmpresa<T>, Empresa)
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDINominaConceptoLista
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco

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

MenuLocal=S
ListaAcciones=(Lista)

PestanaOtroNombre=S
PestanaNombre=Lista
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
ListaEnCaptura=CFDINominaConceptoLista.Concepto
FiltroGeneral=CFDINominaConceptoLista.Empresa=<T>{Empresa}<T>
[Lista.Columnas]
NominaConcepto=203
Concepto=195


0=300
1=127
[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S



[Lista.ListaEnCaptura]
(Inicio)=CFDINominaConceptoLista.NominaConcepto
CFDINominaConceptoLista.NominaConcepto=CFDINominaConceptoLista.Concepto
CFDINominaConceptoLista.Concepto=(Fin)

[Acciones.Todo]
Nombre=Todo
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Nada]
Nombre=Nada
Boton=0
NombreDesplegar=Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S










[Lista.CFDINominaConceptoLista.Concepto]
Carpeta=Lista
Clave=CFDINominaConceptoLista.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ListaAcciones]
(Inicio)=Todo
Todo=Nada
Nada=(Fin)
