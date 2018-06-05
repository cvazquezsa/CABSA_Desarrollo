[Forma]
Clave=RepWMSProducto
Nombre=Existencia por Producto
Icono=18
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
AccionesTamanoBoton=25x5
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)
PosicionInicialIzquierda=517
PosicionInicialArriba=306
PosicionInicialAltura=211
PosicionInicialAncho=566
VentanaExclusiva=S
AccionesDivision=S
AccionesCentro=S
VentanaEscCerrar=S
BarraHerramientas=S
MovModulo=(Todos)
PosicionInicialAlturaCliente=250


VentanaEstadoInicial=Normal
ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spBorrarRepWMSProducto :tEstacionTrabajo<T>, EstacionTrabajo)
[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
ValidaNombre=S
3D=S
Tamano=20
LineaNueva=S
EspacioPrevio=N
ColorFondo=Blanco

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Acciones.RepPan.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S


[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreDesplegar=&Preliminar
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

GuardarAntes=S
Antes=S
AntesExpresiones=Asigna(Info.EstacionTrabajo, RepParam:RepParam.Estacion)<BR>Asigna(Rep.Titulo, RepParam:RepParam.RepTitulo)
[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S


[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S


GuardarAntes=S
Antes=S
AntesExpresiones=Asigna(Info.EstacionTrabajo, RepParam:RepParam.Estacion)<BR>Asigna(Rep.Titulo, RepParam:RepParam.RepTitulo)
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S




GuardarAntes=S
[(Variables).Info.TarimaD]
Carpeta=(Variables)
Clave=Info.TarimaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.TarimaA]
Carpeta=(Variables)
Clave=Info.TarimaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ArticuloD]
Carpeta=(Variables)
Clave=Info.ArticuloD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ArticuloA]
Carpeta=(Variables)
Clave=Info.ArticuloA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[(Variables).ListaEnCaptura]
(Inicio)=Info.TarimaD
Info.TarimaD=Info.TarimaA
Info.TarimaA=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.ArticuloD
Info.ArticuloD=Info.ArticuloA
Info.ArticuloA=(Fin)










[Lista.Columnas]
0=125
1=119
2=-2





Articulo=131
Descripcion1=244









Almacen=90
Nombre=229
Grupo=100
Sucursal=46
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

RefrescarAlEntrar=S


Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=RepParam.Estacion =  {EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General
[Ficha.RepParam.InfoFechaD]
Carpeta=Ficha
Clave=RepParam.InfoFechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoFechaA]
Carpeta=Ficha
Clave=RepParam.InfoFechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoArticuloD]
Carpeta=Ficha
Clave=RepParam.InfoArticuloD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoArticuloA]
Carpeta=Ficha
Clave=RepParam.InfoArticuloA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[Ficha.RepParam.InfoCaducidadD]
Carpeta=Ficha
Clave=RepParam.InfoCaducidadD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Ficha.RepParam.InfoCaducidadA]
Carpeta=Ficha
Clave=RepParam.InfoCaducidadA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20




[Ficha.RepParam.InfoAlmacenWMS]
Carpeta=Ficha
Clave=RepParam.InfoAlmacenWMS
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=S
[Ficha.RepParam.InfoOrdenWMS]
Carpeta=Ficha
Clave=RepParam.InfoOrdenWMS
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco































































[Ficha.RepParam.InfoEstatusTarima]
Carpeta=Ficha
Clave=RepParam.InfoEstatusTarima
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

















































[Ficha.RepParam.RepTitulo]
Carpeta=Ficha
Clave=RepParam.RepTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=59
ColorFondo=Blanco














[Ficha.RepParam.InfoArtCat]
Carpeta=Ficha
Clave=RepParam.InfoArtCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoArtFam]
Carpeta=Ficha
Clave=RepParam.InfoArtFam
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoArtGrupo]
Carpeta=Ficha
Clave=RepParam.InfoArtGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoArtFabricante]
Carpeta=Ficha
Clave=RepParam.InfoArtFabricante
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoArtLinea]
Carpeta=Ficha
Clave=RepParam.InfoArtLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




















[Acciones.Imprimir.RepWMSProducto]
Nombre=RepWMSProducto
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=RepWMSProducto
Activo=S
Visible=S


[Acciones.RepPan.RepWMSProducto]
Nombre=RepWMSProducto
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=RepWMSProducto
Activo=S
Visible=S


[Ficha.ListaEnCaptura]
(Inicio)=RepParam.InfoArticuloD
RepParam.InfoArticuloD=RepParam.InfoArticuloA
RepParam.InfoArticuloA=RepParam.InfoArtCat
RepParam.InfoArtCat=RepParam.InfoArtFam
RepParam.InfoArtFam=RepParam.InfoArtGrupo
RepParam.InfoArtGrupo=RepParam.InfoArtFabricante
RepParam.InfoArtFabricante=RepParam.InfoArtLinea
RepParam.InfoArtLinea=RepParam.InfoEstatusTarima
RepParam.InfoEstatusTarima=RepParam.InfoAlmacenWMS
RepParam.InfoAlmacenWMS=RepParam.InfoOrdenWMS
RepParam.InfoOrdenWMS=RepParam.InfoFechaD
RepParam.InfoFechaD=RepParam.InfoFechaA
RepParam.InfoFechaA=RepParam.InfoCaducidadD
RepParam.InfoCaducidadD=RepParam.InfoCaducidadA
RepParam.InfoCaducidadA=RepParam.RepTitulo
RepParam.RepTitulo=(Fin)


[Acciones.Imprimir.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=RepWMSProducto
RepWMSProducto=(Fin)


[Acciones.RepPan.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=RepWMSProducto
RepWMSProducto=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
