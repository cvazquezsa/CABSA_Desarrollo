[Forma]
Clave=ArtSub
Nombre=Datos a Nivel Opción
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=105
PosicionInicialArriba=198
PosicionInicialAltura=364
PosicionInicialAncho=813
Comentarios=Lista(Info.Articulo, Info.Descripcion)
PosicionInicialAlturaCliente=337

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtSub
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
HojaAjustarColumnas=S
FiltroGeneral=ArtSub.Articulo=<T>{Info.Articulo}<T>

[Lista.ArtSub.SubCuenta]
Carpeta=Lista
Clave=ArtSub.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtSub.CostoEstandar]
Carpeta=Lista
Clave=ArtSub.CostoEstandar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtSub.CostoReposicion]
Carpeta=Lista
Clave=ArtSub.CostoReposicion
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
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ArtSub:ArtSub.SubCuenta)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Lista.Columnas]
SubCuenta=124
CostoEstandar=80
CostoReposicion=89
OpcionDesc=222
Fabricante=101
ClaveFabricante=87
Horas=33
Minutos=41

[Lista.OpcionDesc]
Carpeta=Lista
Clave=OpcionDesc
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
ActivoCondicion=no ArtSub:ArtSub.TieneMovimientos
Visible=S

[Lista.ArtSub.Fabricante]
Carpeta=Lista
Clave=ArtSub.Fabricante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtSub.ClaveFabricante]
Carpeta=Lista
Clave=ArtSub.ClaveFabricante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtSub.Horas]
Carpeta=Lista
Clave=ArtSub.Horas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtSub.Minutos]
Carpeta=Lista
Clave=ArtSub.Minutos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Otros1]
Nombre=Otros1
TipoAccion=Expresion
Activo=N
Visible=N


[Lista.ListaEnCaptura]
(Inicio)=ArtSub.SubCuenta
ArtSub.SubCuenta=OpcionDesc
OpcionDesc=ArtSub.Fabricante
ArtSub.Fabricante=ArtSub.ClaveFabricante
ArtSub.ClaveFabricante=ArtSub.CostoEstandar
ArtSub.CostoEstandar=ArtSub.CostoReposicion
ArtSub.CostoReposicion=ArtSub.Horas
ArtSub.Horas=ArtSub.Minutos
ArtSub.Minutos=(Fin)


[Acciones.AnexoCtaSub]
Nombre=AnexoCtaSub
Boton=77
NombreDesplegar=Anexos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AnexoCtaSub
Activo=S
Visible=S





GuardarAntes=S
ConCondicion=S
Antes=S
DespuesGuardar=S
















EjecucionCondicion=(ConDatos(ArtSub:ArtSub.Articulo)) y (ConDatos(ArtSub:ArtSub.SubCuenta))
AntesExpresiones=Asigna(Info.Rama, <T>INV<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, ArtSub:ArtSub.Articulo)<BR>Asigna(Info.SubCuenta, ArtSub:ArtSub.SubCuenta)


[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=AnexoCtaSub
AnexoCtaSub=Otros1
Otros1=(Fin)
