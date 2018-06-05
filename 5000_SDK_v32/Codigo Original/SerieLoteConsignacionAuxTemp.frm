
[Forma]
Clave=SerieLoteConsignacionAuxTemp
Icono=0
Modulos=(Todos)
MovModulo=SerieLoteConsignacionAuxTemp
Nombre=Series/Lotes Consignación

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=454
PosicionInicialAncho=883
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=1478
PosicionInicialArriba=217
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov,Info.MovID)
Totalizadores=S
PosicionSec1=372
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SerieLoteConsignacionAuxTemp
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>Módulo<T>

ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=SerieLoteConsignacionAuxTemp.Fecha
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
PestanaOtroNombre=S
PestanaNombre=Registros
IconosNombre=SerieLoteConsignacionAuxTemp:SerieLoteConsignacionAuxTemp.ModuloNombre
FiltroGeneral=SerieLoteConsignacionAuxTemp.CorteID = {Info.ID} AND SerieLoteConsignacionAuxTemp.Estacion = @@SPID
[Lista.Columnas]
0=102

1=147
2=86
3=90
4=80
5=79
6=92
7=79
8=-2

9=-2
[Lista.SerieLoteConsignacionAuxTemp.Mov]
Carpeta=Lista
Clave=SerieLoteConsignacionAuxTemp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.SerieLoteConsignacionAuxTemp.MovID]
Carpeta=Lista
Clave=SerieLoteConsignacionAuxTemp.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.SerieLoteConsignacionAuxTemp.Fecha]
Carpeta=Lista
Clave=SerieLoteConsignacionAuxTemp.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.SerieLoteConsignacionAuxTemp.Articulo]
Carpeta=Lista
Clave=SerieLoteConsignacionAuxTemp.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.SerieLoteConsignacionAuxTemp.SubCuenta]
Carpeta=Lista
Clave=SerieLoteConsignacionAuxTemp.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.SerieLoteConsignacionAuxTemp.SerieLote]
Carpeta=Lista
Clave=SerieLoteConsignacionAuxTemp.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.SerieLoteConsignacionAuxTemp.Cargo]
Carpeta=Lista
Clave=SerieLoteConsignacionAuxTemp.Cargo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.SerieLoteConsignacionAuxTemp.Abono]
Carpeta=Lista
Clave=SerieLoteConsignacionAuxTemp.Abono
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
ClaveAccion=Aceptar
Activo=S
Visible=S




[Acciones.Excel]
Nombre=Excel
Boton=67
NombreEnBoton=S
NombreDesplegar=Enviar a &Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S



[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Entradas<BR>Salidas<BR>Total Movimientos
Totalizadores2=SUMA(SerieLoteConsignacionAuxTemp:SerieLoteConsignacionAuxTemp.Cargo)<BR>SUMA(SerieLoteConsignacionAuxTemp:SerieLoteConsignacionAuxTemp.Abono)<BR>SUMA(SerieLoteConsignacionAuxTemp:SerieLoteConsignacionAuxTemp.Cargo-SerieLoteConsignacionAuxTemp:SerieLoteConsignacionAuxTemp.Abono)
Totalizadores3=(Cantidades)<BR>(Cantidades)<BR>(Cantidades)
Totalizadores=S
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S

TotCarpetaRenglones=Lista
ListaEnCaptura=(Lista)



TotAlCambiar=S


[(Carpeta Totalizadores).Entradas]
Carpeta=(Carpeta Totalizadores)
Clave=Entradas
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata

[(Carpeta Totalizadores).Salidas]
Carpeta=(Carpeta Totalizadores)
Clave=Salidas
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata



[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Entradas
Entradas=Salidas
Salidas=Total Movimientos
Total Movimientos=(Fin)

[(Carpeta Totalizadores).Total Movimientos]
Carpeta=(Carpeta Totalizadores)
Clave=Total Movimientos
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata













[Acciones.MostrarCampos]
Nombre=MostrarCampos
Boton=45
NombreEnBoton=S
NombreDesplegar=&Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S






[Lista.ListaEnCaptura]
(Inicio)=SerieLoteConsignacionAuxTemp.Mov
SerieLoteConsignacionAuxTemp.Mov=SerieLoteConsignacionAuxTemp.MovID
SerieLoteConsignacionAuxTemp.MovID=SerieLoteConsignacionAuxTemp.Fecha
SerieLoteConsignacionAuxTemp.Fecha=SerieLoteConsignacionAuxTemp.Articulo
SerieLoteConsignacionAuxTemp.Articulo=SerieLoteConsignacionAuxTemp.SubCuenta
SerieLoteConsignacionAuxTemp.SubCuenta=SerieLoteConsignacionAuxTemp.SerieLote
SerieLoteConsignacionAuxTemp.SerieLote=SerieLoteConsignacionAuxTemp.Cargo
SerieLoteConsignacionAuxTemp.Cargo=SerieLoteConsignacionAuxTemp.Abono
SerieLoteConsignacionAuxTemp.Abono=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Excel
Excel=MostrarCampos
MostrarCampos=(Fin)
