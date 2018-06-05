
[Forma]
Clave=CFDINominaConceptoDiasPaga
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Nómina - Conceptos Dias Pagados
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=389
PosicionInicialArriba=127
PosicionInicialAlturaCliente=349
PosicionInicialAncho=383
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

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDINominaConceptoDiasPaga
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
ListaEnCaptura=CFDINominaConceptoDiasPaga.Concepto

ListaOrden=CFDINominaConceptoDiasPaga.Concepto<TAB>(Acendente)
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
[Lista.CFDINominaConceptoDiasPaga.Concepto]
Carpeta=Lista
Clave=CFDINominaConceptoDiasPaga.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[Lista.Columnas]
Concepto=328
ClaveSAT=82
ConceptoSAT=249

NominaConcepto=203
0=300
1=-2
[Lista.ListaEnCaptura]
(Inicio)=CFDINominaConceptoDiasPaga.Concepto
CFDINominaConceptoDiasPaga.Concepto=CFDINominaConceptoDiasPaga.ClaveSAT
CFDINominaConceptoDiasPaga.ClaveSAT=CFDINominaConceptoDiasPaga.ConceptoSAT
CFDINominaConceptoDiasPaga.ConceptoSAT=(Fin)
