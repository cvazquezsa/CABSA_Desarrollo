
[Forma]
Clave=POSLCobro
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Datos de Cobro
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Campos
CarpetaPrincipal=Campos
PosicionInicialAlturaCliente=273
PosicionInicialAncho=501
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=432
PosicionInicialArriba=229
ListaAcciones=Aceptar
[Campos]
Estilo=Hoja
Clave=Campos
Filtros=S
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSLCobro
Fuente={Tahoma, 8, Negro, []}
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
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática

FiltroGeneral=POSLCobro.ID = <T>{Info.IDTexto}<T>
[Campos.POSLCobro.FormaPago]
Carpeta=Campos
Clave=POSLCobro.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Campos.POSLCobro.Importe]
Carpeta=Campos
Clave=POSLCobro.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Campos.POSLCobro.Referencia]
Carpeta=Campos
Clave=POSLCobro.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Campos.Columnas]
FormaPago=171
Importe=114
Referencia=177



[Campos.ListaEnCaptura]
(Inicio)=POSLCobro.FormaPago
POSLCobro.FormaPago=POSLCobro.Importe
POSLCobro.Importe=POSLCobro.Referencia
POSLCobro.Referencia=(Fin)

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
