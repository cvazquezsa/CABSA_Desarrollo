[Forma]
Clave=ArtProv
Nombre=Proveedores del Artículo
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=579
PosicionInicialArriba=384
PosicionInicialAltura=325
PosicionInicialAncho=762
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo, Info.Descripcion, Info.SubCuenta)
PosicionInicialAlturaCliente=404

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
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
FiltroGeneral=ArtProv.Articulo=<T>{Info.Articulo}<T><BR>{Si(ConDatos(Info.SubCuenta), <T> AND ArtProv.SubCuenta=<T>+Comillas(Info.SubCuenta), <T><T>)}

[Lista.Prov.Nombre]
Carpeta=Lista
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

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
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Prov.Nombre]
Carpeta=Detalle
Clave=Prov.Nombre
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro
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
EspacioPrevio=N

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

[Lista.Columnas]
Proveedor=88
Nombre=230
Clave=127
0=67
1=122
UltimoCosto=64
UltimaCompra=79
CostoAutorizado=87
SubCuenta=121

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
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.Art.Descripcion1]
Carpeta=Detalle
Clave=Art.Descripcion1
Editar=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.ArtProv.UltimaCompra]
Carpeta=Detalle
Clave=ArtProv.UltimaCompra
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
LineaNueva=N

[Detalle.ArtProv.DiasRespuesta]
Carpeta=Detalle
Clave=ArtProv.DiasRespuesta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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

[Detalle.OpcionDesc]
Carpeta=Detalle
Clave=OpcionDesc
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Lista.ArtProv.Proveedor]
Carpeta=Lista
Clave=ArtProv.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
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
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Acciones.ArtProvHist]
Nombre=ArtProvHist
Boton=51
NombreEnBoton=S
NombreDesplegar=&Histórico
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtProvHist
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
GuardarAntes=S
AntesExpresiones=Asigna(Info.SubCuenta, ArtProv:ArtProv.SubCuenta)<BR>Asigna(Info.Proveedor, ArtProv:ArtProv.Proveedor)

[Acciones.ArtProvSucursal]
Nombre=ArtProvSucursal
Boton=47
NombreEnBoton=S
NombreDesplegar=&Nivel Sucursal
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtProvSucursal
Antes=S
Visible=S
ConCondicion=S
ActivoCondicion=Config.ArtProvSucursalCompra
EjecucionCondicion=ConDatos(ArtProv:ArtProv.Proveedor)
AntesExpresiones=Asigna(Info.Proveedor, ArtProv:ArtProv.Proveedor)<BR>Asigna(Info.SubCuenta, ArtProv:ArtProv.SubCuenta)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=ArtProvSucursal
ArtProvSucursal=ArtProvHist
ArtProvHist=Navegador
Navegador=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtProv.Proveedor
ArtProv.Proveedor=Prov.Nombre
Prov.Nombre=ArtProv.Clave
ArtProv.Clave=ArtProv.UltimoCosto
ArtProv.UltimoCosto=ArtProv.UltimaCompra
ArtProv.UltimaCompra=ArtProv.SubCuenta
ArtProv.SubCuenta=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=ArtProv.Articulo
ArtProv.Articulo=Art.Descripcion1
Art.Descripcion1=ArtProv.SubCuenta
ArtProv.SubCuenta=OpcionDesc
OpcionDesc=ArtProv.Proveedor
ArtProv.Proveedor=Prov.Nombre
Prov.Nombre=ArtProv.Clave
ArtProv.Clave=ArtProv.DiasRespuesta
ArtProv.DiasRespuesta=ArtProv.CostoAutorizado
ArtProv.CostoAutorizado=ArtProv.UltimoCosto
ArtProv.UltimoCosto=ArtProv.UltimaCompra
ArtProv.UltimaCompra=ArtProv.UltimaCotizacion
ArtProv.UltimaCotizacion=ArtProv.FechaCotizacion
ArtProv.FechaCotizacion=(Fin)
