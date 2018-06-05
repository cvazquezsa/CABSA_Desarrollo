[Forma]
Clave=AspelSeries
Nombre=AspelSeries
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Articulo,Info.Descripcion)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=388
PosicionInicialArriba=295
PosicionInicialAlturaCliente=273
PosicionInicialAncho=664
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaEscCerrar=S

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Series
Clave=Lista
Filtros=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AspelSeries
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAutoCampo=AspelSeries.Almacen
FiltroAutoValidar=AspelSeries.Almacen
FiltroAutoOrden=AspelSeries.Almacen
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PermiteEditar=S
FiltroGeneral=AspelSeries.Articulo = <T>{Info.Articulo}<T>

[Lista.AspelSeries.Valor]
Carpeta=Lista
Clave=AspelSeries.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AspelSeries.Costo]
Carpeta=Lista
Clave=AspelSeries.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AspelSeries.UltimaEntrada]
Carpeta=Lista
Clave=AspelSeries.UltimaEntrada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AspelSeries.UltimaSalida]
Carpeta=Lista
Clave=AspelSeries.UltimaSalida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Valor=218
Costo=64
UltimaEntrada=94
UltimaSalida=94
Almacen=54

[Acciones.Cerrar]
Nombre=Cerrar
Boton=40
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.AspelSeries.Almacen]
Carpeta=Lista
Clave=AspelSeries.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.InsertaSerie]
Nombre=InsertaSerie
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
Expresion=EJECUTARSQL(<T>SpAspelInsertaSerie :tArticulo<T>,Info.Articulo)<BR> GuardarCambios <BR>ActualizarForma

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=InsertaSerie
InsertaSerie=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=AspelSeries.Valor
AspelSeries.Valor=AspelSeries.Costo
AspelSeries.Costo=AspelSeries.Almacen
AspelSeries.Almacen=AspelSeries.UltimaEntrada
AspelSeries.UltimaEntrada=AspelSeries.UltimaSalida
AspelSeries.UltimaSalida=(Fin)
