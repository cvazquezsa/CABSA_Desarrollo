[Forma]
Clave=ProvArt
Nombre=Artículos del Proveedor
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=171
PosicionInicialArriba=219
PosicionInicialAltura=328
PosicionInicialAncho=682
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Proveedor
PosicionInicialAlturaCliente=296

[Lista]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtProv
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=Personalizar
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroGeneral=ArtProv.Proveedor=<T>{Info.Proveedor}<T>

[Lista.ArtProv.Clave]
Carpeta=Lista
Clave=ArtProv.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalles
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtProv
Fuente={MS Sans Serif, 8, Negro, []}
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

[Detalle.ArtProv.Proveedor]
Carpeta=Detalle
Clave=ArtProv.Proveedor
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.Prov.Nombre]
Carpeta=Detalle
Clave=Prov.Nombre
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Editar=S

[Detalle.ArtProv.Clave]
Carpeta=Detalle
Clave=ArtProv.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ArtProv.CostoAutorizado]
Carpeta=Detalle
Clave=ArtProv.CostoAutorizado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Detalle.ArtProv.UltimoCosto]
Carpeta=Detalle
Clave=ArtProv.UltimoCosto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20
EspacioPrevio=S

[Detalle.ArtProv.DiasRespuesta]
Carpeta=Detalle
Clave=ArtProv.DiasRespuesta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Lista.Columnas]
Proveedor=129
Nombre=311
Clave=127
Articulo=106
Descripcion1=146
0=90
1=139
UltimoCosto=64
UltimaCompra=79
SubCuenta=108

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
ConfirmarAntes=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Detalle.ArtProv.Articulo]
Carpeta=Detalle
Clave=ArtProv.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Detalle.Art.Descripcion1]
Carpeta=Detalle
Clave=Art.Descripcion1
Editar=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ArtProv.UltimaCompra]
Carpeta=Detalle
Clave=ArtProv.UltimaCompra
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Acciones.Personalizar]
Nombre=Personalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.ArtProv.UltimoCosto]
Carpeta=Lista
Clave=ArtProv.UltimoCosto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtProv.UltimaCompra]
Carpeta=Lista
Clave=ArtProv.UltimaCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ArtProv.SubCuenta]
Carpeta=Detalle
Clave=ArtProv.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFuente=Negro
ColorFondo=Blanco

[Detalle.OpcionDesc]
Carpeta=Detalle
Clave=OpcionDesc
Editar=S
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Lista.ArtProv.SubCuenta]
Carpeta=Lista
Clave=ArtProv.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtProv.Articulo]
Carpeta=Lista
Clave=ArtProv.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ArtProv.UltimaCotizacion]
Carpeta=Detalle
Clave=ArtProv.UltimaCotizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ArtProv.FechaCotizacion]
Carpeta=Detalle
Clave=ArtProv.FechaCotizacion
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ArtProvHist]
Nombre=ArtProvHist
Boton=51
NombreEnBoton=S
NombreDesplegar=&Histórico
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtProvHist
Activo=S
Visible=S
GuardarAntes=S
Antes=S
AntesExpresiones=Asigna(Info.Articulo, ArtProv:ArtProv.Articulo)<BR>Asigna(Info.SubCuenta, ArtProv:ArtProv.SubCuenta)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=ArtProvHist
ArtProvHist=Navegador
Navegador=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtProv.Articulo
ArtProv.Articulo=Art.Descripcion1
Art.Descripcion1=ArtProv.Clave
ArtProv.Clave=ArtProv.UltimoCosto
ArtProv.UltimoCosto=ArtProv.UltimaCompra
ArtProv.UltimaCompra=ArtProv.SubCuenta
ArtProv.SubCuenta=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=ArtProv.Proveedor
ArtProv.Proveedor=Prov.Nombre
Prov.Nombre=ArtProv.Articulo
ArtProv.Articulo=Art.Descripcion1
Art.Descripcion1=ArtProv.SubCuenta
ArtProv.SubCuenta=OpcionDesc
OpcionDesc=ArtProv.Clave
ArtProv.Clave=ArtProv.DiasRespuesta
ArtProv.DiasRespuesta=ArtProv.CostoAutorizado
ArtProv.CostoAutorizado=ArtProv.UltimoCosto
ArtProv.UltimoCosto=ArtProv.UltimaCompra
ArtProv.UltimaCompra=ArtProv.UltimaCotizacion
ArtProv.UltimaCotizacion=ArtProv.FechaCotizacion
ArtProv.FechaCotizacion=(Fin)
