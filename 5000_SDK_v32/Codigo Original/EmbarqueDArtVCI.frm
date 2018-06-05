
[Forma]
Clave=EmbarqueDArtVCI
Icono=0
BarraHerramientas=S
Modulos=(Todos)
MovModulo=EmbarqueDArtVCI
Nombre=Info.Mov & <T> <T> & Info.MovID & <T> - Detalle por artículo<T>
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Lista
CarpetaPrincipal=Lista
Comentarios=Lista(Info.Mov,Info.MovID)
ListaAcciones=(Lista)
PosicionInicialIzquierda=245
PosicionInicialArriba=151
PosicionInicialAlturaCliente=406
PosicionInicialAncho=790
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmbarqueDArtVCI
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Artículo<T>
ElementosPorPaginaEsp=200
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
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S

BusquedaRapida=S
BusquedaEnLinea=S
PestanaOtroNombre=S
PestanaNombre=Registros
IconosNombre=EmbarqueDArtVCI:EmbarqueDArtVCI.Articulo
FiltroGeneral=EmbarqueDArtVCI.ID = {Info.ID}
[Lista.EmbarqueDArtVCI.SubCuenta]
Carpeta=Lista
Clave=EmbarqueDArtVCI.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.EmbarqueDArtVCI.Descripcion]
Carpeta=Lista
Clave=EmbarqueDArtVCI.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.EmbarqueDArtVCI.Cantidad]
Carpeta=Lista
Clave=EmbarqueDArtVCI.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.EmbarqueDArtVCI.CantidadTotal]
Carpeta=Lista
Clave=EmbarqueDArtVCI.CantidadTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.EmbarqueDArtVCI.ImporteTotal]
Carpeta=Lista
Clave=EmbarqueDArtVCI.ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=115
NombreEnBoton=S
NombreDesplegar=&Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S




[Acciones.VistaPrevia]
Nombre=VistaPrevia
Boton=6
NombreEnBoton=S
NombreDesplegar=&Presentación Preliminar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S


[Acciones.MostrarCampos]
Nombre=MostrarCampos
Boton=45
NombreDesplegar=&Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S




[Lista.Columnas]
0=110
1=95
2=216
3=80
4=105
5=-2






6=-2

[Lista.EmbarqueDArtVCI.Importe]
Carpeta=Lista
Clave=EmbarqueDArtVCI.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco










[Lista.ListaEnCaptura]
(Inicio)=EmbarqueDArtVCI.SubCuenta
EmbarqueDArtVCI.SubCuenta=EmbarqueDArtVCI.Descripcion
EmbarqueDArtVCI.Descripcion=EmbarqueDArtVCI.Cantidad
EmbarqueDArtVCI.Cantidad=EmbarqueDArtVCI.Importe
EmbarqueDArtVCI.Importe=EmbarqueDArtVCI.CantidadTotal
EmbarqueDArtVCI.CantidadTotal=EmbarqueDArtVCI.ImporteTotal
EmbarqueDArtVCI.ImporteTotal=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Excel
Excel=VistaPrevia
VistaPrevia=MostrarCampos
MostrarCampos=(Fin)
