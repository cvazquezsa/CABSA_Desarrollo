[Forma]
Clave=ConciliacionDLista
Icono=6
Modulos=(Todos)
Nombre=Detalle sin Conciliar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialAlturaCliente=482
PosicionInicialAncho=912
PosicionInicialIzquierda=500
PosicionInicialArriba=342
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ConciliacionD
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Fecha<T>
ElementosPorPagina=200
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
IconosNombre=FechaEnTexto(ConciliacionD:ConciliacionD.Fecha, <T>dd/mmm/aaaa<T>)
FiltroGeneral=ConciliacionD.ID={Info.ID} AND NULLIF(ConciliacionD.Manual, 0) IS NULL AND NULLIF(ConciliacionD.Auxiliar, 0) IS NULL

[Lista.ConciliacionD.Concepto]
Carpeta=Lista
Clave=ConciliacionD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConciliacionD.Referencia]
Carpeta=Lista
Clave=ConciliacionD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConciliacionD.Cargo]
Carpeta=Lista
Clave=ConciliacionD.Cargo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConciliacionD.Abono]
Carpeta=Lista
Clave=ConciliacionD.Abono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConciliacionD.Observaciones]
Carpeta=Lista
Clave=ConciliacionD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.Columnas]
0=85
1=173

[Lista.ListaEnCaptura]
(Inicio)=ConciliacionD.Concepto
ConciliacionD.Concepto=ConciliacionD.Referencia
ConciliacionD.Referencia=ConciliacionD.Cargo
ConciliacionD.Cargo=ConciliacionD.Abono
ConciliacionD.Abono=ConciliacionD.Observaciones
ConciliacionD.Observaciones=(Fin)
