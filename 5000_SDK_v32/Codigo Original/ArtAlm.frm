[Forma]
Clave=ArtAlm
Nombre=<T>Artículo en Almacenes<T>
Icono=0
Modulos=INV
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
PosicionInicialIzquierda=185
PosicionInicialArriba=142
PosicionInicialAltura=422
PosicionInicialAncho=995
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionSeccion1=51
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo, Info.Descripcion)
PosicionColumna1=53
PosicionInicialAlturaCliente=404

[Hoja]
Estilo=Hoja
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtAlm
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
HojaAjustarColumnas=S
OtroOrden=S
ListaOrden=ArtAlm.Almacen<TAB>(Acendente)
ValidarCampos=S
ListaCamposAValidar=(Lista)

FiltroGeneral=ArtAlm.Empresa=<T>{Empresa}<T> AND ArtAlm.Articulo=<T>{Info.Articulo}<T>
[Hoja.ArtAlm.Almacen]
Carpeta=Hoja
Clave=ArtAlm.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Hoja.ArtAlm.Localizacion]
Carpeta=Hoja
Clave=ArtAlm.Localizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Hoja.ArtAlm.Minimo]
Carpeta=Hoja
Clave=ArtAlm.Minimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Hoja.ArtAlm.Maximo]
Carpeta=Hoja
Clave=ArtAlm.Maximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Hoja.ArtAlm.PuntoOrden]
Carpeta=Hoja
Clave=ArtAlm.PuntoOrden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Hoja.ArtAlm.PuntoOrdenOrdenar]
Carpeta=Hoja
Clave=ArtAlm.PuntoOrdenOrdenar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Hoja.Columnas]
Almacen=72
Localizacion=60
Minimo=121
Maximo=58
PuntoOrden=71
PuntoOrdenOrdenar=55
SubCuenta=97
Pasillo=54
Anaquel=55
Estante=54
LoteOrdenar=105
CantidadOrdenar=48
MultiplosOrdenar=45
ProrrateoCompra=104
CantidadOrdenarTiempo=111
AbastecimientoDirecto=114

MinimoTarima=71
ABC=51
VentaPromedio=81
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=Si
NombreDesplegar=&Guardar y cerrar
GuardarAntes=Si
EnBarraHerramientas=Si
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=Si
Visible=Si

[Hoja.ArtAlm.SubCuenta]
Carpeta=Hoja
Clave=ArtAlm.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
ActivoCondicion=no ArtAlm:ArtAlm.TieneMovimientos

[Ficha.ArtAlm.INV]
Carpeta=Ficha
Clave=ArtAlm.INV
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=15
EspacioPrevio=S

[Ficha.ArtAlm.CSG]
Carpeta=Ficha
Clave=ArtAlm.CSG
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=15

[Ficha.ArtAlm.RESV]
Carpeta=Ficha
Clave=ArtAlm.RESV
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=15

[Ficha.ArtAlm.VMOS]
Carpeta=Ficha
Clave=ArtAlm.VMOS
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=15

[Ficha.ArtAlm.GAR]
Carpeta=Ficha
Clave=ArtAlm.GAR
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=15
EspacioPrevio=S

[Ficha.ArtAlm.AF]
Carpeta=Ficha
Clave=ArtAlm.AF
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=15

[Ficha.Disponible]
Carpeta=Ficha
Clave=Disponible
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Tamano=15
EspacioPrevio=N

[Ficha.ArtAlm.Almacen]
Carpeta=Ficha
Clave=ArtAlm.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Alm.Nombre]
Carpeta=Ficha
Clave=Alm.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
EspacioPrevio=S

[Hoja.ArtAlm.Pasillo]
Carpeta=Hoja
Clave=ArtAlm.Pasillo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Hoja.ArtAlm.Anaquel]
Carpeta=Hoja
Clave=ArtAlm.Anaquel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Hoja.ArtAlm.Estante]
Carpeta=Hoja
Clave=ArtAlm.Estante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Hoja.ArtAlm.LoteOrdenar]
Carpeta=Hoja
Clave=ArtAlm.LoteOrdenar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Hoja.ArtAlm.CantidadOrdenar]
Carpeta=Hoja
Clave=ArtAlm.CantidadOrdenar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Hoja.ArtAlm.MultiplosOrdenar]
Carpeta=Hoja
Clave=ArtAlm.MultiplosOrdenar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Plan]
Nombre=Plan
Boton=88
NombreEnBoton=S
NombreDesplegar=&Plan
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Pantalla
ClaveAccion=PlanArtAlm
Activo=S
Visible=S
GuardarAntes=S
ConCondicion=S
EjecucionCondicion=ConDatos(ArtAlm:ArtAlm.Almacen)
Antes=S
AntesExpresiones=Asigna(Info.Almacen, ArtAlm:ArtAlm.Almacen)
DespuesGuardar=S

[Hoja.ArtAlm.CantidadOrdenarTiempo]
Carpeta=Hoja
Clave=ArtAlm.CantidadOrdenarTiempo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Hoja.ArtAlm.AbastecimientoDirecto]
Carpeta=Hoja
Clave=ArtAlm.AbastecimientoDirecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Hoja.ListaOrden]
(Inicio)=ArtAlm.Almacen<TAB>(Acendente)
ArtAlm.Almacen<TAB>(Acendente)=ArtAlm.SubCuenta<TAB>(Acendente)
ArtAlm.SubCuenta<TAB>(Acendente)=(Fin)




[Hoja.ArtAlm.MinimoTarima]
Carpeta=Hoja
Clave=ArtAlm.MinimoTarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[Hoja.ArtAlm.ABC]
Carpeta=Hoja
Clave=ArtAlm.ABC
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Hoja.ArtAlm.VentaPromedio]
Carpeta=Hoja
Clave=ArtAlm.VentaPromedio
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








[Hoja.ListaEnCaptura]
(Inicio)=ArtAlm.Almacen
ArtAlm.Almacen=ArtAlm.SubCuenta
ArtAlm.SubCuenta=ArtAlm.Localizacion
ArtAlm.Localizacion=ArtAlm.Pasillo
ArtAlm.Pasillo=ArtAlm.Anaquel
ArtAlm.Anaquel=ArtAlm.Estante
ArtAlm.Estante=ArtAlm.PuntoOrden
ArtAlm.PuntoOrden=ArtAlm.PuntoOrdenOrdenar
ArtAlm.PuntoOrdenOrdenar=ArtAlm.Maximo
ArtAlm.Maximo=ArtAlm.Minimo
ArtAlm.Minimo=ArtAlm.CantidadOrdenarTiempo
ArtAlm.CantidadOrdenarTiempo=ArtAlm.LoteOrdenar
ArtAlm.LoteOrdenar=ArtAlm.CantidadOrdenar
ArtAlm.CantidadOrdenar=ArtAlm.MultiplosOrdenar
ArtAlm.MultiplosOrdenar=ArtAlm.AbastecimientoDirecto
ArtAlm.AbastecimientoDirecto=ArtAlm.MinimoTarima
ArtAlm.MinimoTarima=ArtAlm.ABC
ArtAlm.ABC=ArtAlm.VentaPromedio
ArtAlm.VentaPromedio=(Fin)

[Hoja.ListaCamposAValidar]
(Inicio)=Alm.Nombre
Alm.Nombre=SubCuentaDesc
SubCuentaDesc=(Fin)

[Hoja.ArtAlm.MinimoTarima]
Carpeta=Hoja
Clave=ArtAlm.MinimoTarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Plan
Plan=(Fin)
