[Forma]
Clave=PCBoletin
Nombre=Boletín
Icono=17
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=97
PosicionInicialArriba=133
PosicionInicialAlturaCliente=468
PosicionInicialAncho=772
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov, Info.MovID, Info.Referencia)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PCBoletin
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
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
FiltroGrupo1=Art.Linea
FiltroGrupo2=Art.Grupo
PestanaOtroNombre=S
PestanaNombre=Artículos
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
FiltroGrupo3=Art.OrigenPais
FiltroGrupo4=Art.OrigenLocalidad
FiltroTodo=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
ValidarCampos=S
ListaCamposAValidar=Art.Descripcion1
FiltroGeneral=PCBoletin.ID={Info.ID}

[Lista.Columnas]
Articulo=117
PrecioLista=97
Precio2=81
CostoReposicion=86
Incentivo=64
Baja=62
0=117
1=108
Descripcion1=94
PrecioListaN=90
Precio2N=83
IncentivoN=78
CostoN=82
PrecioVolumenN=78

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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Lista.PCBoletin.Articulo]
Carpeta=Lista
Clave=PCBoletin.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PCBoletin.Baja]
Carpeta=Lista
Clave=PCBoletin.Baja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PCBoletin.PrecioListaN]
Carpeta=Lista
Clave=PCBoletin.PrecioListaN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PCBoletin.Precio2N]
Carpeta=Lista
Clave=PCBoletin.Precio2N
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PCBoletin.IncentivoN]
Carpeta=Lista
Clave=PCBoletin.IncentivoN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PCBoletin.CostoN]
Carpeta=Lista
Clave=PCBoletin.CostoN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PCBoletin.PrecioVolumenN]
Carpeta=Lista
Clave=PCBoletin.PrecioVolumenN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=PCBoletin.Articulo
PCBoletin.Articulo=PCBoletin.PrecioListaN
PCBoletin.PrecioListaN=PCBoletin.Precio2N
PCBoletin.Precio2N=PCBoletin.IncentivoN
PCBoletin.IncentivoN=PCBoletin.PrecioVolumenN
PCBoletin.PrecioVolumenN=PCBoletin.CostoN
PCBoletin.CostoN=PCBoletin.Baja
PCBoletin.Baja=(Fin)
