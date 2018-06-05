
[Forma]
Clave=DIOTIVARubroCondicion
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=DPIVA - Condiciones Rubro
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=394
PosicionInicialArriba=162
PosicionInicialAlturaCliente=370
PosicionInicialAncho=578
PosicionSec1=174
Comentarios=Info.Anuncio
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





[Condiciones.Columnas]
Concepto=98
Operador=82
Valor=304

[Condiciones.ListaEnCaptura]
(Inicio)=DIOTIVARubroCondicion.Concepto
DIOTIVARubroCondicion.Concepto=DIOTIVARubroCondicion.Operador
DIOTIVARubroCondicion.Operador=DIOTIVARubroCondicion.Valor
DIOTIVARubroCondicion.Valor=(Fin)

[Detalle]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Detalle
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=DIOTIVARubroCondicion
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

[Detalle.DIOTIVARubroCondicion.Concepto]
Carpeta=Detalle
Clave=DIOTIVARubroCondicion.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.DIOTIVARubroCondicion.Operador]
Carpeta=Detalle
Clave=DIOTIVARubroCondicion.Operador
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.DIOTIVARubroCondicion.Valor]
Carpeta=Detalle
Clave=DIOTIVARubroCondicion.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=69x7
[Detalle.Columnas]
Concepto=604
Operador=604
Valor=304






[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
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
CarpetaVisible=S

Vista=DIOTIVARubroCondicion
ListaEnCaptura=DIOTIVARubroCondicion.Concepto

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

PestanaOtroNombre=S
PestanaNombre=Lista
PermiteEditar=S
FiltroGeneral=DIOTIVARubroCondicion.Rubro = {Info.ID}
[Lista.DIOTIVARubroCondicion.Concepto]
Carpeta=Lista
Clave=DIOTIVARubroCondicion.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco



[Lista.Columnas]
Concepto=436
Operador=96
Valor=306

[Lista.ListaEnCaptura]
(Inicio)=DIOTIVARubroCondicion.Concepto
DIOTIVARubroCondicion.Concepto=DIOTIVARubroCondicion.Operador
DIOTIVARubroCondicion.Operador=DIOTIVARubroCondicion.Valor
DIOTIVARubroCondicion.Valor=(Fin)
















[Detalle.ListaEnCaptura]
(Inicio)=DIOTIVARubroCondicion.Concepto
DIOTIVARubroCondicion.Concepto=DIOTIVARubroCondicion.Operador
DIOTIVARubroCondicion.Operador=DIOTIVARubroCondicion.Valor
DIOTIVARubroCondicion.Valor=(Fin)





















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)
