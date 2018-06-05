
[Forma]
Clave=SustentoComprobanteD
Icono=0
Modulos=(Todos)
Nombre=Histórico y Programación de Sustentos de Comprobantes

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Nombre)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=483
PosicionInicialArriba=235
PosicionInicialAlturaCliente=403
PosicionInicialAncho=474
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SustentoComprobanteD
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
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
ListaEnCaptura=(Lista)





PestanaOtroNombre=S
PestanaNombre=Sustento Comprobante
FiltroGeneral=SustentoComprobanteD.SustentoComprobante=<T>{Info.Nombre}<T>
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
FechaD=94
FechaA=94
Porcentaje=64
Concepto=190
Referencia=157

Tasa=52

CodigoFiscal=160


VigenciaD=94
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S



ActivoCondicion=No SustentoComprobanteD:SustentoComprobanteD.TieneMovimientos


[Lista.SustentoComprobanteD.Concepto]
Carpeta=Lista
Clave=SustentoComprobanteD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.SustentoComprobanteD.Referencia]
Carpeta=Lista
Clave=SustentoComprobanteD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.SustentoComprobanteD.VigenciaD]
Carpeta=Lista
Clave=SustentoComprobanteD.VigenciaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[Lista.ListaEnCaptura]
(Inicio)=SustentoComprobanteD.Concepto
SustentoComprobanteD.Concepto=SustentoComprobanteD.Referencia
SustentoComprobanteD.Referencia=SustentoComprobanteD.VigenciaD
SustentoComprobanteD.VigenciaD=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Eliminar
Eliminar=(Fin)
