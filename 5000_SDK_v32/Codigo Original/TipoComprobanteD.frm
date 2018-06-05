
[Forma]
Clave=TipoComprobanteD
Icono=0
Modulos=(Todos)
Nombre=Histórico y Programación de Tipos de Comprobantes

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=(Lista)
Comentarios=Lista(Info.Nombre)
PosicionInicialIzquierda=363
PosicionInicialArriba=261
PosicionInicialAlturaCliente=350
PosicionInicialAncho=502
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoComprobanteD
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
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

PestanaOtroNombre=S
PestanaNombre=Tipo Comprobante
FiltroGeneral=TipoComprobanteD.TipoComprobante = <T>{Info.Nombre}<T>
[Lista.TipoComprobanteD.Concepto]
Carpeta=Lista
Clave=TipoComprobanteD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.TipoComprobanteD.Referencia]
Carpeta=Lista
Clave=TipoComprobanteD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.TipoComprobanteD.VigenciaD]
Carpeta=Lista
Clave=TipoComprobanteD.VigenciaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

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

ActivoCondicion=No TipoComprobanteD:TipoComprobanteD.TieneMovimientos

[Lista.Columnas]
Concepto=193
Referencia=183
VigenciaD=94
TipoComprobante=124
TieneMovimientos=89













[Lista.ListaEnCaptura]
(Inicio)=TipoComprobanteD.Concepto
TipoComprobanteD.Concepto=TipoComprobanteD.Referencia
TipoComprobanteD.Referencia=TipoComprobanteD.VigenciaD
TipoComprobanteD.VigenciaD=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Eliminar
Eliminar=(Fin)
