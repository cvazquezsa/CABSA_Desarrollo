[Forma]
Clave=ProdRutaD
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=146
PosicionInicialArriba=185
PosicionInicialAltura=391
PosicionInicialAncho=732
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Nombre=<T>Ruta Producción<T>
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
Comentarios=Lista(Info.Ruta, Info.Descripcion)
PosicionInicialAlturaCliente=364

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProdRutaD
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
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=ProdRutaD.Orden<TAB>(Acendente)
FiltroGeneral=ProdRutaD.Ruta=<T>{Info.Ruta}<T>

[Lista.ProdRutaD.Operacion]
Carpeta=Lista
Clave=ProdRutaD.Operacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdRutaD.Centro]
Carpeta=Lista
Clave=ProdRutaD.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Operacion=131
Centro=82
Orden=37
Tipo=105
TiempoFijo=96
TiempoVariable=117
UnidadT=64
Costo=76
Moneda=52

[Lista.ProdRutaD.Orden]
Carpeta=Lista
Clave=ProdRutaD.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Centro.Tipo]
Carpeta=Lista
Clave=Centro.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ProdRutaD.TiempoFijo]
Carpeta=Lista
Clave=ProdRutaD.TiempoFijo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdRutaD.TiempoVariable]
Carpeta=Lista
Clave=ProdRutaD.TiempoVariable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdRutaD.Costo]
Carpeta=Lista
Clave=ProdRutaD.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdRutaD.Moneda]
Carpeta=Lista
Clave=ProdRutaD.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
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

[Acciones.CentroInfo]
Nombre=CentroInfo
Boton=34
NombreDesplegar=&Centro Trabajo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CentroInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
NombreEnBoton=S
EjecucionCondicion=ConDatos(ProdRutaD:ProdRutaD.Centro)
AntesExpresiones=Asigna(Info.Centro, ProdRutaD:ProdRutaD.Centro)

[Acciones.Operaciones]
Nombre=Operaciones
Boton=93
NombreEnBoton=S
NombreDesplegar=&Operaciones
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtOperacion
Activo=S
Visible=S
EspacioPrevio=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CentroInfo
CentroInfo=Operaciones
Operaciones=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProdRutaD.Orden
ProdRutaD.Orden=ProdRutaD.Centro
ProdRutaD.Centro=Centro.Tipo
Centro.Tipo=ProdRutaD.Operacion
ProdRutaD.Operacion=ProdRutaD.TiempoFijo
ProdRutaD.TiempoFijo=ProdRutaD.TiempoVariable
ProdRutaD.TiempoVariable=ProdRutaD.Costo
ProdRutaD.Costo=ProdRutaD.Moneda
ProdRutaD.Moneda=(Fin)
