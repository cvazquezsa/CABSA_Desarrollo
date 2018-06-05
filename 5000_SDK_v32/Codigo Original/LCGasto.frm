[Forma]
Clave=LCGasto
Nombre=Gastos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.LineaCredito
ListaAcciones=Aceptar
PosicionInicialIzquierda=699
PosicionInicialArriba=321
PosicionInicialAlturaCliente=521
PosicionInicialAncho=521
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=LCGasto
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=LCGasto.LineaCredito=<T>{Info.LineaCredito}<T>

[Lista.LCGasto.Concepto]
Carpeta=Lista
Clave=LCGasto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.LCGasto.Importe]
Carpeta=Lista
Clave=LCGasto.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.LCGasto.Porcentaje]
Carpeta=Lista
Clave=LCGasto.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
Concepto=304
Importe=115
Porcentaje=62
Acreedor=98
Nombre=222

[Lista.ListaEnCaptura]
(Inicio)=LCGasto.Concepto
LCGasto.Concepto=LCGasto.Porcentaje
LCGasto.Porcentaje=LCGasto.Importe
LCGasto.Importe=(Fin)
